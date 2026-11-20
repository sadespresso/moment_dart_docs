import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart' show GoRouterHelper;
import 'package:material_ui/material_ui.dart';

import '../docs/model.dart';
import '../docs/registry.dart';
import '../theme.dart';
import 'blocks.dart';
import 'footer.dart';
import 'inline.dart';

class DocPageView extends StatefulWidget {
  final DocPage page;
  final String? fragment;

  const DocPageView({super.key, required this.page, this.fragment});

  @override
  State<DocPageView> createState() => _DocPageViewState();
}

class _DocPageViewState extends State<DocPageView> {
  final ScrollController _scroll = ScrollController();
  late List<Block> _blocks;
  late Map<Block, GlobalKey> _anchors;
  final ValueNotifier<Block?> _current = ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _load();
    _scroll.addListener(_trackSection);
  }

  @override
  void didUpdateWidget(DocPageView old) {
    super.didUpdateWidget(old);
    if (old.page != widget.page) {
      _load();
      if (_scroll.hasClients) _scroll.jumpTo(0);
    } else if (old.fragment != widget.fragment) {
      _jumpToFragment();
    }
  }

  void _load() {
    _blocks = widget.page.blocks();
    _anchors = {
      for (final b in _blocks)
        if (b is H2 || b is H3) b: GlobalKey(),
    };
    _current.value = null;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _jumpToFragment();
      // Fonts can finish loading after the first frame and move the heading
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) _jumpToFragment();
      });
    });
  }

  void _jumpToFragment() {
    final String? f = widget.fragment;
    if (f == null || f.isEmpty) return;
    for (final MapEntry<Block, GlobalKey> e in _anchors.entries) {
      final String text = e.key is H2 ? (e.key as H2).text : (e.key as H3).text;
      if (slugify(text) == f) {
        _scrollTo(e.key, animate: false);
        return;
      }
    }
  }

  void _scrollTo(Block anchor, {bool animate = true}) {
    final BuildContext? ctx = _anchors[anchor]?.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: animate ? const Duration(milliseconds: 280) : Duration.zero,
      curve: Curves.easeOutCubic,
      alignment: 0.02,
    );
  }

  void _trackSection() {
    Block? current;
    for (final MapEntry<Block, GlobalKey> e in _anchors.entries) {
      final RenderObject? box = e.value.currentContext?.findRenderObject();
      if (box is! RenderBox || !box.attached) continue;
      final double y = box.localToGlobal(Offset.zero).dy;
      if (y < 160) current = e.key;
    }
    _current.value = current;
  }

  @override
  void dispose() {
    _scroll.dispose();
    _current.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final double width = MediaQuery.sizeOf(context).width;
    final bool showToc = width >= Breakpoints.toc && _anchors.length > 1;
    final bool narrow = width < 600;
    final int index = docPages.indexOf(widget.page);

    final Widget article = ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 780),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          narrow ? 18 : 48,
          narrow ? 28 : 52,
          narrow ? 18 : 48,
          0,
        ),
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.page.group,
                style: Txt.small(p).copyWith(color: p.faint),
              ),
              const SizedBox(height: 6),
              Text(
                widget.page.title,
                style: Txt.h1(p).copyWith(fontSize: narrow ? 34 : 44),
              ),
              const SizedBox(height: 14),
              Inline(widget.page.summary, style: Txt.lead(p)),
              const SizedBox(height: 10),
              for (final b in _blocks) BlockView(b, anchors: _anchors),
              const SizedBox(height: 56),
              _PrevNext(index: index),
            ],
          ),
        ),
      ),
    );

    return Title(
      title: "${widget.page.title} | moment_dart",
      color: p.ink,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Scrollbar(
              controller: _scroll,
              child: SingleChildScrollView(
                controller: _scroll,
                child: Column(
                  children: [
                    Align(alignment: Alignment.topCenter, child: article),
                    const SizedBox(height: 40),
                    const Footer(),
                  ],
                ),
              ),
            ),
          ),
          if (showToc)
            SizedBox(
              width: 250,
              child: _Outline(
                anchors: _anchors.keys.toList(),
                current: _current,
                onTap: _scrollTo,
              ),
            ),
        ],
      ),
    );
  }
}

class _Outline extends StatelessWidget {
  final List<Block> anchors;
  final ValueListenable<Block?> current;
  final void Function(Block) onTap;

  const _Outline({
    required this.anchors,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 56, 24, 24),
      child: ValueListenableBuilder(
        valueListenable: current,
        builder: (context, active, _) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 10),
              child: Text(
                "On this page",
                style: Txt.small(p).copyWith(
                  fontWeight: FontWeight.w600,
                  color: p.faint,
                  fontSize: 13,
                ),
              ),
            ),
            for (final a in anchors)
              _OutlineItem(
                text: a is H2 ? a.text : (a as H3).text,
                nested: a is H3,
                active: a == (active ?? anchors.first),
                onTap: () => onTap(a),
              ),
          ],
        ),
      ),
    );
  }
}

class _OutlineItem extends StatelessWidget {
  final String text;
  final bool nested;
  final bool active;
  final VoidCallback onTap;

  const _OutlineItem({
    required this.text,
    required this.nested,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.fromLTRB(nested ? 26 : 14, 5, 0, 5),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: active ? p.hand : p.line,
                width: active ? 2 : 1,
              ),
            ),
          ),
          child: Text(
            text.replaceAll("`", ""),
            style: Txt.small(p).copyWith(
              fontSize: 13.5,
              color: active ? p.ink : p.muted,
              fontWeight: active ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _PrevNext extends StatelessWidget {
  final int index;
  const _PrevNext({required this.index});

  @override
  Widget build(BuildContext context) {
    final DocPage? prev = index > 0 ? docPages[index - 1] : null;
    final DocPage? next = index >= 0 && index < docPages.length - 1
        ? docPages[index + 1]
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool stack = constraints.maxWidth < 520;
        final List<Widget> cards = [
          if (prev != null) _PageLink(page: prev, label: "Previous"),
          if (next != null) _PageLink(page: next, label: "Next", end: true),
        ];
        if (stack) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final c in cards)
                Padding(padding: const EdgeInsets.only(bottom: 12), child: c),
            ],
          );
        }
        return Row(
          children: [
            Expanded(child: prev != null ? cards.first : const SizedBox()),
            const SizedBox(width: 16),
            Expanded(child: next != null ? cards.last : const SizedBox()),
          ],
        );
      },
    );
  }
}

class _PageLink extends StatelessWidget {
  final DocPage page;
  final String label;
  final bool end;

  const _PageLink({required this.page, required this.label, this.end = false});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        hoverColor: p.surface,
        onTap: () => context.go(page.path),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: p.line),
          ),
          child: Column(
            crossAxisAlignment: end
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(label, style: Txt.small(p).copyWith(fontSize: 13)),
              const SizedBox(height: 2),
              Text(
                page.title,
                style: Txt.ui(p).copyWith(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  color: p.link,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
