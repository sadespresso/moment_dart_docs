import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage gettingStartedPage = DocPage(
  path: "/getting-started",
  title: "Getting started",
  group: "Start here",
  summary:
      "moment_dart is a [moment.js](https://momentjs.com) inspired "
      "library for querying, changing and describing dates in Dart. Install "
      "it, import it, and every `DateTime` gains the methods below.",
  blocks: () => [
    const H2("Install"),
    const Code(
      "dart pub add moment_dart\n\n# in a Flutter app\nflutter pub add moment_dart",
      lang: "sh",
    ),
    const P("Or add it to `pubspec.yaml` yourself:"),
    const Code("dependencies:\n  moment_dart: ^6.0.0", lang: "yaml"),
    const H2("Import"),
    const Code("import 'package:moment_dart/moment_dart.dart';"),
    const P(
      "One import gives you the `Moment` class, the `DateTime` extensions, "
      "time ranges and all 16 bundled localizations.",
    ),
    const H2("Your first moment"),
    const P(
      "`Moment` extends `DateTime`, so anything that takes a `DateTime` takes "
      "a `Moment`. It's immutable: methods like `add` return a new moment.",
    ),
    Live([
      c("final now = Moment.now();"),
      c(""),
      l("now is DateTime", () => (Moment.now() as Object) is DateTime),
      l("now.format(\"LLLL\")", () => Moment.now().format("LLLL")),
      l("now.calendar()", () => Moment.now().calendar()),
      l(
        "now.subtract(Duration(hours: 3)).fromNow()",
        () => Moment.now().subtract(const Duration(hours: 3)).fromNow(),
      ),
    ]),
    const P(
      "The results in these code blocks are computed in your browser as you "
      "read. Switch the language in the header and they follow.",
    ),
    const H2("From a DateTime you already have"),
    const P(
      "Call `toMoment()` on any `DateTime`. Most helpers also work on plain "
      "`DateTime` without converting it, so use whichever you have.",
    ),
    Live(tick: false, [
      c("final launch = DateTime(1969, 7, 16, 13, 32);"),
      c(""),
      l(
        "launch.toMoment().LL",
        () => DateTime(1969, 7, 16, 13, 32).toMoment().LL,
      ),
      l("launch.isLeapYear", () => DateTime(1969, 7, 16, 13, 32).isLeapYear),
      l(
        "launch.startOfMonth()",
        () => DateTime(1969, 7, 16, 13, 32).startOfMonth(),
      ),
      l(
        "launch.format(payload: \"Do MMMM\")",
        () => DateTime(1969, 7, 16, 13, 32).format(payload: "Do MMMM"),
      ),
    ]),
    const Note(NoteKind.info, [
      P(
        "`DateTime.format` takes named arguments (`payload`, `forceLocal`, "
        "`localization`), while `Moment.format` takes positional ones. "
        "`Moment` already knows its localization.",
      ),
    ]),
    const H2("Pick a language"),
    const P(
      "English (United States) is the default. Set another one once, when "
      "your app starts, and every moment without its own localization uses "
      "it. See [global localization](/global-localization).",
    ),
    const Code(
      "void main() {\n"
      "  Moment.setGlobalLocalization(MomentLocalizations.fr());\n"
      "  runApp(const MyApp());\n"
      "}",
    ),
    Live([
      l(
        "Moment.now(localization: MomentLocalizations.de()).calendar()",
        () => Moment.now(localization: MomentLocalizations.de()).calendar(),
      ),
      l(
        "Moment.now(localization: MomentLocalizations.koKr()).LLLL",
        () => Moment.now(localization: MomentLocalizations.koKr()).LLLL,
      ),
    ]),
    const H2("Watch the timezone"),
    const P(
      "Like `DateTime`, moment_dart keeps the timezone it's given. Dates "
      "parsed from ISO 8601 strings or returned by an API are usually in "
      "UTC, so call `toLocal()` before you show them to a person. "
      "[Common mishaps](/common-mishaps) covers this and a few other traps.",
    ),
    const H2("Where next"),
    const Bullets([
      "[Formatting](/formatting): every token, and the locale-aware formats "
          "like `LL` and `LT`.",
      "[Relative durations](/duration): \"3 hours ago\", \"in a few "
          "seconds\".",
      "[Time ranges](/time-range): this month, last week, and spans you "
          "can page through.",
      "[Upgrading to 6.0](/upgrading): what changed, if you're coming "
          "from 5.x.",
    ]),
  ],
);
