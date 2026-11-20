import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage commonMishapsPage = DocPage(
  path: "/common-mishaps",
  title: "Common mishaps",
  group: "Start here",
  summary:
      "Mistakes that come up again and again when working with dates in "
      "Dart, most of them about timezones. Few are specific to moment_dart, "
      "but its helpers make them easy to make.",
  blocks: () => [
    const H2("Showing a UTC date to a person"),
    const P(
      "Dates from APIs, ISO 8601 strings and generated clients are usually "
      "in UTC. `DateTime` keeps the timezone it was given, so formatting one "
      "shows UTC wall-clock time, which is rarely what the user expects. "
      "Convert with `toLocal()` first.",
    ),
    Live(tick: false, [
      c("final createdAt = Moment.parse(\"2024-06-02T15:00:00Z\");"),
      c(""),
      l("createdAt.isUtc", () => Moment.parse("2024-06-02T15:00:00Z").isUtc),
      l("createdAt.LT", () => Moment.parse("2024-06-02T15:00:00Z").LT),
      l(
        "createdAt.toLocal().LT",
        () => Moment.parse("2024-06-02T15:00:00Z").toLocal().LT,
      ),
    ]),
    const P(
      "The last line shows the time in your timezone, so the two results "
      "match only if you're on UTC. `format` also takes `forceLocal: true` "
      "(positional on `Moment.format`, named on `DateTime.format`) for the "
      "same effect.",
    ),
    const H2("Counting days across timezones"),
    const P(
      "`differenceInDays` compares the calendar dates of two values as they "
      "are, without converting either one. That keeps it correct across "
      "daylight saving changes, but a UTC date and a local date of the same "
      "instant can be on different calendar days.",
    ),
    Live(tick: false, [
      c("final utc = DateTime.utc(2024, 6, 1, 23, 30);"),
      c("final local = utc.toLocal();"),
      c(""),
      l(
        "utc.differenceInDays(local)",
        () => DateTime.utc(
          2024,
          6,
          1,
          23,
          30,
        ).differenceInDays(DateTime.utc(2024, 6, 1, 23, 30).toLocal()),
      ),
      l(
        "utc.toLocal().differenceInDays(local)",
        () => DateTime.utc(2024, 6, 1, 23, 30).toLocal().differenceInDays(
          DateTime.utc(2024, 6, 1, 23, 30).toLocal(),
        ),
      ),
    ]),
    const P(
      "The first result is `-1` east of UTC and `0` elsewhere. Put both "
      "dates in the same timezone before counting days, usually the local "
      "one.",
    ),
    const P(
      "The `isAtSame…As` methods work the other way since 6.0: they convert "
      "the other date into this one's timezone first and compare instants. "
      "See [isAtSame](/extension/isAtSame).",
    ),
    const H2("Comparing with =="),
    const P(
      "`==` on `DateTime` is true only when both the instant and the "
      "timezone match. Use `isAtSameMomentAs` to compare instants.",
    ),
    Live(tick: false, [
      c("final utc = DateTime.utc(2024, 1, 1);"),
      c(""),
      l(
        "utc == utc.toLocal()",
        () => DateTime.utc(2024, 1, 1) == DateTime.utc(2024, 1, 1).toLocal(),
      ),
      l(
        "utc.isAtSameMomentAs(utc.toLocal())",
        () => DateTime.utc(
          2024,
          1,
          1,
        ).isAtSameMomentAs(DateTime.utc(2024, 1, 1).toLocal()),
      ),
    ]),
    const H2("Storing toString()"),
    const P(
      "`Moment.toString()` returns the human-readable `LLL` format in the "
      "moment's language, not ISO 8601. It loses the seconds and the "
      "timezone and can't be parsed back. Store and send "
      "`toIso8601String()` or `millisecondsSinceEpoch` instead.",
    ),
    Live(tick: false, [
      c("final m = Moment(DateTime(2024, 3, 15, 9, 30));"),
      c(""),
      l("m.toString()", () => Moment(DateTime(2024, 3, 15, 9, 30)).toString()),
      l(
        "m.toIso8601String()",
        () => Moment(DateTime(2024, 3, 15, 9, 30)).toIso8601String(),
      ),
      t(
        "Moment.parse(m.toString())",
        () => Moment.parse(Moment(DateTime(2024, 3, 15, 9, 30)).toString()),
      ),
    ]),
    const P(
      "String interpolation calls `toString()` too, so `\"\$m\"` is also the "
      "readable form.",
    ),
    const H2("Letters in a format string"),
    const P(
      "Format strings are made of [tokens](/formatting#formatter-tokens), and "
      "many single letters are tokens: `a` is am/pm, `D` is the day, `h` is "
      "the hour. Wrap literal text in square brackets.",
    ),
    Live(tick: false, [
      c(
        "final m = Moment(DateTime(2024, 3, 15, 9, 30), localization: MomentLocalizations.enUS());",
      ),
      c(""),
      l(
        "m.format(\"dddd at h:mm\")",
        () => Moment(
          DateTime(2024, 3, 15, 9, 30),
          localization: MomentLocalizations.enUS(),
        ).format("dddd at h:mm"),
      ),
      l(
        "m.format(\"dddd [at] h:mm\")",
        () => Moment(
          DateTime(2024, 3, 15, 9, 30),
          localization: MomentLocalizations.enUS(),
        ).format("dddd [at] h:mm"),
      ),
    ]),
    const P(
      "For text that should follow the reader's language, prefer the "
      "localized formats like `LLL` or `calendar()` over building your own "
      "sentence.",
    ),
    const H2("Overflowing months"),
    const P(
      "`DateTime` rolls extra days into the next month. Setting the month "
      "of January 31 to February gives a day in March. The "
      "[clamped setters](/extension/set-clamped) stop at the last day of the "
      "month instead.",
    ),
    Live(tick: false, [
      c("final endOfJanuary = DateTime(2024, 1, 31);"),
      c(""),
      l(
        "endOfJanuary.copyWith(month: 2)",
        () => DateTime(2024, 1, 31).copyWith(month: 2),
      ),
      l(
        "endOfJanuary.setClampedMonth(2)",
        () => DateTime(2024, 1, 31).setClampedMonth(2),
      ),
    ]),
    const H2("Adding a day across daylight saving"),
    const P(
      "`Duration(days: 1)` is 24 hours. On the day clocks change, adding it "
      "moves the time of day by an hour. When you mean \"the same time "
      "tomorrow\", change the calendar field instead.",
    ),
    const Code(
      "final DateTime beforeChange = DateTime(2024, 3, 9, 12);\n"
      "\n"
      "// 24 hours later; in New York this is 13:00 on March 10\n"
      "beforeChange.add(const Duration(days: 1));\n"
      "\n"
      "// noon on March 10 in every timezone\n"
      "beforeChange.copyWith(day: beforeChange.day + 1);",
    ),
    const H2("Forgetting that moments don't change"),
    const P(
      "`Moment` and `DateTime` are immutable. `add`, `subtract`, `copyWith` "
      "and the `startOf…` methods return a new value; calling them without "
      "using the result does nothing.",
    ),
    const Code(
      "Moment deadline = Moment.now();\n"
      "\n"
      "deadline.add(const Duration(days: 7)); // result is thrown away\n"
      "\n"
      "deadline = deadline.add(const Duration(days: 7));",
    ),
  ],
);
