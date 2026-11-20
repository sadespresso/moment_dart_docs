import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../docs/model.dart';
import '../docs/state.dart';
import '../theme.dart';
import 'highlight.dart';

/// The frame shared by static and live code: a title row and a copy button.
class CodeFrame extends StatelessWidget {
  final String? title;
  final Widget? badge;
  final String Function() copyText;
  final Widget child;

  const CodeFrame({
    super.key,
    this.title,
    this.badge,
    required this.copyText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final bool hasHeader = title != null || badge != null;

    final Widget body = SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(18, 14, hasHeader ? 18 : 52, 16),
      child: child,
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: p.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasHeader
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 38,
                  padding: const EdgeInsets.only(left: 16, right: 4),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: p.line)),
                  ),
                  child: Row(
                    children: [
                      if (badge != null) ...[badge!, const SizedBox(width: 12)],
                      Expanded(
                        child: Text(
                          title ?? "",
                          style: Txt.small(p).copyWith(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CopyButton(text: copyText),
                    ],
                  ),
                ),
                body,
              ],
            )
          : Stack(
              children: [
                body,
                Positioned(
                  top: 6,
                  right: 6,
                  child: CopyButton(text: copyText, compact: true),
                ),
              ],
            ),
    );
  }
}

class CopyButton extends StatefulWidget {
  final String Function() text;

  /// Icon only, on an opaque background so it can float over code.
  final bool compact;
  const CopyButton({super.key, required this.text, this.compact = false});

  @override
  State<CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<CopyButton> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.text()));
    if (!mounted) return;
    setState(() => _copied = true);
    await Future.delayed(const Duration(milliseconds: 1400));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    if (widget.compact) {
      return Material(
        color: p.surface,
        borderRadius: BorderRadius.circular(8),
        child: IconButton(
          tooltip: _copied ? "Copied" : "Copy",
          onPressed: _copy,
          visualDensity: VisualDensity.compact,
          iconSize: 16,
          color: _copied ? p.tip : p.faint,
          icon: Icon(_copied ? Icons.check_rounded : Icons.copy_rounded),
        ),
      );
    }
    return TextButton.icon(
      onPressed: _copy,
      style: TextButton.styleFrom(
        foregroundColor: _copied ? p.tip : p.muted,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        minimumSize: const Size(0, 30),
        textStyle: Txt.small(p).copyWith(fontSize: 13),
      ),
      icon: Icon(_copied ? Icons.check_rounded : Icons.copy_rounded, size: 15),
      label: Text(_copied ? "Copied" : "Copy"),
    );
  }
}

class CodeView extends StatelessWidget {
  final Code block;
  const CodeView(this.block, {super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return CodeFrame(
      title: block.title,
      copyText: () => block.code,
      child: Text.rich(
        TextSpan(
          style: Txt.mono(p),
          children: highlight(block.code, block.lang, p),
        ),
      ),
    );
  }
}

/// A small amber clock hand: marks code whose output is computed right now.
class LiveBadge extends StatelessWidget {
  const LiveBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Tooltip(
      message:
          "Results are computed in your browser, "
          "in ${localeState.value} and ${localOffset()}",
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomPaint(size: const Size(14, 14), painter: _HandPainter(p)),
          const SizedBox(width: 6),
          Text(
            "Live",
            style: Txt.small(p).copyWith(
              fontSize: 13,
              color: p.output,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _HandPainter extends CustomPainter {
  final Palette p;
  _HandPainter(this.p);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = size.width / 2 - 1;
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = p.hand,
    );
    final Paint hand = Paint()
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..color = p.hand;
    canvas.drawLine(c, c + Offset(0, -r + 2.5), hand);
    canvas.drawLine(c, c + Offset(r - 3.5, 0), hand);
  }

  @override
  bool shouldRepaint(_HandPainter old) => old.p != p;
}

class LiveView extends StatelessWidget {
  final Live block;
  const LiveView(this.block, {super.key});

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => LiveBuilder(
      tick: block.tick,
      builder: (context) {
        final List<_Evaluated> lines = [
          for (final Line line in block.lines) _Evaluated.of(line),
        ];
        return CodeFrame(
          title: block.title,
          badge: const LiveBadge(),
          copyText: () => _copyText(lines),
          child: _LiveLines(
            lines,
            maxChars: ((constraints.maxWidth - 38) / _charWidth).floor(),
          ),
        );
      },
    ),
  );

  /// Advance width of Cascadia Code at the code size, in logical pixels.
  static const double _charWidth = 14.5 * 0.586;

  static String _copyText(List<_Evaluated> lines) => lines
      .map((e) => e.result == null ? e.code : "${e.code} // ${e.result}")
      .join("\n");
}

class _Evaluated {
  final String code;
  final String? result;
  final bool threw;

  const _Evaluated(this.code, this.result, this.threw);

  factory _Evaluated.of(Line line) {
    if (line.eval == null) return _Evaluated(line.code, null, false);
    try {
      return _Evaluated(line.code, describe(line.eval!()), false);
    } catch (e) {
      return _Evaluated(line.code, "throws ${describeError(e)}", true);
    }
  }
}

class _LiveLines extends StatelessWidget {
  final List<_Evaluated> lines;

  /// How many monospace characters fit before the block scrolls sideways.
  final int maxChars;
  const _LiveLines(this.lines, {required this.maxChars});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final TextStyle mono = Txt.mono(p);
    final int width = lines
        .where((e) => e.result != null && !e.code.contains("\n"))
        .fold(0, (w, e) => e.code.length > w ? e.code.length : w);
    final int column = width.clamp(0, 46);

    final List<Widget> rows = [];
    for (final _Evaluated e in lines) {
      final List<InlineSpan> code = highlightDart(e.code, p);
      if (e.result == null) {
        rows.add(Text.rich(TextSpan(style: mono, children: code)));
        continue;
      }

      final TextStyle out = mono.copyWith(
        color: e.threw ? p.warning : p.output,
        fontWeight: FontWeight.w600,
      );

      if (containsMongolian(e.result!)) {
        rows.add(Text.rich(TextSpan(style: mono, children: code)));
        rows.add(MongolianOutput(e.result!, style: out));
        continue;
      }

      final bool inline =
          !e.code.contains("\n") &&
          e.code.length <= column &&
          column + 5 + e.result!.length <= maxChars;
      if (inline) {
        rows.add(
          Text.rich(
            TextSpan(
              style: mono,
              children: [
                ...code,
                TextSpan(text: " " * (column - e.code.length + 2)),
                TextSpan(text: "// ${e.result}", style: out),
              ],
            ),
          ),
        );
      } else {
        rows.add(Text.rich(TextSpan(style: mono, children: code)));
        rows.add(Text("// ${e.result}", style: out));
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }
}

/// Traditional Mongolian runs top to bottom. Flutter only lays text out
/// horizontally, so the line is drawn sideways and turned a quarter clockwise;
/// Mongolian fonts are designed for exactly that.
class MongolianOutput extends StatelessWidget {
  final String text;
  final TextStyle style;

  const MongolianOutput(this.text, {super.key, required this.style});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 6, bottom: 6, left: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("//", style: style),
        const SizedBox(width: 8),
        RotatedBox(
          quarterTurns: 1,
          child: Text(
            text,
            style: style.copyWith(
              fontFamily: mongolFont,
              fontFamilyFallback: const [monoFont],
              fontWeight: FontWeight.w400,
              fontSize: 17,
              height: 1.3,
            ),
          ),
        ),
      ],
    ),
  );
}
