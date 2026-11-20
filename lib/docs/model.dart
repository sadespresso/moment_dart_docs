import 'package:material_ui/material_ui.dart';
import 'package:moment_dart/moment_dart.dart';

/// One documentation page. [blocks] is a function so pages are built on
/// demand and every visit evaluates its live examples afresh.
class DocPage {
  final String path;
  final String title;
  final String group;

  /// One or two sentences under the title, also shown in search results.
  final String summary;
  final List<Block> Function() blocks;

  const DocPage({
    required this.path,
    required this.title,
    required this.group,
    required this.summary,
    required this.blocks,
  });
}

sealed class Block {
  const Block();
}

class H2 extends Block {
  final String text;
  const H2(this.text);
}

class H3 extends Block {
  final String text;
  const H3(this.text);
}

/// A paragraph. Supports `code`, **bold**, and [links](/path or https://...).
class P extends Block {
  final String text;
  const P(this.text);
}

class Bullets extends Block {
  final List<String> items;
  final bool ordered;
  const Bullets(this.items, {this.ordered = false});
}

/// Static code that isn't run, e.g. shell commands, pubspec, or Dart that
/// can't run in the browser.
class Code extends Block {
  final String code;
  final String lang;
  final String? title;
  const Code(this.code, {this.lang = "dart", this.title});
}

/// Dart code whose results are computed in the browser and printed as
/// trailing comments. Re-evaluated every second when [tick] is true, and
/// whenever the reader changes the locale.
class Live extends Block {
  final List<Line> lines;
  final String? title;
  final bool tick;
  const Live(this.lines, {this.title, this.tick = true});
}

class Line {
  final String code;
  final Object? Function()? eval;

  /// The example demonstrates an exception; the output reads "throws X".
  final bool throws;
  const Line(this.code, [this.eval, this.throws = false]);
}

/// A line of code with a computed result.
Line l(String code, Object? Function() eval) => Line(code, eval);

/// A line of code that is expected to throw.
Line t(String code, Object? Function() eval) => Line(code, eval, true);

/// A line of code without a result (declarations, blank lines, comments).
Line c(String code) => Line(code);

enum NoteKind { tip, info, warning }

class Note extends Block {
  final NoteKind kind;
  final List<Block> children;
  const Note(this.kind, this.children);
}

/// A table. Cells are inline-markup strings, or `Object? Function()` for a
/// value computed live (shown in monospace).
class TableBlock extends Block {
  final List<String> header;
  final List<List<Object>> rows;

  /// Column indexes rendered in monospace even when they're plain strings.
  final Set<int> monoColumns;
  const TableBlock(this.header, this.rows, {this.monoColumns = const {}});
}

/// Anything interactive. [searchText] is what search indexes for it.
class Embed extends Block {
  final WidgetBuilder builder;
  final String searchText;
  const Embed(this.builder, {this.searchText = ""});
}

String slugify(String text) => text
    .toLowerCase()
    .replaceAll(RegExp(r"`|\*"), "")
    .replaceAll(RegExp(r"[^a-z0-9]+"), "-")
    .replaceAll(RegExp(r"^-+|-+$"), "");

/// Renders a computed value the way the docs print it.
String describe(Object? value) {
  if (value == null) return "null";
  if (value is Duration) return _describeDuration(value);
  return value.toString();
}

String _describeDuration(Duration d) {
  if (d == Duration.zero) return "Duration.zero";
  final List<String> parts = [];
  final bool negative = d.isNegative;
  Duration rest = d.abs();
  final int days = rest.inDays;
  rest -= Duration(days: days);
  final int hours = rest.inHours;
  rest -= Duration(hours: hours);
  final int minutes = rest.inMinutes;
  rest -= Duration(minutes: minutes);
  final int seconds = rest.inSeconds;
  rest -= Duration(seconds: seconds);
  final int micro = rest.inMicroseconds;
  if (days != 0) parts.add("days: $days");
  if (hours != 0) parts.add("hours: $hours");
  if (minutes != 0) parts.add("minutes: $minutes");
  if (seconds != 0) parts.add("seconds: $seconds");
  if (micro != 0) parts.add("microseconds: $micro");
  return "${negative ? "-" : ""}Duration(${parts.join(", ")})";
}

/// Names an exception for "throws X" outputs. `runtimeType` is minified in
/// release web builds, so the common types are matched explicitly.
String describeError(Object e) => switch (e) {
  MomentException() => "MomentException",
  RangeError() => "RangeError",
  ArgumentError() => "ArgumentError",
  FormatException() => "FormatException",
  UnimplementedError() => "UnimplementedError",
  UnsupportedError() => "UnsupportedError",
  StateError() => "StateError",
  AssertionError() => "AssertionError",
  TypeError() => "TypeError",
  Exception() => "Exception",
  _ => "Error",
};
