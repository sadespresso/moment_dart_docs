import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage extGenericPage = DocPage(
  path: "/extension/generic",
  title: "Getters and operators",
  group: "DateTime extensions",
  summary:
      "Calendar getters such as `isLeapYear`, `quarter` and the ISO "
      "`week`, day differences, cloning and formatting, plus comparison and "
      "arithmetic operators for `DateTime`.",
  blocks: () => [
    const H2("Calendar getters"),
    const P(
      "All examples in this table read `DateTime(2024, 3, 14, 15, 9, 26)`, "
      "a Thursday afternoon in a leap year. Getters read the date's own "
      "fields, so a UTC date answers for its UTC wall clock.",
    ),
    TableBlock(
      ["Getter", "Returns", "Example"],
      [
        [
          "`date`",
          "A new date at 00:00 on the same day, in the same timezone.",
          () => DateTime(2024, 3, 14, 15, 9, 26).date,
        ],
        [
          "`isMidnight`",
          "Whether the time is exactly 00:00:00.000000.",
          () => DateTime(2024, 3, 14, 15, 9, 26).isMidnight,
        ],
        [
          "`isLeapYear`",
          "Whether `year` is a leap year in the Gregorian calendar.",
          () => DateTime(2024, 3, 14, 15, 9, 26).isLeapYear,
        ],
        [
          "`quarter`",
          "1 for January to March, up to 4 for October to December.",
          () => DateTime(2024, 3, 14, 15, 9, 26).quarter,
        ],
        [
          "`dayOfYear`",
          "1 for January 1, up to 365 (366 in a leap year).",
          () => DateTime(2024, 3, 14, 15, 9, 26).dayOfYear,
        ],
        [
          "`week`",
          "The [ISO 8601 week](https://en.wikipedia.org/wiki/ISO_week_date) "
              "number, 1 to 53.",
          () => DateTime(2024, 3, 14, 15, 9, 26).week,
        ],
        [
          "`weekYear`",
          "The year the ISO week belongs to.",
          () => DateTime(2024, 3, 14, 15, 9, 26).weekYear,
        ],
        [
          "`hour12`",
          "The hour on a 12-hour clock, 1 to 12.",
          () => DateTime(2024, 3, 14, 15, 9, 26).hour12,
        ],
        [
          "`isAm`",
          "Whether `hour` is before 12.",
          () => DateTime(2024, 3, 14, 15, 9, 26).isAm,
        ],
        [
          "`isPm`",
          "Whether `hour` is 12 or later.",
          () => DateTime(2024, 3, 14, 15, 9, 26).isPm,
        ],
        [
          "`lastDayOfMonth`",
          "The number of days in the month. See "
              "[clamped setters](/extension/set-clamped).",
          () => DateTime(2024, 3, 14, 15, 9, 26).lastDayOfMonth,
        ],
      ],
    ),
    const P(
      "On a `Moment`, `date` returns a `Moment` with the same localization.",
    ),
    const H3("ISO weeks across New Year"),
    const P(
      "ISO weeks start on Monday, and week 1 is the week with the year's "
      "first Thursday. The first days of January can belong to the last week "
      "of the previous year, and the last days of December to week 1 of the "
      "next. Read `weekYear` together with `week` when you label weeks.",
    ),
    Live(tick: false, [
      l("DateTime(2021, 1, 1).week", () => DateTime(2021, 1, 1).week),
      l("DateTime(2021, 1, 1).weekYear", () => DateTime(2021, 1, 1).weekYear),
      l("DateTime(2024, 12, 30).week", () => DateTime(2024, 12, 30).week),
      l(
        "DateTime(2024, 12, 30).weekYear",
        () => DateTime(2024, 12, 30).weekYear,
      ),
    ]),
    const P(
      "To count weeks from a localized week start (Sunday in the United "
      "States, for example), use "
      "[`startOfLocalWeek()`](/extension/startOf) instead.",
    ),
    const H2("Past and future"),
    const P(
      "`isPast` and `isFuture` compare the date with `DateTime.now()`. The "
      "anchored versions take the date to compare with as an optional "
      "positional argument, and fall back to now when you leave it out. A "
      "date equal to its anchor is neither past nor future.",
    ),
    Live([
      c("final launch = DateTime(1969, 7, 16, 13, 32);"),
      c(""),
      l("launch.isPast", () => DateTime(1969, 7, 16, 13, 32).isPast),
      l("launch.isFuture", () => DateTime(1969, 7, 16, 13, 32).isFuture),
      l(
        "launch.isFutureAnchored(DateTime(1969, 1, 1))",
        () => DateTime(
          1969,
          7,
          16,
          13,
          32,
        ).isFutureAnchored(DateTime(1969, 1, 1)),
      ),
      l(
        "launch.isPastAnchored(launch)",
        () => DateTime(
          1969,
          7,
          16,
          13,
          32,
        ).isPastAnchored(DateTime(1969, 7, 16, 13, 32)),
      ),
    ]),
    const H2("Difference in days"),
    const P(
      "`differenceInDays(other)` counts calendar days between two dates and "
      "ignores the time of day. It's positive when `other` is earlier. Use it "
      "for \"3 days ago\" style labels, where two minutes across midnight "
      "should count as a day and 23 hours on the same day should not.",
    ),
    Live(tick: false, [
      c("final lateNight = DateTime(2024, 3, 14, 23, 59);"),
      c("final earlyMorning = DateTime(2024, 3, 15, 0, 1);"),
      c(""),
      l(
        "lateNight.differenceInDays(earlyMorning)",
        () => DateTime(
          2024,
          3,
          14,
          23,
          59,
        ).differenceInDays(DateTime(2024, 3, 15, 0, 1)),
      ),
      l(
        "earlyMorning.differenceInDays(lateNight)",
        () => DateTime(
          2024,
          3,
          15,
          0,
          1,
        ).differenceInDays(DateTime(2024, 3, 14, 23, 59)),
      ),
      l(
        "earlyMorning.difference(lateNight).inDays",
        () => DateTime(
          2024,
          3,
          15,
          0,
          1,
        ).difference(DateTime(2024, 3, 14, 23, 59)).inDays,
      ),
    ]),
    const P(
      "Since 6.0 it compares the year, month and day fields directly. Before, "
      "it was off by one across a 23-hour day at the start of daylight "
      "saving time.",
    ),
    const Note(NoteKind.warning, [
      P(
        "Comparing fields means timezones are ignored: each date is read in "
        "its own timezone. A local date and its UTC copy can be a day apart, "
        "depending on where you are. Convert both to the same timezone "
        "first.",
      ),
    ]),
    Live(tick: false, [
      c("final local = DateTime(2024, 3, 14, 23, 30);"),
      c(""),
      l(
        "local.differenceInDays(local.toUtc())",
        () => DateTime(
          2024,
          3,
          14,
          23,
          30,
        ).differenceInDays(DateTime(2024, 3, 14, 23, 30).toUtc()),
      ),
      l(
        "local.differenceInDays(local.toUtc().toLocal())",
        () => DateTime(
          2024,
          3,
          14,
          23,
          30,
        ).differenceInDays(DateTime(2024, 3, 14, 23, 30).toUtc().toLocal()),
      ),
    ]),
    const H2("Timezone offset as text"),
    const P(
      "`timeZoneFormatted()` returns the offset as `+HH:mm`. Pass `false` to "
      "drop the colon. The first line shows your own offset.",
    ),
    Live(tick: false, [
      l(
        "DateTime(2024, 3, 14).timeZoneFormatted()",
        () => DateTime(2024, 3, 14).timeZoneFormatted(),
      ),
      l(
        "DateTime.utc(2024, 3, 14).timeZoneFormatted()",
        () => DateTime.utc(2024, 3, 14).timeZoneFormatted(),
      ),
      l(
        "DateTime(2024, 3, 14).timeZoneFormatted(false)",
        () => DateTime(2024, 3, 14).timeZoneFormatted(false),
      ),
    ]),
    const H2("Copying and converting"),
    TableBlock(
      ["Method", "What it does"],
      [
        [
          "`clone()`",
          "A new date at the same instant and in the same timezone. On a "
              "`Moment`, a new `Moment` with the same localization.",
        ],
        [
          "`toMoment({localization})`",
          "Wraps the date in a `Moment`. Without `localization`, the moment "
              "uses the [global localization](/global-localization).",
        ],
        [
          "`format({payload, forceLocal, localization})`",
          "Formats without creating a `Moment` yourself. `payload` defaults "
              "to `\"l\"`. See [formatting](/formatting).",
        ],
        [
          "`rangeTo(other)`",
          "A `CustomTimeRange` between the two dates, earlier one first. See "
              "[time ranges](/time-range).",
        ],
        [
          "`rangeToMax()`",
          "A `CustomTimeRange` from the date to `Moment.maxValue`.",
        ],
        [
          "`forcedSuperType`",
          "`Moment` only: the moment typed as `DateTime`, so the `DateTime` "
              "versions of the extensions apply.",
        ],
      ],
    ),
    Live(tick: false, [
      c("final pi = DateTime(2024, 3, 14, 15, 9, 26);"),
      c(""),
      l("pi.clone() == pi", () {
        final DateTime pi = DateTime(2024, 3, 14, 15, 9, 26);
        return pi.clone() == pi;
      }),
      l("identical(pi.clone(), pi)", () {
        final DateTime pi = DateTime(2024, 3, 14, 15, 9, 26);
        return identical(pi.clone(), pi);
      }),
      l(
        "pi.format(payload: \"dddd, LT\")",
        () => DateTime(2024, 3, 14, 15, 9, 26).format(payload: "dddd, LT"),
      ),
      l(
        "pi.format(payload: \"LL\", localization: MomentLocalizations.fr())",
        () => DateTime(
          2024,
          3,
          14,
          15,
          9,
          26,
        ).format(payload: "LL", localization: MomentLocalizations.fr()),
      ),
      l(
        "pi.rangeTo(DateTime(2024, 1, 1)).from",
        () =>
            DateTime(2024, 3, 14, 15, 9, 26).rangeTo(DateTime(2024, 1, 1)).from,
      ),
    ]),
    const Note(NoteKind.info, [
      P(
        "`rangeToMax()` builds its range with the local `Moment.maxValue`, so "
        "call it on a local date. On a UTC date it fails the timezone "
        "assertion in `CustomTimeRange` in debug builds.",
      ),
    ]),
    const H2("Operators"),
    const P(
      "The extensions add operators that read better than method calls in "
      "conditions and arithmetic.",
    ),
    const TableBlock(
      ["Operator", "Same as"],
      [
        ["`a + duration`", "`a.add(duration)`"],
        ["`a - duration`", "`a.subtract(duration)`"],
        ["`a < b`", "`a.isBefore(b)`"],
        ["`a > b`", "`a.isAfter(b)`"],
        ["`a <= b`", "`a.isBefore(b) || a.isAtSameMomentAs(b)`"],
        ["`a >= b`", "`a.isAfter(b) || a.isAtSameMomentAs(b)`"],
      ],
    ),
    Live([
      c("final landing = DateTime.utc(1969, 7, 20, 20, 17);"),
      c(""),
      l(
        "landing < DateTime.now()",
        () => DateTime.utc(1969, 7, 20, 20, 17) < DateTime.now(),
      ),
      l(
        "landing + Duration(hours: 6, minutes: 39)",
        () =>
            DateTime.utc(1969, 7, 20, 20, 17) +
            const Duration(hours: 6, minutes: 39),
      ),
      l(
        "landing >= landing.toLocal()",
        () =>
            DateTime.utc(1969, 7, 20, 20, 17) >=
            DateTime.utc(1969, 7, 20, 20, 17).toLocal(),
      ),
    ]),
    const P(
      "The comparison operators compare instants, so a UTC date and its "
      "local copy are equal for `<=` and `>=`. On a `Moment`, `+` and `-` "
      "return a `Moment`.",
    ),
    const Note(NoteKind.warning, [
      P(
        "There is no `==` operator from moment_dart. `DateTime.==` also "
        "checks that both dates have the same timezone, so a UTC date never "
        "equals a local one. Use `isAtSameMomentAs` to compare instants.",
      ),
    ]),
    Live(tick: false, [
      l(
        "DateTime.utc(1970) == DateTime.fromMillisecondsSinceEpoch(0)",
        () => DateTime.utc(1970) == DateTime.fromMillisecondsSinceEpoch(0),
      ),
      l(
        "DateTime.utc(1970).isAtSameMomentAs(DateTime.fromMillisecondsSinceEpoch(0))",
        () =>
            DateTime.utc(1970)
                .isAtSameMomentAs(DateTime.fromMillisecondsSinceEpoch(0)),
      ),
    ]),
    const H2("On Duration"),
    const P(
      "`Duration` gets whole-unit getters to go with Dart's `inDays`. They "
      "use fixed lengths, not the calendar: a month is 30 days and a year is "
      "365. For text like \"2 hours 5 minutes\", call `toDurationString()`, "
      "which takes the same options as "
      "[precise durations](/duration/precise).",
    ),
    Live(tick: false, [
      l("Duration(days: 45).inWeeks", () => const Duration(days: 45).inWeeks),
      l("Duration(days: 45).inMonths", () => const Duration(days: 45).inMonths),
      l("Duration(days: 400).inYears", () => const Duration(days: 400).inYears),
    ]),
  ],
);
