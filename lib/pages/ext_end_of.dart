import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage extEndOfPage = DocPage(
  path: "/extension/endOf",
  title: "End of a unit",
  group: "DateTime extensions",
  summary:
      "`endOfDay()`, `endOfMonth()`, `endOf(DurationUnit.year)` and the "
      "other end-of-unit helpers return the last microsecond of the unit a "
      "date falls in, in the date's own timezone.",
  blocks: () => [
    const H2("Usage"),
    const P(
      "Each `startOf…` method on [start of a unit](/extension/startOf) has an "
      "`endOf…` counterpart. Use it for the inclusive upper bound of a range: "
      "everything up to and including the last microsecond of the day.",
    ),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9, 26, 535, 897);"),
      c(""),
      l(
        "pi.endOfDay()",
        () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfDay(),
      ),
      l(
        "pi.endOf(DurationUnit.day)",
        () =>
            DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOf(DurationUnit.day),
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
          "`endOfMillisecond()`",
          "`endOf(DurationUnit.millisecond)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfMillisecond(),
        ],
        [
          "`endOfSecond()`",
          "`endOf(DurationUnit.second)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfSecond(),
        ],
        [
          "`endOfMinute()`",
          "`endOf(DurationUnit.minute)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfMinute(),
        ],
        [
          "`endOfHour()`",
          "`endOf(DurationUnit.hour)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfHour(),
        ],
        [
          "`endOfDay()`",
          "`endOf(DurationUnit.day)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfDay(),
        ],
        [
          "`endOfLocalWeek([weekStart])`",
          "`endOf(DurationUnit.week)`, on `Moment` only",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
            535,
            897,
          ).endOfLocalWeek(DateTime.sunday),
        ],
        [
          "`endOfIsoWeek()`",
          "`endOfLocalWeek(DateTime.monday)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfIsoWeek(),
        ],
        [
          "`endOfMonth()`",
          "`endOf(DurationUnit.month)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfMonth(),
        ],
        [
          "`endOfYear()`",
          "`endOf(DurationUnit.year)`",
          () => DateTime(2024, 3, 14, 15, 9, 26, 535, 897).endOfYear(),
        ],
      ],
    ),
    const P(
      "The `endOfLocalWeek` example passes `DateTime.sunday`, so the week "
      "ends on Saturday. `endOf(DurationUnit.microsecond)` returns a copy of "
      "the date.",
    ),
    const H2("Next start minus one microsecond"),
    const P(
      "Since 6.0, every end is computed as the start of the next unit minus "
      "one microsecond, not by setting the fields to 23:59:59.999999. Adding "
      "a microsecond to an end always gives the next start.",
    ),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9);"),
      c(""),
      l(
        "pi.endOfDay() + Duration(microseconds: 1) == pi.startOfNextDay()",
        () =>
            DateTime(2024, 3, 14, 15, 9).endOfDay() +
                const Duration(microseconds: 1) ==
            DateTime(2024, 3, 14, 15, 9).startOfNextDay(),
      ),
      l(
        "pi.endOfMonth() + Duration(microseconds: 1) == pi.startOfNextMonth()",
        () =>
            DateTime(2024, 3, 14, 15, 9).endOfMonth() +
                const Duration(microseconds: 1) ==
            DateTime(2024, 3, 14, 15, 9).startOfNextMonth(),
      ),
    ]),
    const P(
      "The difference shows around daylight saving time. Where clocks fall "
      "back at midnight (America/Santiago, for example), 23:00 to 23:59 "
      "happens twice. Building 23:59:59.999999 from fields picks the first "
      "copy, which can be earlier than the date you started from. The 6.0 "
      "result is the real last microsecond of the day.",
    ),
    const P(
      "A day isn't always 24 hours long. The lines below measure two days "
      "when clocks moved forward: March 10, 2024 in the United States and "
      "Canada, and March 31, 2024 in most of Europe. In those timezones the "
      "day is an hour shorter; elsewhere you'll see 24 hours less a "
      "microsecond.",
    ),
    Live(tick: false, [
      l(
        "DateTime(2024, 3, 10).endOfDay().difference(DateTime(2024, 3, 10))",
        () =>
            DateTime(2024, 3, 10).endOfDay().difference(DateTime(2024, 3, 10)),
      ),
      l(
        "DateTime(2024, 3, 31).endOfDay().difference(DateTime(2024, 3, 31))",
        () =>
            DateTime(2024, 3, 31).endOfDay().difference(DateTime(2024, 3, 31)),
      ),
    ]),
    const P(
      "Hour, minute, second and millisecond ends step to the next start of "
      "that unit after the date, so they also work where an offset changes "
      "by half an hour.",
    ),
    const H2("Weeks"),
    const P(
      "`endOfLocalWeek` takes the first day of the week, not the last, so "
      "the same `weekStart` gives a matching start and end. It defaults to "
      "the global localization on a `DateTime` (on this site, the language "
      "in the header) and to the moment's localization on a `Moment`. "
      "`endOfIsoWeek()` always ends on Sunday.",
    ),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9);"),
      c(""),
      l(
        "pi.endOfLocalWeek()",
        () => DateTime(2024, 3, 14, 15, 9).endOfLocalWeek(),
      ),
      l(
        "pi.endOfLocalWeek(DateTime.saturday)",
        () => DateTime(2024, 3, 14, 15, 9).endOfLocalWeek(DateTime.saturday),
      ),
    ]),
    const H3("DurationUnit.week"),
    const P(
      "On a `DateTime`, `endOf(DurationUnit.week)` throws a "
      "`MomentException`, because a plain date has no localization to read "
      "the week start from. On a `Moment`, it is `endOfLocalWeek()` with the "
      "moment's localization: Saturday night for American English, Sunday "
      "night for German.",
    ),
    Live(tick: false, [
      t(
        "DateTime(2024, 3, 14).endOf(DurationUnit.week)",
        () => DateTime(2024, 3, 14).endOf(DurationUnit.week),
      ),
      l(
        "DateTime(2024, 3, 14).toMoment(localization: MomentLocalizations.enUS()).endOf(DurationUnit.week).toIso8601String()",
        () => DateTime(2024, 3, 14)
            .toMoment(localization: MomentLocalizations.enUS())
            .endOf(DurationUnit.week)
            .toIso8601String(),
      ),
      l(
        "DateTime(2024, 3, 14).toMoment(localization: MomentLocalizations.de()).endOf(DurationUnit.week).toIso8601String()",
        () => DateTime(2024, 3, 14)
            .toMoment(localization: MomentLocalizations.de())
            .endOf(DurationUnit.week)
            .toIso8601String(),
      ),
    ]),
    const P(
      "These lines call `toIso8601String()` because a `Moment` prints with "
      "the localized `LLL` format, which drops the seconds.",
    ),
    const H2("Shortcuts from now"),
    const P(
      "Like the start helpers, `Moment` has static shortcuts that return a "
      "local `DateTime`: `endOfToday()`, `endOfTomorrow()`, "
      "`endOfYesterday()`, and `endOfThis…`, `endOfNext…`, `endOfLast…` for "
      "`Hour`, `LocalWeek`, `IsoWeek`, `Month` and `Year`.",
    ),
    Live([
      l("Moment.endOfToday()", () => Moment.endOfToday()),
      l("Moment.endOfThisMonth()", () => Moment.endOfThisMonth()),
    ]),
  ],
);
