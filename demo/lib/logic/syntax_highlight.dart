import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

class SyntaxHighlighter {
  static SyntaxHighlighter? instance;

  bool _initialized = false;

  factory SyntaxHighlighter() {
    instance ??= SyntaxHighlighter._internal();
    return instance!;
  }

  SyntaxHighlighter._internal();

  late final HighlighterTheme darkTheme;
  late final HighlighterTheme lightTheme;

  late Highlighter highlighter;

  Future<void> init([Brightness brightness = Brightness.light]) async {
    if (_initialized) return;

    await Highlighter.initialize(["dart"]);

    darkTheme = await HighlighterTheme.loadDarkTheme();
    lightTheme = await HighlighterTheme.loadLightTheme();

    updateTheme(brightness);

    _initialized = true;
  }

  void updateTheme(Brightness brightness) {
    highlighter = Highlighter(
      language: 'dart',
      theme: brightness == Brightness.dark ? darkTheme : lightTheme,
    );
  }

  TextSpan highlight(String code) => highlighter.highlight(code);
}
