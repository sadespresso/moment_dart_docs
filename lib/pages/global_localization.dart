import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage globalLocalizationPage = DocPage(
  path: "/global-localization",
  title: "Global localization",
  group: "Languages",
  summary:
      "Set the language once and every moment without its own "
      "localization uses it. Moments look the global localization up each "
      "time they format, so a change also applies to moments you already "
      "made.",
  blocks: () => [
    const H2("Set it"),
    const P(
      "The default is English (United States). Call "
      "`Moment.setGlobalLocalization` when your app starts, before anything "
      "is formatted.",
    ),
    const Code(
      "void main() {\n"
      "  Moment.setGlobalLocalization(MomentLocalizations.fr());\n"
      "  runApp(const MyApp());\n"
      "}",
    ),
    const P(
      "`Moment.defaultLocalization` holds the current value. On this site the "
      "language picker in the header calls `setGlobalLocalization`, so the "
      "lines below follow it.",
    ),
    Live([
      l(
        "Moment.defaultLocalization.locale",
        () => Moment.defaultLocalization.locale,
      ),
      l(
        "Moment.now().localization.locale",
        () => Moment.now().localization.locale,
      ),
      l("Moment.now().LLLL", () => Moment.now().LLLL),
    ]),
    const H2("Follow the device language"),
    const P(
      "In Flutter, look up the device locale and pass it to "
      "[byLocale](/localizations#by-locale). Since 6.0 it falls back to the "
      "closest localization of the same language, so `en-GB` or `pt-BR` "
      "still get English or Portuguese. Keep a fallback for languages "
      "moment_dart doesn't bundle.",
    ),
    const Code(
      "void main() {\n"
      "  WidgetsFlutterBinding.ensureInitialized();\n"
      "\n"
      "  final Locale device = WidgetsBinding.instance.platformDispatcher.locale;\n"
      "  Moment.setGlobalLocalization(\n"
      "    MomentLocalizations.byLocale(device.toLanguageTag()) ??\n"
      "        MomentLocalizations.enUS(),\n"
      "  );\n"
      "\n"
      "  runApp(const MyApp());\n"
      "}",
    ),
    const P(
      "If the user can switch languages while the app runs, call "
      "`setGlobalLocalization` again and rebuild the widgets that show "
      "dates. moment_dart doesn't notify anything when the value changes.",
    ),
    const H2("A moment's own localization wins"),
    const P(
      "A moment created with `localization:` keeps it, whatever the global "
      "value is. `hasExplicitLocalization` tells the two kinds apart, and "
      "`setLocalization` returns the explicit one, or `null` for a moment "
      "that follows the global value.",
    ),
    Live([
      c("final ko = Moment.now(localization: MomentLocalizations.koKr());"),
      c(""),
      l(
        "ko.LLLL",
        () => Moment.now(localization: MomentLocalizations.koKr()).LLLL,
      ),
      l(
        "ko.hasExplicitLocalization",
        () =>
            Moment.now(localization: MomentLocalizations.koKr())
                .hasExplicitLocalization,
      ),
      l(
        "Moment.now().hasExplicitLocalization",
        () => Moment.now().hasExplicitLocalization,
      ),
      l("Moment.now().setLocalization", () => Moment.now().setLocalization),
    ]),
    const P(
      "The explicit localization carries over to moments derived from it: "
      "`add`, `subtract`, `copyWith`, `toUtc`, `toLocal`, `startOf…` and "
      "`endOf…` all keep it. Wrapping in `Moment(...)` again drops it, which "
      "is how you hand a moment back to the global localization.",
    ),
    Live(tick: false, [
      c(
        "final ko = Moment(DateTime(2024, 3, 15), localization: MomentLocalizations.koKr());",
      ),
      c(""),
      l(
        "ko.startOfMonth().hasExplicitLocalization",
        () => Moment(
          DateTime(2024, 3, 15),
          localization: MomentLocalizations.koKr(),
        ).startOfMonth().hasExplicitLocalization,
      ),
      l(
        "Moment(ko).hasExplicitLocalization",
        () => Moment(
          Moment(
            DateTime(2024, 3, 15),
            localization: MomentLocalizations.koKr(),
          ),
        ).hasExplicitLocalization,
      ),
    ]),
    const H3("Where you can pass a localization"),
    const Bullets([
      "Constructors: `Moment(date, localization: ...)`, `Moment.now`, "
          "`Moment.fromMillisecondsSinceEpoch`, `Moment.parse` and the rest.",
      "`date.toMoment(localization: ...)` on any `DateTime`.",
      "`moment.copyWith(localization: ...)` to switch an existing moment.",
      "`date.format(payload: \"LL\", localization: ...)` for a one-off "
          "string from a plain `DateTime`.",
      "`Moment.duration(duration, localization: ...)` and "
          "`duration.toDurationString(localization: ...)`.",
      "`range.format(localization: ...)` on a [time range](/time-range).",
    ]),
    const H2("What else reads the global value"),
    const P(
      "Calls that don't go through a moment with its own localization use "
      "the global one. That includes `Moment.duration`, "
      "`Duration.toDurationString` and `TimeRange.format` without "
      "`localization:`, and the week start of `DateTime.startOfLocalWeek()`, "
      "`endOfLocalWeek()` and `LocalWeekTimeRange` when you don't pass "
      "`weekStart`.",
    ),
    Live([
      l(
        "Moment.duration(Duration(hours: 2, minutes: 5))",
        () => Moment.duration(const Duration(hours: 2, minutes: 5)),
      ),
      l(
        "Moment.defaultLocalization.weekStart",
        () => Moment.defaultLocalization.weekStart,
      ),
      l(
        "DateTime(2024, 3, 15).startOfLocalWeek()",
        () => DateTime(2024, 3, 15).startOfLocalWeek(),
      ),
    ]),
    const Note(NoteKind.info, [
      P(
        "Switching between, say, English (week starts on Sunday) and German "
        "(Monday) changes which days count as \"this week\". Pass `weekStart` "
        "explicitly where the week boundary must not depend on the user's "
        "language.",
      ),
    ]),
  ],
);
