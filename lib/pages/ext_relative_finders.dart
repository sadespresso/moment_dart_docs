import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage extRelativeFindersPage = DocPage(
  path: "/extension/relativeFinders",
  title: "Next and last units",
  group: "DateTime extensions",
  summary:
      "`startOfNextMonth()`, `endOfLastDay()` and the other relative "
      "finders return the start or end of the unit after or before the one a "
      "date falls in, in the date's own timezone.",
  blocks: () => [
    const H2("Usage"),
    const P(
      "\"Next\" and \"last\" mean the neighboring calendar unit, not a fixed "
      "distance. `startOfNextMonth()` on January 31 is February 1, and "
      "`endOfNextMonth()` is the end of February, however many days it has.",
    ),
    Live(tick: false, [
      c("final jan31 = DateTime(2024, 1, 31, 18, 45);"),
      c(""),
      l(
        "jan31.startOfNextMonth()",
        () => DateTime(2024, 1, 31, 18, 45).startOfNextMonth(),
      ),
      l(
        "jan31.endOfNextMonth()",
        () => DateTime(2024, 1, 31, 18, 45).endOfNextMonth(),
      ),
      l(
        "jan31.startOfLastYear()",
        () => DateTime(2024, 1, 31, 18, 45).startOfLastYear(),
      ),
    ]),
    const P(
      "Compare `add(Duration(days: 30))`, which counts 30 days of 24 hours "
      "and lands on March 1 here.",
    ),
    const H2("Next"),
    const P(
      "Both tables start from `DateTime(2024, 3, 14, 15, 9, 26)`, a Thursday. "
      "Ends are the next start minus one microsecond, as on "
      "[end of a unit](/extension/endOf).",
    ),
    TableBlock(
      ["Methods", "Start", "End"],
      [
        [
          "`startOfNextMinute()`, `endOfNextMinute()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfNextMinute(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfNextMinute(),
        ],
        [
          "`startOfNextHour()`, `endOfNextHour()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfNextHour(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfNextHour(),
        ],
        [
          "`startOfNextDay()`, `endOfNextDay()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfNextDay(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfNextDay(),
        ],
        [
          "`startOfNextLocalWeek([weekStart])`, "
              "`endOfNextLocalWeek([weekStart])`",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).startOfNextLocalWeek(DateTime.sunday),
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).endOfNextLocalWeek(DateTime.sunday),
        ],
        [
          "`startOfNextIsoWeek()`, `endOfNextIsoWeek()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfNextIsoWeek(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfNextIsoWeek(),
        ],
        [
          "`startOfNextMonth()`, `endOfNextMonth()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfNextMonth(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfNextMonth(),
        ],
        [
          "`startOfNextYear()`, `endOfNextYear()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfNextYear(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfNextYear(),
        ],
      ],
    ),
    const H2("Last"),
    TableBlock(
      ["Methods", "Start", "End"],
      [
        [
          "`startOfLastMinute()`, `endOfLastMinute()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfLastMinute(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfLastMinute(),
        ],
        [
          "`startOfLastHour()`, `endOfLastHour()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfLastHour(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfLastHour(),
        ],
        [
          "`startOfLastDay()`, `endOfLastDay()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfLastDay(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfLastDay(),
        ],
        [
          "`startOfLastLocalWeek([weekStart])`, "
              "`endOfLastLocalWeek([weekStart])`",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).startOfLastLocalWeek(DateTime.sunday),
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).endOfLastLocalWeek(DateTime.sunday),
        ],
        [
          "`startOfLastIsoWeek()`, `endOfLastIsoWeek()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfLastIsoWeek(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfLastIsoWeek(),
        ],
        [
          "`startOfLastMonth()`, `endOfLastMonth()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfLastMonth(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfLastMonth(),
        ],
        [
          "`startOfLastYear()`, `endOfLastYear()`",
          () => DateTime(2024, 3, 14, 15, 9, 26).startOfLastYear(),
          () => DateTime(2024, 3, 14, 15, 9, 26).endOfLastYear(),
        ],
      ],
    ),
    const P(
      "The local-week rows pass `DateTime.sunday`. There are no second or "
      "millisecond finders; use `startOfSecond() + Duration(seconds: 1)`.",
    ),
    const H2("Weeks"),
    const P(
      "The local-week finders take the first day of the week as an optional "
      "`int`. Leave it out and a `DateTime` uses the global localization's "
      "week start (on this site, the language in the header), while a "
      "`Moment` uses its own localization. The ISO-week finders always use "
      "Monday.",
    ),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9);"),
      c(""),
      l(
        "pi.startOfNextLocalWeek()",
        () => DateTime(2024, 3, 14, 15, 9).startOfNextLocalWeek(),
      ),
      l(
        "pi.toMoment(localization: MomentLocalizations.arPs()).startOfNextLocalWeek().weekday",
        () => DateTime(2024, 3, 14, 15, 9)
            .toMoment(localization: MomentLocalizations.arPs())
            .startOfNextLocalWeek()
            .weekday,
      ),
    ]),
    const P(
      "The Arabic (Palestine) localization starts weeks on Saturday, "
      "`weekday` 6.",
    ),
    const H2("Timezones and daylight saving time"),
    const P(
      "Results keep the timezone of the date you call them on; on a "
      "`Moment` they're `Moment`s with the same localization. Day, week, "
      "month and year finders work on calendar fields, so `startOfNextDay()` "
      "is midnight even when the day in between is 23 or 25 hours long. Hour "
      "and minute finders step through real instants, so across a "
      "fall-back transition `startOfNextHour()` is the next hour that "
      "actually happens, even when the clock shows the same hour again.",
    ),
    Live(tick: false, [
      c("final utc = DateTime.utc(2024, 12, 31, 22);"),
      c(""),
      l(
        "utc.startOfNextYear()",
        () => DateTime.utc(2024, 12, 31, 22).startOfNextYear(),
      ),
      l(
        "utc.toLocal().startOfNextYear()",
        () => DateTime.utc(2024, 12, 31, 22).toLocal().startOfNextYear(),
      ),
    ]),
    const P(
      "In timezones two or more hours ahead of UTC, the second line is "
      "already 2025 locally, so its next year is 2026.",
    ),
    const H2("Shortcuts from now"),
    const P(
      "`Moment.startOfTomorrow()`, `Moment.endOfYesterday()`, "
      "`Moment.startOfNextMonth()` and the other static shortcuts call these "
      "finders on `DateTime.now()` and return a local `DateTime`.",
    ),
    Live([
      l("Moment.startOfTomorrow()", () => Moment.startOfTomorrow()),
      l("Moment.endOfLastMonth()", () => Moment.endOfLastMonth()),
    ]),
  ],
);
