import 'package:flutter/gestures.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme.dart';

final RegExp _inline = RegExp(
  r"`([^`]+)`|\*\*(.+?)\*\*|\[([^\]]+)\]\(([^)\s]+)\)",
);

/// Text with `code`, **bold** and [links](/internal or https://external).
class Inline extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const Inline(this.text, {super.key, this.style});

  @override
  State<Inline> createState() => _InlineState();
}

class _InlineState extends State<Inline> {
  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final r in _recognizers) {
      r.dispose();
    }
    super.dispose();
  }

  void _open(String href) {
    if (href.startsWith("/")) {
      context.go(href);
    } else {
      launchUrl(Uri.parse(href));
    }
  }

  @override
  Widget build(BuildContext context) {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();

    final Palette p = context.palette;
    final TextStyle base = widget.style ?? Txt.body(p);
    return Text.rich(TextSpan(style: base, children: _spans(p, base)));
  }

  List<InlineSpan> _spans(Palette p, TextStyle base) {
    final List<InlineSpan> spans = [];
    final String text = widget.text;
    int last = 0;

    for (final RegExpMatch m in _inline.allMatches(text)) {
      if (m.start > last) {
        spans.add(TextSpan(text: text.substring(last, m.start)));
      }

      if (m[1] != null) {
        spans.add(codeSpan(m[1]!, p, base));
      } else if (m[2] != null) {
        spans.add(
          TextSpan(
            text: m[2],
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      } else {
        final String label = m[3]!;
        final String href = m[4]!;
        final TapGestureRecognizer r = TapGestureRecognizer()
          ..onTap = () => _open(href);
        _recognizers.add(r);
        final bool isCode = label.startsWith("`") && label.endsWith("`");
        spans.add(
          TextSpan(
            text: isCode ? label.substring(1, label.length - 1) : label,
            recognizer: r,
            mouseCursor: SystemMouseCursors.click,
            style: TextStyle(
              color: p.link,
              fontFamily: isCode ? monoFont : null,
              fontSize: isCode ? (base.fontSize ?? 16) * 0.88 : null,
              decoration: TextDecoration.underline,
              decorationColor: p.link.withValues(alpha: 0.35),
              decorationThickness: 1.5,
            ),
          ),
        );
      }
      last = m.end;
    }

    if (last < text.length) spans.add(TextSpan(text: text.substring(last)));
    return spans;
  }
}

TextSpan codeSpan(String code, Palette p, TextStyle base) => TextSpan(
  text: code,
  style: TextStyle(
    fontFamily: monoFont,
    fontFamilyFallback: monoFallback,
    fontSize: (base.fontSize ?? 16) * 0.88,
    color: p.ink,
    backgroundColor: p.sunken,
  ),
);
