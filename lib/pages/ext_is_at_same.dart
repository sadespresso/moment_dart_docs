import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage extIsAtSamePage = DocPage(
  path: "/extension/isAtSame",
  title: "Comparing units",
  group: "DateTime extensions",
  summary:
      "`isAtSameDayAs()`, `isAtSameMonthAs()` and the other unit "
      "comparisons check whether two dates fall in the same unit, seen from "
      "the first date's timezone. **Changed in 6.0.**",
  blocks: () => [
    const H2("Usage"),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9);"),
      c(""),
      l(
        "pi.isAtSameDayAs(DateTime(2024, 3, 14, 23, 59))",
        () => DateTime(
          2024,
          3,
          14,
          15,
          9,
        ).isAtSameDayAs(DateTime(2024, 3, 14, 23, 59)),
      ),
      l(
        "pi.isAtSameDayAs(DateTime(2024, 3, 15))",
        () => DateTime(2024, 3, 14, 15, 9).isAtSameDayAs(DateTime(2024, 3, 15)),
      ),
      l(
        "pi.isAtSameMonthAs(DateTime(2024, 3, 1))",
        () =>
            DateTime(2024, 3, 14, 15, 9).isAtSameMonthAs(DateTime(2024, 3, 1)),
      ),
      l(
        "pi.isAtSameYearAs(DateTime(2023, 3, 14))",
        () =>
            DateTime(2024, 3, 14, 15, 9).isAtSameYearAs(DateTime(2023, 3, 14)),
      ),
    ]),
    const H2("All methods"),
    const P(
      "Each method takes the other date and an optional `enforceUTC` flag, "
      "and returns a `bool`. The examples compare "
      "`DateTime(2024, 3, 14, 15, 9, 26)` with "
      "`DateTime(2024, 3, 14, 15, 41)`, 31 minutes and 34 seconds later.",
    ),
    TableBlock(
      ["Method", "Same…", "Example"],
      [
        [
          "`isAtSameYearAs(other)`",
          "year",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).isAtSameYearAs(DateTime(2024, 3, 14, 15, 41)),
        ],
        [
          "`isAtSameMonthAs(other)`",
          "month and year",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).isAtSameMonthAs(DateTime(2024, 3, 14, 15, 41)),
        ],
        [
          "`isAtSameDayAs(other)`",
          "calendar day",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).isAtSameDayAs(DateTime(2024, 3, 14, 15, 41)),
        ],
        [
          "`isAtSameHourAs(other)`",
          "hour of that day",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).isAtSameHourAs(DateTime(2024, 3, 14, 15, 41)),
        ],
        [
          "`isAtSameMinuteAs(other)`",
          "minute",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).isAtSameMinuteAs(DateTime(2024, 3, 14, 15, 41)),
        ],
        [
          "`isAtSameSecondAs(other)`",
          "second",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).isAtSameSecondAs(DateTime(2024, 3, 14, 15, 41)),
        ],
        [
          "`isAtSameMillisecondAs(other)`",
          "millisecond",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).isAtSameMillisecondAs(DateTime(2024, 3, 14, 15, 41)),
        ],
        [
          "`isAtSameMicrosecondAs(other)`",
          "microsecond, the same instant",
          () => DateTime(
            2024,
            3,
            14,
            15,
            9,
            26,
          ).isAtSameMicrosecondAs(DateTime(2024, 3, 14, 15, 41)),
        ],
      ],
    ),
    const P(
      "The comparisons cascade: if two dates are in the same day, they are "
      "also in the same month and year, and the same hour implies the same "
      "day. Each method checks the whole unit, not one field: "
      "`isAtSameDayAs` is false for March 14 and April 14.",
    ),
    const H2("How 6.0 compares"),
    const P(
      "The method converts `other` to the timezone of the date you call it "
      "on, takes the start of the unit for both, and compares those starts "
      "as instants. That matches `isSame` in moment.js.",
    ),
    const P(
      "In 5.x, the methods compared raw fields such as `year`, `month` and "
      "`day` without converting. A local date and its UTC copy are the same "
      "instant, but their fields differ in most timezones, so they usually "
      "didn't match. Now they do:",
    ),
    Live(tick: false, [
      c("final local = DateTime(2024, 3, 14, 22, 30);"),
      c("final utc = local.toUtc();"),
      c(""),
      l("local.hour == utc.hour", () {
        final DateTime local = DateTime(2024, 3, 14, 22, 30);
        return local.hour == local.toUtc().hour;
      }),
      l("local.isAtSameHourAs(utc)", () {
        final DateTime local = DateTime(2024, 3, 14, 22, 30);
        return local.isAtSameHourAs(local.toUtc());
      }),
      l("local.isAtSameDayAs(utc)", () {
        final DateTime local = DateTime(2024, 3, 14, 22, 30);
        return local.isAtSameDayAs(local.toUtc());
      }),
      l("utc.isAtSameDayAs(local)", () {
        final DateTime local = DateTime(2024, 3, 14, 22, 30);
        return local.toUtc().isAtSameDayAs(local);
      }),
    ]),
    const P(
      "The first line is what 5.x effectively did. It's `false` unless your "
      "timezone was at UTC+00:00 on that date. The other lines are `true` "
      "everywhere.",
    ),
    const H3("The first date's timezone decides"),
    const P(
      "Because `other` is converted to the receiver's timezone, swapping the "
      "two dates can change the answer when they are in different timezones. "
      "These two instants are an hour apart, on either side of midnight UTC.",
    ),
    Live(tick: false, [
      c("final beforeMidnight = DateTime.utc(2024, 3, 14, 23, 30);"),
      c("final afterMidnight = DateTime.utc(2024, 3, 15, 0, 30).toLocal();"),
      c(""),
      l(
        "beforeMidnight.isAtSameDayAs(afterMidnight)",
        () => DateTime.utc(
          2024,
          3,
          14,
          23,
          30,
        ).isAtSameDayAs(DateTime.utc(2024, 3, 15, 0, 30).toLocal()),
      ),
      l(
        "afterMidnight.isAtSameDayAs(beforeMidnight)",
        () => DateTime.utc(
          2024,
          3,
          15,
          0,
          30,
        ).toLocal().isAtSameDayAs(DateTime.utc(2024, 3, 14, 23, 30)),
      ),
    ]),
    const P(
      "The first line asks in UTC, where the two fall on different days. "
      "The second asks in your timezone, where both are usually on the same "
      "day; it's only `false` if your offset is within half an hour of UTC.",
    ),
    const H2("enforceUTC"),
    const P(
      "Pass `enforceUTC: true` to convert both dates to UTC before comparing. "
      "The answer then no longer depends on which date comes first or on the "
      "device's timezone. Use it for server-side grouping, or any time a "
      "\"day\" means a UTC day.",
    ),
    Live(tick: false, [
      c("final beforeMidnight = DateTime.utc(2024, 3, 14, 23, 30);"),
      c("final afterMidnight = DateTime.utc(2024, 3, 15, 0, 30).toLocal();"),
      c(""),
      l(
        "afterMidnight.isAtSameDayAs(beforeMidnight, enforceUTC: true)",
        () => DateTime.utc(2024, 3, 15, 0, 30).toLocal().isAtSameDayAs(
          DateTime.utc(2024, 3, 14, 23, 30),
          enforceUTC: true,
        ),
      ),
    ]),
    const Note(NoteKind.info, [
      P(
        "Coming from 5.x and relied on comparing wall-clock fields across "
        "timezones? Convert both dates yourself first, or pass "
        "`enforceUTC: true`. See [upgrading](/upgrading).",
      ),
    ]),
    const H2("Weeks"),
    const P(
      "There is no `isAtSameWeekAs`, because a week's start depends on the "
      "locale. Use `isSameLocalWeekAs(other, [weekStart])`, which checks "
      "whether `other` falls between `startOfLocalWeek(weekStart)` and "
      "`endOfLocalWeek(weekStart)` of the receiver. Like the methods above, "
      "it compares instants, so `other` may be in either timezone.",
    ),
    const Bullets([
      "On a `DateTime`, `weekStart` is optional and defaults to the global "
          "localization's week start. On this site, that's the language "
          "picked in the header.",
      "On a `Moment`, the method takes no `weekStart`; it uses the "
          "moment's localization.",
      "For ISO weeks, pass `DateTime.monday`, or compare `week` and "
          "`weekYear`.",
    ]),
    Live(tick: false, [
      c("final thursday = DateTime(2024, 3, 14, 15, 9);"),
      c("final sunday = DateTime(2024, 3, 17, 10);"),
      c(""),
      l(
        "thursday.isSameLocalWeekAs(sunday, DateTime.monday)",
        () => DateTime(
          2024,
          3,
          14,
          15,
          9,
        ).isSameLocalWeekAs(DateTime(2024, 3, 17, 10), DateTime.monday),
      ),
      l(
        "thursday.isSameLocalWeekAs(sunday, DateTime.sunday)",
        () => DateTime(
          2024,
          3,
          14,
          15,
          9,
        ).isSameLocalWeekAs(DateTime(2024, 3, 17, 10), DateTime.sunday),
      ),
      l(
        "thursday.toMoment(localization: MomentLocalizations.de()).isSameLocalWeekAs(sunday)",
        () => DateTime(2024, 3, 14, 15, 9)
            .toMoment(localization: MomentLocalizations.de())
            .isSameLocalWeekAs(DateTime(2024, 3, 17, 10)),
      ),
      l(
        "thursday.week == sunday.week && thursday.weekYear == sunday.weekYear",
        () =>
            DateTime(2024, 3, 14, 15, 9).week ==
                DateTime(2024, 3, 17, 10).week &&
            DateTime(2024, 3, 14, 15, 9).weekYear ==
                DateTime(2024, 3, 17, 10).weekYear,
      ),
    ]),
  ],
);
