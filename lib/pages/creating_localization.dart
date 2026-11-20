// The example localization below uses the same mixins a third-party
// localization would, and those are only reachable through src/.
// ignore_for_file: implementation_imports

import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/english_like_ordinal.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

import '../docs/model.dart';

const String _enGbSource = r'''
// ignore_for_file: implementation_imports
import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart/src/localizations/mixins/english_like_ordinal.dart';
import 'package:moment_dart/src/localizations/mixins/month_names.dart';
import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';
import 'package:moment_dart/src/localizations/mixins/simple_range.dart';
import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';
import 'package:moment_dart/src/localizations/mixins/simple_units.dart';

class LocalizationEnGb extends MomentLocalization
    with
        MonthNames,
        EnglishLikeOrdinal,
        SimpleUnits,
        SimpleRelative,
        SimpleDuration,
        SimpleRange {
  static final LocalizationEnUs _us = LocalizationEnUs();

  @override
  String get languageCode => "en";

  @override
  String get countryCode => "GB";

  @override
  String get endonym => "English (UK)";

  @override
  String get languageNameInEnglish => "English (United Kingdom)";

  @override
  int get weekStart => DateTime.monday;

  @override
  Map<int, String> get weekdayName => _us.weekdayName;

  @override
  Map<int, String> get monthNames => _us.monthNames;

  @override
  Map<int, String> get monthNamesShort => _us.monthNamesShort;

  @override
  List<String> get ordinalSuffixes => _us.ordinalSuffixes;

  @override
  Map<DurationInterval, UnitString> get units => _us.units;

  @override
  Map<DurationInterval, UnitString> get durationUnits => _us.durationUnits;

  @override
  String relativePast(String unit) => _us.relativePast(unit);

  @override
  String relativeFuture(String unit) => _us.relativeFuture(unit);

  @override
  CalendarLocalizationData get calendarData => _us.calendarData;

  @override
  SimpleRangeData get simpleRangeData => _us.simpleRangeData;

  @override
  FormatSetOptional overrideFormatters() => {
    ...formattersWithOrdinal,
    ...formattersForMonthNames,
    FormatterToken.L: (dateTime) => reformat(dateTime, "DD/MM/YYYY"),
    FormatterToken.l: (dateTime) => reformat(dateTime, "D/M/YYYY"),
    FormatterToken.LL: (dateTime) => reformat(dateTime, "D MMMM YYYY"),
    FormatterToken.ll: (dateTime) => reformat(dateTime, "D MMM YYYY"),
    FormatterToken.LLL: (dateTime) => reformat(dateTime, "D MMMM YYYY HH:mm"),
    FormatterToken.lll: (dateTime) => reformat(dateTime, "D MMM YYYY HH:mm"),
    FormatterToken.LLLL: (dateTime) =>
        reformat(dateTime, "dddd, D MMMM YYYY HH:mm"),
    FormatterToken.llll: (dateTime) =>
        reformat(dateTime, "ddd, D MMM YYYY HH:mm"),
    FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
    FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
  };
}''';

// Must stay identical to _enGbSource, which is what readers copy.
class LocalizationEnGb extends MomentLocalization
    with
        MonthNames,
        EnglishLikeOrdinal,
        SimpleUnits,
        SimpleRelative,
        SimpleDuration,
        SimpleRange {
  static final LocalizationEnUs _us = LocalizationEnUs();

  @override
  String get languageCode => "en";

  @override
  String get countryCode => "GB";

  @override
  String get endonym => "English (UK)";

  @override
  String get languageNameInEnglish => "English (United Kingdom)";

  @override
  int get weekStart => DateTime.monday;

  @override
  Map<int, String> get weekdayName => _us.weekdayName;

  @override
  Map<int, String> get monthNames => _us.monthNames;

  @override
  Map<int, String> get monthNamesShort => _us.monthNamesShort;

  @override
  List<String> get ordinalSuffixes => _us.ordinalSuffixes;

  @override
  Map<DurationInterval, UnitString> get units => _us.units;

  @override
  Map<DurationInterval, UnitString> get durationUnits => _us.durationUnits;

  @override
  String relativePast(String unit) => _us.relativePast(unit);

  @override
  String relativeFuture(String unit) => _us.relativeFuture(unit);

  @override
  CalendarLocalizationData get calendarData => _us.calendarData;

  @override
  SimpleRangeData get simpleRangeData => _us.simpleRangeData;

  @override
  FormatSetOptional overrideFormatters() => {
    ...formattersWithOrdinal,
    ...formattersForMonthNames,
    FormatterToken.L: (dateTime) => reformat(dateTime, "DD/MM/YYYY"),
    FormatterToken.l: (dateTime) => reformat(dateTime, "D/M/YYYY"),
    FormatterToken.LL: (dateTime) => reformat(dateTime, "D MMMM YYYY"),
    FormatterToken.ll: (dateTime) => reformat(dateTime, "D MMM YYYY"),
    FormatterToken.LLL: (dateTime) => reformat(dateTime, "D MMMM YYYY HH:mm"),
    FormatterToken.lll: (dateTime) => reformat(dateTime, "D MMM YYYY HH:mm"),
    FormatterToken.LLLL: (dateTime) =>
        reformat(dateTime, "dddd, D MMMM YYYY HH:mm"),
    FormatterToken.llll: (dateTime) =>
        reformat(dateTime, "ddd, D MMM YYYY HH:mm"),
    FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
    FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
  };
}

Moment _gb() =>
    Moment(DateTime(2024, 3, 5, 15, 4), localization: LocalizationEnGb());

final DocPage creatingLocalizationPage = DocPage(
  path: "/creating-localization",
  title: "Writing a localization",
  group: "Languages",
  summary:
      "Extend `MomentLocalization` to add a language or a regional "
      "variant. Mixins supply the shared logic, so most of a localization is "
      "data: names, unit strings and format patterns.",
  blocks: () => [
    const H2("Where to start"),
    const P(
      "The quickest route is to copy the bundled localization closest to "
      "your language from "
      "[lib/src/localizations](https://github.com/sadespresso/moment_dart/tree/master/lib/src/localizations) "
      "and change its strings. `en_US.dart` is the simplest. If your "
      "language is missing, consider sending it upstream so everyone gets "
      "it.",
    ),
    const P(
      "You can't subclass a bundled localization: their constructors are "
      "private. To reuse one, hold an instance and delegate to it, as the "
      "example below does.",
    ),
    const H2("What you must implement"),
    const P(
      "`MomentLocalization` is abstract. A subclass has to provide these "
      "members, though mixins can cover `relative`, `duration` and the "
      "calendar data for you.",
    ),
    const TableBlock(
      ["Member", "What it is"],
      [
        ["languageCode", "ISO 639-1 language code, such as `\"en\"`."],
        ["countryCode", "ISO 3166-1 alpha-2 country code, or `null`."],
        ["endonym", "The language's name in that language."],
        ["languageNameInEnglish", "The language's name in English."],
        [
          "weekdayName",
          "Weekday names, keyed `DateTime.monday` (1) to "
              "`DateTime.sunday` (7). `dd`, `ddd` and `dddd` are derived from "
              "it unless you override them.",
        ],
        [
          "overrideFormatters()",
          "Formatters for the tokens your language "
              "changes, as a `FormatSetOptional`.",
        ],
        [
          "calendarData",
          "Words for `calendar()`: yesterday, today, "
              "tomorrow, \"last Monday\" and \"at\". A "
              "`CalendarLocalizationData`.",
        ],
        [
          "relative()",
          "Fuzzy durations: \"in an hour\". Provided by "
              "`SimpleRelative`.",
        ],
        [
          "duration()",
          "Precise durations: \"in 1 hour 5 minutes\". Provided "
              "by `SimpleDuration`.",
        ],
      ],
      monoColumns: {0},
    ),
    const P(
      "You can also override `weekStart` (defaults to Monday), `locale` "
      "(defaults to `languageCode_countryCode`; override it to add a script "
      "code, as `mn_Mong_MN` does), `calendarTime` (the time part of "
      "`calendar()`), `calendar()` and `range()`.",
    ),
    const Note(NoteKind.warning, [
      P(
        "Implement all ten locale formats: `L`, `l`, `LL`, `ll`, `LLL`, "
        "`lll`, `LLLL`, `llll`, `LT` and `LTS`. The base class has no default "
        "for them, `format()` fails on a token without a formatter, and "
        "`calendar()` uses `l` and `LT`. Write them with "
        "`reformat(dateTime, pattern)`, which formats `dateTime` with your "
        "localization.",
      ),
    ]),
    const H2("Imports"),
    const P(
      "`MomentLocalization`, `FormatterToken`, `FormatSet`, "
      "`FormatSetOptional`, `CalendarLocalizationData`, "
      "`DurationInterval` and `Abbreviation` all come from the main "
      "library. The mixins, `UnitString` and `SimpleRangeData` are not "
      "exported, so they're imported from `src/`.",
    ),
    const Code(
      "import 'package:moment_dart/moment_dart.dart';\n"
      "\n"
      "// Only the mixins you use\n"
      "import 'package:moment_dart/src/localizations/mixins/simple_units.dart';\n"
      "import 'package:moment_dart/src/localizations/mixins/simple_relative.dart';\n"
      "import 'package:moment_dart/src/localizations/mixins/simple_duration.dart';",
    ),
    const P(
      "Dart treats `src/` as private to a package, so the analyzer's "
      "`implementation_imports` lint flags these lines. Add "
      "`// ignore_for_file: implementation_imports` to the file, as the "
      "example does.",
    ),
    const H2("Mixins"),
    const P(
      "Each mixin lives in `lib/src/localizations/mixins/` under the file "
      "name shown. Mixins that provide formatters do so through a getter; "
      "spread it into `overrideFormatters()`.",
    ),
    const TableBlock(
      ["Mixin (file)", "You provide", "It provides"],
      [
        [
          "`MonthNames` (`month_names.dart`)",
          "`monthNames`, `monthNamesShort`, optional `monthNamesMin`",
          "`formattersForMonthNames`: `MMM`, `MMMM`, and `MM` when "
              "`monthNamesMin` is set",
        ],
        [
          "`Ordinal` (`ordinal_numbers.dart`)",
          "`ordinalNumber(int n)`",
          "`formattersWithOrdinal`: `Mo`, `Qo`, `Do`, `DDDo`, `d_o`, `wo`",
        ],
        [
          "`EnglishLikeOrdinal` (`english_like_ordinal.dart`)",
          "`ordinalSuffixes`, in the order other, 1, 2, 3",
          "`ordinalNumber` (1st, 12th, 22nd) and `formattersWithOrdinal`",
        ],
        [
          "`WeekdayShortForms` (`weekday_shortforms.dart`)",
          "`weekdayNameShort`, optional `weekdayNameMin`",
          "`formattersForWeekdayShortForms`: `ddd`, and `dd` when "
              "`weekdayNameMin` is set",
        ],
        [
          "`SimpleUnits` (`simple_units.dart`)",
          "`units`, `relativePast`, `relativeFuture`; optional "
              "`durationUnits` and `srDelta`",
          "The unit strings the next two mixins use",
        ],
        [
          "`SimpleRelative` (`simple_relative.dart`)",
          "Needs `SimpleUnits`",
          "`relative()`",
        ],
        [
          "`SimpleDuration` (`simple_duration.dart`)",
          "Needs `SimpleUnits`; optional `durationDelimiter` and "
              "`delimeterConnector`",
          "`duration()`",
        ],
        [
          "`SimpleRange` (`simple_range.dart`)",
          "`simpleRangeData`",
          "`range()`: \"This week\", \"This month\", \"All time\" and so on",
        ],
        [
          "`ComplexCalendar` (`complex_calendar.dart`)",
          "`complexCalendarData`",
          "`calendar()`, for languages where the weekday phrase depends on "
              "the date itself; `calendarData` becomes `null`",
        ],
      ],
    ),
    const P(
      "Order matters in the `with` clause: `SimpleUnits` must come before "
      "`SimpleRelative` and `SimpleDuration`, which are declared `on "
      "SimpleUnits`. `delimeterConnector` is spelled that way in the "
      "library; set it to a word like `\"and\"` to join the last two units.",
    ),
    const H3("Unit strings"),
    const P(
      "`units` maps every `DurationInterval`, from `lessThanASecond` to "
      "`years`, to a `UnitString`. `UnitString.withForm(full, mid, short)` "
      "gives the three [abbreviation](/duration/short-forms) forms; "
      "`UnitString.duo` and `UnitString.single` cover languages with fewer. "
      "Write `srDelta` (`%` by default) where the number goes. `duration()` "
      "throws if an interval it needs is missing.",
    ),
    const Code(r'''@override
Map<DurationInterval, UnitString> get units => {
      DurationInterval.lessThanASecond:
          UnitString.withForm("a few seconds", "a few sec", "a sec"),
      DurationInterval.aMinute: UnitString.withForm("a minute", "1 min", "1m"),
      DurationInterval.minutes: UnitString.withForm(
          "$srDelta minutes", "$srDelta min", "${srDelta}m"),
      // ...one entry for each DurationInterval
    };

@override
Map<DurationInterval, UnitString> get durationUnits => {
      ...units,
      DurationInterval.aMinute: UnitString.withForm("1 minute", "1 min", "1m"),
      // ...the other singular intervals
    };'''),
    const P(
      "`durationUnits` is new in 6.0. It defaults to `units`. Override it "
      "when the singular forms that read well in fuzzy time (\"in a "
      "minute\") read badly in precise durations (\"2 hours a minute\"). "
      "`en_US`, `de_DE`, `es_ES`, `fr_FR`, `it_IT`, `pt_PT` and `tr_TR` do "
      "this.",
    ),
    const H2("Example: English (United Kingdom)"),
    const P(
      "moment_dart doesn't bundle British English; `byLocale(\"en_GB\")` "
      "falls back to American English. This localization reuses the "
      "American strings and changes the date order, the 24-hour clock and "
      "the week start.",
    ),
    const Code(_enGbSource, title: "en_gb.dart"),
    const P("The examples below run against that exact class."),
    Live(tick: false, [
      c(
        "final m = Moment(DateTime(2024, 3, 5, 15, 4), localization: LocalizationEnGb());",
      ),
      c(""),
      l("m.LLLL", () => _gb().LLLL),
      l("m.format(\"L\")", () => _gb().format("L")),
      l("m.format(\"Do MMMM\")", () => _gb().format("Do MMMM")),
      l(
        "m.calendar(reference: DateTime(2024, 3, 6))",
        () => _gb().calendar(reference: DateTime(2024, 3, 6)),
      ),
      l(
        "m.fromPrecise(DateTime(2024, 3, 5, 17, 5))",
        () => _gb().fromPrecise(DateTime(2024, 3, 5, 17, 5)),
      ),
      l("m.startOfLocalWeek()", () => _gb().startOfLocalWeek()),
    ]),
    const H2("Make byLocale find it"),
    const P(
      "`MomentLocalizations.locales` is the map that `byLocale` and "
      "`byLanguage` search. Add your localization to it at startup. "
      "Formatters are cached per instance, so register one instance rather "
      "than a new one per call.",
    ),
    const Code(
      "void main() {\n"
      "  final LocalizationEnGb enGb = LocalizationEnGb();\n"
      "  MomentLocalizations.locales[\"en_GB\"] = () => enGb;\n"
      "\n"
      "  // Now an exact match instead of the en_US fallback\n"
      "  Moment.setGlobalLocalization(MomentLocalizations.byLocale(\"en-GB\")!);\n"
      "\n"
      "  runApp(const MyApp());\n"
      "}",
    ),
    const P(
      "See [Localizations](/localizations) for how lookups match, and "
      "[global localization](/global-localization) for making it the "
      "default.",
    ),
  ],
);
