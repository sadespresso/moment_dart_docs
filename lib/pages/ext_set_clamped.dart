import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage extSetClampedPage = DocPage(
  path: "/extension/set-clamped",
  title: "Clamped setters",
  group: "DateTime extensions",
  summary:
      "`setClampedDay()`, `setClampedMonth()` and the other clamped "
      "setters change one field of a date and keep it in range, instead of "
      "rolling over into the next month or hour.",
  blocks: () => [
    const H2("Why"),
    const P(
      "`DateTime.copyWith` and the `DateTime` constructor accept "
      "out-of-range values and carry the overflow into the next unit. "
      "February 30 becomes March 1. That's useful for date math, but wrong "
      "when a user picks \"day 30\" for a monthly reminder and expects the "
      "last day of February.",
    ),
    Live(tick: false, [
      c("final feb = DateTime(2024, 2, 1);"),
      c(""),
      l("feb.copyWith(day: 30)", () => DateTime(2024, 2, 1).copyWith(day: 30)),
      l("feb.setClampedDay(30)", () => DateTime(2024, 2, 1).setClampedDay(30)),
    ]),
    const H2("All setters"),
    const P(
      "Each setter clamps the value you pass, then calls `copyWith`. The "
      "other fields and the timezone stay as they are. The examples start "
      "from `DateTime(2023, 1, 31, 15, 9, 26)`.",
    ),
    TableBlock(
      ["Method", "Clamps to", "Example"],
      [
        [
          "`setClampedSecond(70)`",
          "0 to 59",
          () => DateTime(2023, 1, 31, 15, 9, 26).setClampedSecond(70),
        ],
        [
          "`setClampedMinute(-5)`",
          "0 to 59",
          () => DateTime(2023, 1, 31, 15, 9, 26).setClampedMinute(-5),
        ],
        [
          "`setClampedHour(24)`",
          "0 to 23",
          () => DateTime(2023, 1, 31, 15, 9, 26).setClampedHour(24),
        ],
        [
          "`setClampedDay(0)`",
          "1 to the last day of the month",
          () => DateTime(2023, 1, 31, 15, 9, 26).setClampedDay(0),
        ],
        [
          "`setClampedMonth(DateTime.february)`",
          "1 to 12, then clamps the day to the new month",
          () => DateTime(
            2023,
            1,
            31,
            15,
            9,
            26,
          ).setClampedMonth(DateTime.february),
        ],
      ],
    ),
    const P(
      "On a `Moment`, each setter returns a `Moment` with the same "
      "localization. There is no clamped setter for milliseconds, "
      "microseconds or the year.",
    ),
    const H2("Months and days"),
    const P(
      "`setClampedMonth` is the only setter that touches a second field. "
      "Moving January 31 to February has to change the day too, so it "
      "clamps the day to the last day of the new month. Other days are kept.",
    ),
    Live(tick: false, [
      l(
        "DateTime(2023, 1, 31).setClampedMonth(DateTime.february)",
        () => DateTime(2023, 1, 31).setClampedMonth(DateTime.february),
      ),
      l(
        "DateTime(2024, 1, 31).setClampedMonth(DateTime.february)",
        () => DateTime(2024, 1, 31).setClampedMonth(DateTime.february),
      ),
      l(
        "DateTime(2024, 2, 29).setClampedMonth(DateTime.december)",
        () => DateTime(2024, 2, 29).setClampedMonth(DateTime.december),
      ),
      l(
        "DateTime(2024, 5, 31).setClampedMonth(13)",
        () => DateTime(2024, 5, 31).setClampedMonth(13),
      ),
    ]),
    const P(
      "A month past 12 becomes December of the same year, not January of "
      "the next. Use `startOfNextMonth()` and the other "
      "[relative finders](/extension/relativeFinders) to move between "
      "months.",
    ),
    const H3("lastDayOfMonth"),
    const P(
      "The setters read the month's length from the `lastDayOfMonth` "
      "getter, which you can use on its own.",
    ),
    Live(tick: false, [
      l(
        "DateTime(2023, 2, 10).lastDayOfMonth",
        () => DateTime(2023, 2, 10).lastDayOfMonth,
      ),
      l(
        "DateTime(2024, 2, 10).lastDayOfMonth",
        () => DateTime(2024, 2, 10).lastDayOfMonth,
      ),
      l(
        "DateTime(2024, 4, 10).lastDayOfMonth",
        () => DateTime(2024, 4, 10).lastDayOfMonth,
      ),
    ]),
    const H2("Changing the year"),
    const P(
      "Without a clamped year setter, `copyWith(year: …)` on February 29 "
      "rolls over to March 1. Move to the first of the month, change the "
      "year, then clamp the day back.",
    ),
    Live(tick: false, [
      c("final leapDay = DateTime(2024, 2, 29);"),
      c(""),
      l(
        "leapDay.copyWith(year: 2023)",
        () => DateTime(2024, 2, 29).copyWith(year: 2023),
      ),
      l(
        "leapDay.copyWith(year: 2023, day: 1).setClampedDay(leapDay.day)",
        () => DateTime(
          2024,
          2,
          29,
        ).copyWith(year: 2023, day: 1).setClampedDay(DateTime(2024, 2, 29).day),
      ),
    ]),
  ],
);
