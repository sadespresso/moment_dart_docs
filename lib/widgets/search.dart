import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart' show GoRouter;
import 'package:material_ui/material_ui.dart';

import '../docs/model.dart';
import '../docs/registry.dart';
import '../theme.dart';

class SearchEntry {
  final String title;
  final String page;
  final String location;
  final String haystack;
  final bool isPage;

  SearchEntry({
    required this.title,
    required this.page,
    required this.location,
    required String text,
    required this.isPage,
  }) : haystack = text.toLowerCase();
}

List<SearchEntry>? _index;

String _plain(String markup) => markup
    .replaceAllMapped(RegExp(r"\[([^\]]+)\]\([^)]+\)"), (m) => m[1]!)
    .replaceAll(RegExp(r"`|\*\*"), "");

List<SearchEntry> searchIndex() => _index ??= _buildIndex();

List<SearchEntry> _buildIndex() {
  final List<SearchEntry> entries = [];

  void collect(List<Block> blocks, StringBuffer into) {
    for (final b in blocks) {
      switch (b) {
        case P p:
          into.write(" ${_plain(p.text)}");
        case Bullets bl:
          into.write(" ${bl.items.map(_plain).join(" ")}");
        case Code code:
          into.write(" ${code.code}");
        case Live live:
          into.write(" ${live.lines.map((l) => l.code).join(" ")}");
        case Note n:
          collect(n.children, into);
        case TableBlock t:
          for (final row in t.rows) {
            into.write(" ${row.whereType<String>().map(_plain).join(" ")}");
          }
        case Embed e:
          into.write(" ${e.searchText}");
        case H2() || H3():
          break;
      }
    }
  }

  for (final page in docPages) {
    final List<Block> blocks = page.blocks();
    final StringBuffer pageText = StringBuffer("${page.title} ${page.summary}");
    final int pageIndex = entries.length;

    String? heading;
    StringBuffer section = StringBuffer();
    List<Block> pending = [];

    void flush() {
      if (heading == null) return;
      collect(pending, section);
      entries.add(
        SearchEntry(
          title: _plain(heading),
          page: page.title,
          location: "${page.path}#${slugify(heading)}",
          text: "${_plain(heading)} $section",
          isPage: false,
        ),
      );
    }

    for (final b in blocks) {
      if (b is H2 || b is H3) {
        flush();
        heading = b is H2 ? b.text : (b as H3).text;
        section = StringBuffer();
        pending = [];
      } else if (heading == null) {
        collect([b], pageText);
      } else {
        pending.add(b);
      }
    }
    flush();

    entries.insert(
      pageIndex,
      SearchEntry(
        title: page.title,
        page: page.group,
        location: page.path,
        text: pageText.toString(),
        isPage: true,
      ),
    );
  }
  return entries;
}

List<SearchEntry> search(String query) {
  final List<String> words = query
      .toLowerCase()
      .split(RegExp(r"\s+"))
      .where((w) => w.isNotEmpty)
      .toList();
  if (words.isEmpty) {
    return searchIndex().where((e) => e.isPage).toList();
  }

  final List<(int, SearchEntry)> scored = [];
  for (final e in searchIndex()) {
    if (!words.every(e.haystack.contains)) continue;
    final String title = e.title.toLowerCase();
    int score = 0;
    for (final w in words) {
      if (title.contains(w)) score += 10;
      if (title.startsWith(w)) score += 5;
    }
    if (e.isPage) score += 3;
    scored.add((score, e));
  }
  scored.sort((a, b) => b.$1.compareTo(a.$1));
  return scored.map((s) => s.$2).take(30).toList();
}

Future<void> showSearchPalette(BuildContext context) => showDialog(
  context: context,
  barrierColor: Colors.black.withValues(alpha: 0.35),
  builder: (_) => const SearchPalette(),
);

class SearchPalette extends StatefulWidget {
  const SearchPalette({super.key});

  @override
  State<SearchPalette> createState() => _SearchPaletteState();
}

class _SearchPaletteState extends State<SearchPalette> {
  final TextEditingController _query = TextEditingController();
  final ScrollController _scroll = ScrollController();
  List<SearchEntry> _results = search("");
  int _selected = 0;

  @override
  void dispose() {
    _query.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _open(SearchEntry e) {
    Navigator.of(context).pop();
    GoRouter.of(context).go(e.location);
  }

  void _move(int delta) {
    if (_results.isEmpty) return;
    setState(() {
      _selected = (_selected + delta).clamp(0, _results.length - 1);
    });
    final double target = _selected * 58.0;
    if (target < _scroll.offset) {
      _scroll.jumpTo(target);
    } else if (target + 58 >
        _scroll.offset + _scroll.position.viewportDimension) {
      _scroll.jumpTo(target + 58 - _scroll.position.viewportDimension);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return Align(
      alignment: const Alignment(0, -0.6),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620, maxHeight: 520),
          child: Material(
            color: p.surface,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CallbackShortcuts(
                  bindings: {
                    const SingleActivator(LogicalKeyboardKey.arrowDown): () =>
                        _move(1),
                    const SingleActivator(LogicalKeyboardKey.arrowUp): () =>
                        _move(-1),
                  },
                  child: TextField(
                    controller: _query,
                    autofocus: true,
                    style: Txt.ui(p).copyWith(fontSize: 17),
                    cursorColor: p.hand,
                    decoration: InputDecoration(
                      hintText: "Search for a method, token or topic",
                      hintStyle: Txt.ui(p).copyWith(
                        fontSize: 17,
                        color: p.faint,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Icon(Icons.search_rounded, color: p.faint),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    onChanged: (q) => setState(() {
                      _results = search(q);
                      _selected = 0;
                      if (_scroll.hasClients) _scroll.jumpTo(0);
                    }),
                    onSubmitted: (_) {
                      if (_results.isNotEmpty) _open(_results[_selected]);
                    },
                  ),
                ),
                Divider(height: 1, color: p.line),
                Flexible(
                  child: _results.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(28),
                          child: Text(
                            "Nothing matches \"${_query.text}\". Try a method "
                            "name like fromNow, or a token like LLL.",
                            style: Txt.small(p),
                          ),
                        )
                      : ListView.builder(
                          controller: _scroll,
                          shrinkWrap: true,
                          itemExtent: 58,
                          itemCount: _results.length,
                          itemBuilder: (context, i) {
                            final SearchEntry e = _results[i];
                            final bool selected = i == _selected;
                            return InkWell(
                              onTap: () => _open(e),
                              onHover: (h) {
                                if (h) setState(() => _selected = i);
                              },
                              child: Container(
                                color: selected ? p.sunken : null,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      e.isPage
                                          ? Icons.article_outlined
                                          : Icons.tag_rounded,
                                      size: 18,
                                      color: selected ? p.hand : p.faint,
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.title,
                                            style: Txt.ui(p),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            e.page,
                                            style: Txt.small(p)
                                                .copyWith(fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (selected)
                                      Icon(
                                        Icons.keyboard_return_rounded,
                                        size: 16,
                                        color: p.faint,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
