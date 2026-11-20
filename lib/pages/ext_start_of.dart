import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage extStartOfPage = DocPage(
  path: "/extension/startOf",
  title: "Start of a unit",
  group: "DateTime extensions",
  summary:
      "`startOfDay()`, `startOfMonth()`, `startOf(DurationUnit.hour)` "
      "and the other start-of-unit helpers return the first instant of the "
      "unit a date falls in, in the date's own timezone.",
  blocks: () => [
    const H2("Usage"),
    const P(
      "Each unit has a named method, and `startOf(DurationUnit unit)` takes "
      "the unit as a value when you pick it at runtime. Use them to round a "
      "date down before you store it, group by day or month, or build the "
      "lower bound of a query.",
    ),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9, 26, 535, 897);"),
      c(""),
      l(
        "pi.startOfDay()",
        () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfDay(),
      ),
      l(
        "pi.startOf(DurationUnit.day)",
        () => DateTime(
          2024,
          3,
          14,
          15,
          9,
          26,
          535,
          897,
        ).startOf(DurationUnit.day),
      ),
    ]),
    const H2("All methods"),
    const P(
      "The table starts from `DateTime(2024, 3, 14, 15, 9, 26, 535, 897)`, "
      "a Thursday.",
    ),
    TableBlock(
      ["Method", "Same as", "Example"],
      [
        [
          "`startOfMillisecond()`",
          "`startOf(DurationUnit.millisecond)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfMillisecond(),
        ],
        [
          "`startOfSecond()`",
          "`startOf(DurationUnit.second)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfSecond(),
        ],
        [
          "`startOfMinute()`",
          "`startOf(DurationUnit.minute)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfMinute(),
        ],
        [
          "`startOfHour()`",
          "`startOf(DurationUnit.hour)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfHour(),
        ],
        [
          "`startOfDay()`",
          "`startOf(DurationUnit.day)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfDay(),
        ],
        [
          "`startOfLocalWeek([weekStart])`",
          "`startOf(DurationUnit.week)`, on `Moment` only",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
            535,
            897,
          ).startOfLocalWeek(DateTime.sunday),
        ],
        [
          "`startOfIsoWeek()`",
          "`startOfLocalWeek(DateTime.monday)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfIsoWeek(),
        ],
        [
          "`startOfMonth()`",
          "`startOf(DurationUnit.month)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfMonth(),
        ],
        [
          "`startOfYear()`",
          "`startOf(DurationUnit.year)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).startOfYear(),
        ],
      ],
    ),
    const P(
      "The `startOfLocalWeek` example passes `DateTime.sunday`. "
      "`startOf(DurationUnit.microsecond)` returns a copy of the date, since "
      "a microsecond is the smallest unit `DateTime` has.",
    ),
    const H2("Weeks"),
    const P(
      "Where a week starts depends on the locale: Sunday in the United "
      "States, Monday in most of Europe, Saturday in some Arabic-speaking "
      "countries. `startOfLocalWeek` takes the first day as an optional "
      "`int` (`DateTime.monday` to `DateTime.sunday`).",
    ),
    const Bullets([
      "On a `DateTime`, it defaults to the week start of the global "
          "localization. On this site, that's the language picked in the "
          "header.",
      "On a `Moment`, it defaults to the moment's own localization.",
      "`startOfIsoWeek()` always starts on Monday.",
    ]),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9);"),
      c(""),
      l(
        "pi.startOfLocalWeek()",
        () => DateTime(2024, 3, 14, 15, 9).startOfLocalWeek(),
      ),
      l(
        "pi.startOfLocalWeek(DateTime.saturday)",
        () => DateTime(2024, 3, 14, 15, 9).startOfLocalWeek(DateTime.saturday),
      ),
      l(
        "pi.toMoment(localization: MomentLocalizations.de()).startOfLocalWeek().weekday",
        () => DateTime(2024, 3, 14, 15, 9)
            .toMoment(localization: MomentLocalizations.de())
            .startOfLocalWeek()
            .weekday,
      ),
      l(
        "pi.toMoment(localization: MomentLocalizations.enUS()).startOfLocalWeek().weekday",
        () => DateTime(2024, 3, 14, 15, 9)
            .toMoment(localization: MomentLocalizations.enUS())
            .startOfLocalWeek()
            .weekday,
      ),
    ]),
    const P(
      "`weekday` is 1 for Monday and 7 for Sunday. German weeks start on "
      "Monday, American weeks on Sunday.",
    ),
    const H3("DurationUnit.week"),
    const P(
      "A `DateTime` has no localization to read a week start from, so "
      "`startOf(DurationUnit.week)` throws a `MomentException` on it. On a "
      "`Moment` it calls `startOfLocalWeek()` with the moment's localization.",
    ),
    Live(tick: false, [
      t(
        "DateTime(2024, 3, 14).startOf(DurationUnit.week)",
        () => DateTime(2024, 3, 14).startOf(DurationUnit.week),
      ),
      l(
        "DateTime(2024, 3, 14).toMoment().startOf(DurationUnit.week).toIso8601String()",
        () => DateTime(
          2024,
          3,
          14,
        ).toMoment().startOf(DurationUnit.week).toIso8601String(),
      ),
    ]),
    const P(
      "The second line follows the language in the header. The extension is "
      "chosen by static type: a `Moment` held in a `DateTime` variable throws "
      "too.",
    ),
    const H2("Timezones and daylight saving time"),
    const P(
      "The result is in the same timezone as the date you call it on. A UTC "
      "date gives UTC midnight; convert with `toLocal()` first if you want "
      "the start of the user's day.",
    ),
    Live(tick: false, [
      c("final utc = DateTime.utc(2024, 3, 14, 2, 30);"),
      c(""),
      l(
        "utc.startOfDay()",
        () => DateTime.utc(2024, 3, 14, 2, 30).startOfDay(),
      ),
      l(
        "utc.toLocal().startOfDay()",
        () => DateTime.utc(2024, 3, 14, 2, 30).toLocal().startOfDay(),
      ),
    ]),
    const P(
      "Hour, minute, second and millisecond starts are computed from the "
      "instant, not from the wall clock. During the repeated hour when "
      "clocks fall back, `startOfHour()` stays in the same copy of the hour "
      "as the date you passed. Day, week, month and year starts are built "
      "from the calendar fields, so they land on midnight of that day.",
    ),
    const H2("Shortcuts from now"),
    const P(
      "`Moment` has static shortcuts that start from `DateTime.now()` and "
      "return a local `DateTime`: `startOfToday()`, `startOfTomorrow()`, "
      "`startOfYesterday()`, and `startOfThis…`, `startOfNext…`, "
      "`startOfLast…` for `Hour`, `LocalWeek`, `IsoWeek`, `Month` and `Year`.",
    ),
    Live([
      l("Moment.startOfToday()", () => Moment.startOfToday()),
      l("Moment.startOfThisMonth()", () => Moment.startOfThisMonth()),
      l("Moment.startOfNextHour()", () => Moment.startOfNextHour()),
    ]),
    const P(
      "For the end of a unit, see [end of a unit](/extension/endOf). For the "
      "unit after or before this one, see "
      "[next and last units](/extension/relativeFinders).",
    ),
  ],
);
