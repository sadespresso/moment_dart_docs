import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage upgradingPage = DocPage(
  path: "/upgrading",
  title: "Upgrading to 6.0",
  group: "Start here",
  summary:
      "What changed between 5.x and 6.0, and the few edits most apps "
      "need. Two changes break compilation; the rest change behavior, so "
      "read the list even if your build passes.",
  blocks: () => [
    const H2("From 5.x to 6.0"),
    const Code("dependencies:\n  moment_dart: ^6.0.0", lang: "yaml"),
    const P(
      "Removing the `Calender*` names and making the constants `final` are "
      "the only changes the compiler will catch. Comparisons across "
      "timezones, `byLocale`, `CustomTimeRange` and many localized strings "
      "now behave differently at runtime.",
    ),
    const P(
      "The [5.x docs](https://moment-dart-docs-v5.pages.dev) stay online while "
      "you upgrade.",
    ),
    const H3("Migration checklist"),
    const Bullets(ordered: true, [
      "Replace assignments to `Moment.epoch`, `maxValue`, `minValue` and "
          "their `Utc` versions with your own variable.",
      "Rename `CalenderLocalizationData` to `CalendarLocalizationData`, and "
          "every other `Calender…` / `calender…` name to `Calendar…` / "
          "`calendar…`.",
      "If you used `isAtSame…As` to compare wall-clock fields of dates in "
          "different timezones, convert both dates yourself first, or pass "
          "`enforceUTC: true`.",
      "Where `to` can be before `from`, check before calling "
          "`CustomTimeRange(from, to)`, or use `from.rangeTo(to)`, which "
          "swaps them.",
      "If you relied on `byLocale` returning `null` for an unsupported "
          "locale, call `byLocale(code, strict: true)`.",
      "If you modified `localization.formatters`, write a "
          "[custom localization](/creating-localization) instead.",
      "Update tests that compare localized output; many strings changed.",
    ]),
    const H3("The constants are final"),
    const P(
      "`Moment.epoch`, `epochUtc`, `maxValue`, `maxValueUtc`, `minValue` "
      "and `minValueUtc` can no longer be reassigned.",
    ),
    const Code(
      "// No longer compiles\n"
      "Moment.maxValue = DateTime(2100);\n"
      "\n"
      "// Keep your own value instead\n"
      "final DateTime farFuture = DateTime(2100);",
    ),
    const H3("isAtSame…As compares instants"),
    const P(
      "`isAtSameYearAs` through `isAtSameMicrosecondAs` now convert `other` "
      "to the timezone of `this` and compare the start of the unit as an "
      "instant, like `isSame` in moment.js. In 5.x they compared the raw "
      "fields, so a UTC date and a local date of the same instant often "
      "didn't match. Now they always do:",
    ),
    Live(tick: false, [
      c("final utc = DateTime.utc(2024, 6, 1, 23, 30);"),
      c("final local = utc.toLocal();"),
      c(""),
      l(
        "utc.isAtSameDayAs(local)",
        () => DateTime.utc(
          2024,
          6,
          1,
          23,
          30,
        ).isAtSameDayAs(DateTime.utc(2024, 6, 1, 23, 30).toLocal()),
      ),
      l(
        "utc.differenceInDays(local) == 0",
        () =>
            DateTime.utc(
              2024,
              6,
              1,
              23,
              30,
            ).differenceInDays(DateTime.utc(2024, 6, 1, 23, 30).toLocal()) ==
            0,
      ),
    ]),
    const P(
      "The second line is the 5.x-style comparison of calendar dates as "
      "they are. Its result depends on your timezone: `false` east of UTC, "
      "`true` elsewhere. More on the methods in "
      "[isAtSame](/extension/isAtSame).",
    ),
    const H3("CustomTimeRange checks its order"),
    const P(
      "`CustomTimeRange` throws an `ArgumentError` when `to` is before "
      "`from`. Before, this was only an assert, so release builds accepted "
      "the reversed range. `rangeTo` puts the two dates in order for you.",
    ),
    Live(tick: false, [
      t(
        "CustomTimeRange(DateTime(2024, 2, 1), DateTime(2024, 1, 1))",
        () => CustomTimeRange(DateTime(2024, 2, 1), DateTime(2024, 1, 1)),
      ),
      l(
        "DateTime(2024, 2, 1).rangeTo(DateTime(2024, 1, 1)).from",
        () => DateTime(2024, 2, 1).rangeTo(DateTime(2024, 1, 1)).from,
      ),
    ]),
    const H3("byLocale falls back by language"),
    const P(
      "`MomentLocalizations.byLocale` now returns the closest localization of "
      "the same language when there's no exact match. In 5.x both lines "
      "below returned `null`. See [Localizations](/localizations#by-locale).",
    ),
    Live(tick: false, [
      l(
        "MomentLocalizations.byLocale(\"en_GB\")?.locale",
        () => MomentLocalizations.byLocale("en_GB")?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"pt-BR\")?.locale",
        () => MomentLocalizations.byLocale("pt-BR")?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"en_GB\", strict: true)?.locale",
        () => MomentLocalizations.byLocale("en_GB", strict: true)?.locale,
      ),
    ]),
    const H3("Formatters are read-only"),
    const P(
      "`MomentLocalization.formatters` is built once and cached, and now "
      "returns an unmodifiable map.",
    ),
    Live(tick: false, [
      t(
        "MomentLocalizations.enUS().formatters[FormatterToken.LT] = (dateTime) => \"noon\"",
        () => MomentLocalizations.enUS().formatters[FormatterToken.LT] = (
          dateTime,
        ) => "noon",
      ),
    ]),
    const H3("Calender names removed"),
    const P(
      "The deprecated `Calender*` typedefs and `calender*` constants are "
      "gone. Use the `Calendar*` and `calendar*` names, for example "
      "`CalendarLocalizationData` and "
      "`LocalizationEnUs.calendarLocalizationDataEnUs`.",
    ),
    const H3("Localized strings"),
    const P(
      "Many localizations were corrected: Russian and Polish grammar, Arabic "
      "plural forms, English long dates (\"January 5, 2024\"), German "
      "24-hour times, the Unicode 16 encoding for traditional Mongolian "
      "script, and more. The full list is in the "
      "[changelog](https://github.com/sadespresso/moment_dart/blob/master/CHANGELOG.md).",
    ),
    const H2("New in 6.0"),
    const H3("copyWith takes date fields"),
    const P(
      "`Moment.copyWith` accepts `year` through `microsecond` and `isUtc`, "
      "applied on top of `dateTime` when you pass both. Before, it only took "
      "`dateTime` and `localization` and hid `DateTime.copyWith`. See "
      "[Creating moments](/moment#copywith).",
    ),
    Live(tick: false, [
      c("final m = Moment(DateTime(2024, 3, 15, 9, 30));"),
      c(""),
      l(
        "m.copyWith(year: 2020)",
        () => Moment(DateTime(2024, 3, 15, 9, 30)).copyWith(year: 2020),
      ),
      l(
        "m.copyWith(day: 1, localization: MomentLocalizations.de())",
        () =>
            Moment(DateTime(2024, 3, 15, 9, 30))
                .copyWith(day: 1, localization: MomentLocalizations.de()),
      ),
    ]),
    const H3("Numbers in precise durations"),
    const P(
      "`SimpleUnits` has a new `durationUnits` map that `duration()` uses "
      "instead of `units`. The built-in localizations use it to write the "
      "number in precise durations, while `relative()` keeps the fuzzy "
      "wording.",
    ),
    Live(tick: false, [
      c("final en = MomentLocalizations.enUS();"),
      c(""),
      l(
        "Duration(hours: 2, minutes: 1).toDurationString(localization: en)",
        () => const Duration(
          hours: 2,
          minutes: 1,
        ).toDurationString(localization: MomentLocalizations.enUS()),
      ),
      l(
        "en.relative(Duration(hours: 1))",
        () => MomentLocalizations.enUS().relative(const Duration(hours: 1)),
      ),
    ]),
    const P("In 5.x the first line read \"in 2 hours a minute\"."),
    const H3("FormatSet is exported"),
    const P(
      "`FormatSet` and `FormatSetOptional` come from the main library, so "
      "`overrideFormatters()` in a custom localization no longer needs an "
      "import from `src/`. The helper mixins still live under `src/`; see "
      "[Writing a localization](/creating-localization).",
    ),
    const H3("Notable fixes"),
    const Bullets([
      "`differenceInDays` was off by one across a 23-hour DST day, which also "
          "made `calendar()` say \"Today\" instead of \"Yesterday\" or "
          "\"Tomorrow\".",
      "Weekday finders such as `nextMonday()` no longer drift by an hour "
          "across DST. `clone()`, `startOf`/`endOf` and the hour and minute "
          "finders return the right instant during a repeated fall-back "
          "hour.",
      "`IsoWeekTimeRange.next`/`last` no longer get stuck or skip a week at "
          "DST, `LocalWeekTimeRange.next`/`last` keep `weekStart`, and "
          "`HourTimeRange.last` no longer sticks at spring-forward.",
      "`TimeRange.encodeShort()` and `parse` keep UTC and `weekStart`; old "
          "strings still parse the same.",
      "Durations round before splitting into units, so 59m59.6s is one "
          "hour, not \"59 minutes 60 seconds\". Relative thresholds compare "
          "the rounded value, like moment.js.",
      "`fromPrecise(dropPrefixOrSuffix: true)` and `fromNowPrecise` "
          "honor the flag.",
      "`Moment.maxValue` and `minValue` are the same instants as their UTC "
          "versions in every timezone.",
      "`byLocale` ignores case, and `byLanguage(\"e\")` no longer matches "
          "`en`.",
      "`format()` is about 40% faster.",
    ]),
    const H2("From 4.x to 5.x"),
    const P(
      "If you don't use time ranges, nothing changes. In 5.0.1 the `to` of "
      "`HourTimeRange`, `DayTimeRange`, `MonthTimeRange` and `YearTimeRange` "
      "became inclusive: it's the last microsecond of the range instead of "
      "the start of the next one, matching `CustomTimeRange` and the week "
      "ranges. Their `duration` is one microsecond shorter as a result.",
    ),
    Live(tick: false, [
      l("YearTimeRange(2020).to", () => YearTimeRange(2020).to),
      l(
        "YearTimeRange(2025).contains(DateTime(2026, 1, 1))",
        () => YearTimeRange(2025).contains(DateTime(2026, 1, 1)),
      ),
    ]),
    const H2("From 3.x to 4.0"),
    const P(
      "The month range format includes the year. It's left out only when "
      "`useRelative` is true and the anchor is in the same year.",
    ),
    Live(tick: false, [
      c("final en = MomentLocalizations.enUS();"),
      c(""),
      l(
        "MonthTimeRange(2023, 2).format(localization: en, anchor: DateTime(2024, 6))",
        () => MonthTimeRange(2023, 2).format(
          localization: MomentLocalizations.enUS(),
          anchor: DateTime(2024, 6),
        ),
      ),
      l(
        "MonthTimeRange(2023, 2).format(localization: en, anchor: DateTime(2023, 6))",
        () => MonthTimeRange(2023, 2).format(
          localization: MomentLocalizations.enUS(),
          anchor: DateTime(2023, 6),
        ),
      ),
    ]),
  ],
);
