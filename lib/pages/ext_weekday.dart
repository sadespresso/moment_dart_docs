import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage extWeekdayPage = DocPage(
  path: "/extension/findWeekday",
  title: "Finding weekdays",
  group: "DateTime extensions",
  summary:
      "`nextMonday()`, `lastFriday()` and `nextWeekday(n)` move a date to "
      "the nearest given weekday after or before it, keeping the time of "
      "day.",
  blocks: () => [
    const H2("Usage"),
    const P(
      "Use these to schedule \"next Tuesday\" or to find the most recent "
      "payday. The result keeps the hour, minute and second of the date you "
      "start from, and its timezone.",
    ),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9); // a Thursday"),
      c(""),
      l("pi.nextMonday()", () => DateTime(2024, 3, 14, 15, 9).nextMonday()),
      l("pi.lastFriday()", () => DateTime(2024, 3, 14, 15, 9).lastFriday()),
      l(
        "pi.nextMonday().startOfDay()",
        () => DateTime(2024, 3, 14, 15, 9).nextMonday().startOfDay(),
      ),
    ]),
    const P("Chain `startOfDay()` when you need midnight of that day."),
    const H2("Today is neither next nor last"),
    const P(
      "If the date already falls on the weekday you ask for, the result is "
      "a week away: `nextThursday()` on a Thursday is the Thursday after, "
      "and `lastThursday()` is the one before. The result is never the same "
      "day.",
    ),
    Live(tick: false, [
      c("final thursday = DateTime(2024, 3, 14, 15, 9);"),
      c(""),
      l(
        "thursday.nextThursday()",
        () => DateTime(2024, 3, 14, 15, 9).nextThursday(),
      ),
      l(
        "thursday.lastThursday()",
        () => DateTime(2024, 3, 14, 15, 9).lastThursday(),
      ),
    ]),
    const P(
      "To include today, check `weekday` first: "
      "`d.weekday == DateTime.thursday ? d : d.nextThursday()`.",
    ),
    const H2("All weekdays"),
    const P("From `DateTime(2024, 3, 14, 15, 9)`, a Thursday:"),
    TableBlock(
      ["Methods", "next…", "last…"],
      [
        [
          "`nextMonday()`, `lastMonday()`",
          () => DateTime(2024, 3, 14, 15, 9).nextMonday(),
          () => DateTime(2024, 3, 14, 15, 9).lastMonday(),
        ],
        [
          "`nextTuesday()`, `lastTuesday()`",
          () => DateTime(2024, 3, 14, 15, 9).nextTuesday(),
          () => DateTime(2024, 3, 14, 15, 9).lastTuesday(),
        ],
        [
          "`nextWednesday()`, `lastWednesday()`",
          () => DateTime(2024, 3, 14, 15, 9).nextWednesday(),
          () => DateTime(2024, 3, 14, 15, 9).lastWednesday(),
        ],
        [
          "`nextThursday()`, `lastThursday()`",
          () => DateTime(2024, 3, 14, 15, 9).nextThursday(),
          () => DateTime(2024, 3, 14, 15, 9).lastThursday(),
        ],
        [
          "`nextFriday()`, `lastFriday()`",
          () => DateTime(2024, 3, 14, 15, 9).nextFriday(),
          () => DateTime(2024, 3, 14, 15, 9).lastFriday(),
        ],
        [
          "`nextSaturday()`, `lastSaturday()`",
          () => DateTime(2024, 3, 14, 15, 9).nextSaturday(),
          () => DateTime(2024, 3, 14, 15, 9).lastSaturday(),
        ],
        [
          "`nextSunday()`, `lastSunday()`",
          () => DateTime(2024, 3, 14, 15, 9).nextSunday(),
          () => DateTime(2024, 3, 14, 15, 9).lastSunday(),
        ],
      ],
    ),
    const H2("Weekday as a value"),
    const P(
      "`nextWeekday(int weekday)` and `lastWeekday(int weekday)` take the "
      "weekday as a number, for when it comes from settings or user input. "
      "Pass `DateTime.monday` (1) to `DateTime.sunday` (7).",
    ),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9);"),
      c("final payday = DateTime.friday;"),
      c(""),
      l(
        "pi.lastWeekday(payday)",
        () => DateTime(2024, 3, 14, 15, 9).lastWeekday(DateTime.friday),
      ),
      l(
        "pi.nextWeekday(payday)",
        () => DateTime(2024, 3, 14, 15, 9).nextWeekday(DateTime.friday),
      ),
    ]),
    const H2("Daylight saving time"),
    const P(
      "The finders move the calendar date and keep the wall-clock time. "
      "Across a daylight saving change, next Monday at 15:09 is still 15:09, "
      "even though the real time in between is a week plus or minus an "
      "hour. Before 6.0, the result drifted by an hour.",
    ),
    Live(tick: false, [
      c("final beforeChange = DateTime(2024, 3, 8, 15, 9);"),
      c(""),
      l(
        "beforeChange.nextFriday()",
        () => DateTime(2024, 3, 8, 15, 9).nextFriday(),
      ),
      l(
        "beforeChange.nextFriday().difference(beforeChange)",
        () => DateTime(
          2024,
          3,
          8,
          15,
          9,
        ).nextFriday().difference(DateTime(2024, 3, 8, 15, 9)),
      ),
    ]),
    const P(
      "Clocks in the United States and Canada moved forward on March 10, "
      "2024. If that's your timezone, the difference is 6 days and 23 hours; "
      "elsewhere it's 7 days.",
    ),
    const P(
      "On a `Moment`, every finder returns a `Moment` with the same "
      "localization.",
    ),
  ],
);
