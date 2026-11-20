import 'package:material_ui/material_ui.dart';

const String textFont = "Bricolage Text";
const String displayFont = "Bricolage Display";
const String monoFont = "Cascadia Code";
const String mongolFont = "Noto Sans Mongolian";

const List<String> monoFallback = [mongolFont];

@immutable
class Palette extends ThemeExtension<Palette> {
  final Color background;
  final Color surface;
  final Color sunken;
  final Color ink;
  final Color muted;
  final Color faint;
  final Color line;
  final Color hand;
  final Color output;
  final Color link;
  final Color keyword;
  final Color typeColor;
  final Color string;
  final Color number;
  final Color comment;
  final Color tip;
  final Color warning;

  const Palette({
    required this.background,
    required this.surface,
    required this.sunken,
    required this.ink,
    required this.muted,
    required this.faint,
    required this.line,
    required this.hand,
    required this.output,
    required this.link,
    required this.keyword,
    required this.typeColor,
    required this.string,
    required this.number,
    required this.comment,
    required this.tip,
    required this.warning,
  });

  static const Palette light = Palette(
    background: Color(0xFFF4F5F9),
    surface: Color(0xFFFFFFFF),
    sunken: Color(0xFFEBEDF4),
    ink: Color(0xFF161A33),
    muted: Color(0xFF555B7D),
    faint: Color(0xFF8A8FAB),
    line: Color(0xFFDDE0EB),
    hand: Color(0xFFE29A12),
    output: Color(0xFF8F5400),
    link: Color(0xFF3442B8),
    keyword: Color(0xFF7232BE),
    typeColor: Color(0xFF1C64A6),
    string: Color(0xFF26724A),
    number: Color(0xFFAE3F17),
    comment: Color(0xFF7D839F),
    tip: Color(0xFF2B7A6B),
    warning: Color(0xFFB4521A),
  );

  static const Palette dark = Palette(
    background: Color(0xFF0E1124),
    surface: Color(0xFF151933),
    sunken: Color(0xFF1B2040),
    ink: Color(0xFFE8EAF6),
    muted: Color(0xFFA2A8CB),
    faint: Color(0xFF6E7499),
    line: Color(0xFF272C50),
    hand: Color(0xFFF2B33D),
    output: Color(0xFFF2B33D),
    link: Color(0xFFA3AEFF),
    keyword: Color(0xFFC6A8FF),
    typeColor: Color(0xFF7FC6FF),
    string: Color(0xFF93D9AC),
    number: Color(0xFFFFB085),
    comment: Color(0xFF737AA3),
    tip: Color(0xFF6FD1BC),
    warning: Color(0xFFFFA36B),
  );

  @override
  Palette copyWith() => this;

  @override
  Palette lerp(Palette? other, double t) => t < 0.5 ? this : (other ?? this);
}

extension PaletteContext on BuildContext {
  Palette get palette => Theme.of(this).extension<Palette>()!;
}

ThemeData buildTheme(Brightness brightness) {
  final Palette p = brightness == Brightness.dark
      ? Palette.dark
      : Palette.light;

  final ColorScheme scheme =
      ColorScheme.fromSeed(seedColor: p.link, brightness: brightness).copyWith(
        surface: p.surface,
        primary: p.link,
        onSurface: p.ink,
        outline: p.line,
      );

  return ThemeData(
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: p.background,
    fontFamily: textFont,
    extensions: [p],
    dividerColor: p.line,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: p.hand.withValues(alpha: 0.32),
      cursorColor: p.hand,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: p.ink,
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: TextStyle(
        fontFamily: textFont,
        fontSize: 13,
        color: p.background,
      ),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(p.faint.withValues(alpha: 0.5)),
      radius: const Radius.circular(8),
    ),
  );
}

class Txt {
  static TextStyle body(Palette p) => TextStyle(
    fontFamily: textFont,
    fontSize: 16.5,
    height: 1.62,
    color: p.ink,
  );

  static TextStyle lead(Palette p) => TextStyle(
    fontFamily: textFont,
    fontSize: 19,
    height: 1.5,
    color: p.muted,
  );

  static TextStyle h1(Palette p) => TextStyle(
    fontFamily: displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 44,
    height: 1.1,
    letterSpacing: -0.9,
    color: p.ink,
  );

  static TextStyle h2(Palette p) => TextStyle(
    fontFamily: displayFont,
    fontWeight: FontWeight.w700,
    fontSize: 27,
    height: 1.2,
    letterSpacing: -0.4,
    color: p.ink,
  );

  static TextStyle h3(Palette p) => TextStyle(
    fontFamily: textFont,
    fontWeight: FontWeight.w600,
    fontSize: 19,
    height: 1.3,
    color: p.ink,
  );

  static TextStyle small(Palette p) => TextStyle(
    fontFamily: textFont,
    fontSize: 14,
    height: 1.45,
    color: p.muted,
  );

  static TextStyle ui(Palette p) => TextStyle(
    fontFamily: textFont,
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 1.3,
    color: p.ink,
  );

  static TextStyle mono(Palette p, {double size = 14.5}) => TextStyle(
    fontFamily: monoFont,
    fontFamilyFallback: monoFallback,
    fontSize: size,
    height: 1.65,
    color: p.ink,
    fontFeatures: const [FontFeature.disable("calt")],
  );
}

class Breakpoints {
  static const double drawer = 940;
  static const double toc = 1260;
}
