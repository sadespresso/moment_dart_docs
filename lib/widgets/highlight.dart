import 'package:material_ui/material_ui.dart';

import '../theme.dart';

const Set<String> _keywords = {
  "abstract",
  "as",
  "assert",
  "async",
  "await",
  "base",
  "break",
  "case",
  "catch",
  "class",
  "const",
  "continue",
  "default",
  "else",
  "enum",
  "export",
  "extends",
  "extension",
  "factory",
  "false",
  "final",
  "for",
  "get",
  "if",
  "implements",
  "import",
  "in",
  "is",
  "late",
  "mixin",
  "new",
  "null",
  "on",
  "override",
  "required",
  "return",
  "sealed",
  "set",
  "static",
  "super",
  "switch",
  "this",
  "throw",
  "true",
  "try",
  "typedef",
  "var",
  "void",
  "when",
  "while",
  "with",
  "yield",
  "show",
  "hide",
  "part",
  "of",
};

const Set<String> _builtinTypes = {"int", "double", "bool", "num", "dynamic"};

final RegExp _dartToken = RegExp(
  r"(//[^\n]*)"
  r"|(/\*[\s\S]*?\*/)"
  r"|(r?'''[\s\S]*?'''|r?"
  '"""'
  r'[\s\S]*?"""'
  r")"
  r"|(r?'(?:\\.|[^'\\\n])*'|r?"
  '"(?:\\\\.|[^"\\\\\\n])*"'
  r")"
  r"|(@[A-Za-z_]\w*)"
  r"|(\b\d[\d_]*(?:\.\d+)?(?:e[+-]?\d+)?\b)"
  r"|([A-Za-z_$][\w$]*)",
);

/// Splits Dart source into colored spans. Good enough for documentation
/// snippets; it doesn't try to understand string interpolation.
List<TextSpan> highlightDart(String source, Palette p) {
  final List<TextSpan> spans = [];
  int last = 0;

  for (final RegExpMatch m in _dartToken.allMatches(source)) {
    if (m.start > last) {
      spans.add(TextSpan(text: source.substring(last, m.start)));
    }
    final String text = m[0]!;
    TextStyle? style;

    if (m[1] != null || m[2] != null) {
      style = TextStyle(color: p.comment);
    } else if (m[3] != null || m[4] != null) {
      style = TextStyle(color: p.string);
    } else if (m[5] != null) {
      style = TextStyle(color: p.keyword);
    } else if (m[6] != null) {
      style = TextStyle(color: p.number);
    } else if (m[7] != null) {
      if (_keywords.contains(text)) {
        style = TextStyle(color: p.keyword);
      } else if (_builtinTypes.contains(text) ||
          text.codeUnitAt(0) >= 0x41 && text.codeUnitAt(0) <= 0x5A) {
        style = TextStyle(color: p.typeColor);
      }
    }

    spans.add(TextSpan(text: text, style: style));
    last = m.end;
  }

  if (last < source.length) spans.add(TextSpan(text: source.substring(last)));
  return spans;
}

final RegExp _shellComment = RegExp(r"(#[^\n]*)");

List<TextSpan> highlight(String source, String lang, Palette p) {
  switch (lang) {
    case "dart":
      return highlightDart(source, p);
    case "sh":
    case "yaml":
      final List<TextSpan> spans = [];
      int last = 0;
      for (final RegExpMatch m in _shellComment.allMatches(source)) {
        if (m.start > last) {
          spans.add(TextSpan(text: source.substring(last, m.start)));
        }
        spans.add(
          TextSpan(
            text: m[0],
            style: TextStyle(color: p.comment),
          ),
        );
        last = m.end;
      }
      if (last < source.length) {
        spans.add(TextSpan(text: source.substring(last)));
      }
      return spans;
    default:
      return [TextSpan(text: source)];
  }
}
