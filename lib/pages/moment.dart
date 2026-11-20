import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage momentPage = DocPage(
  path: "/moment",
  title: "Creating moments",
  group: "Start here",
  summary:
      "`Moment` is an immutable `DateTime` that also carries a "
      "localization. This page covers the ways to make one, the static "
      "shortcuts for common dates, and how to derive new moments from it.",
  blocks: () => [
    const H2("Constructors"),
    const P(
      "`Moment(dateTime)` wraps a `DateTime` you already have. It keeps the "
      "same instant and the same timezone (UTC or local). `toMoment()` on a "
      "`DateTime` does the same thing.",
    ),
    Live(tick: false, [
      c("final dt = DateTime(2024, 3, 15, 9, 30);"),
      c(""),
      l("Moment(dt)", () => Moment(DateTime(2024, 3, 15, 9, 30))),
      l(
        "Moment(dt, localization: MomentLocalizations.fr())",
        () => Moment(
          DateTime(2024, 3, 15, 9, 30),
          localization: MomentLocalizations.fr(),
        ),
      ),
      l(
        "dt.toMoment(localization: MomentLocalizations.jaJp())",
        () => DateTime(
          2024,
          3,
          15,
          9,
          30,
        ).toMoment(localization: MomentLocalizations.jaJp()),
      ),
      l(
        "Moment(DateTime.utc(2024, 3, 15)).isUtc",
        () => Moment(DateTime.utc(2024, 3, 15)).isUtc,
      ),
    ]),
    const P(
      "Printing a moment calls `toString()`, which returns the `LLL` format "
      "in the moment's localization. Every constructor takes an optional "
      "`localization:`; without one, the moment uses the "
      "[global localization](/global-localization).",
    ),
    const H3("The current time"),
    const P(
      "`Moment.now()` is the current time in the local timezone. "
      "`Moment.nowWithTimezone(true)` gives the current time in UTC.",
    ),
    Live([
      l("Moment.now()", () => Moment.now()),
      l(
        "Moment.now(localization: MomentLocalizations.koKr())",
        () => Moment.now(localization: MomentLocalizations.koKr()),
      ),
      l(
        "Moment.nowWithTimezone(true).isUtc",
        () => Moment.nowWithTimezone(true).isUtc,
      ),
    ]),
    const H3("From a timestamp"),
    const P(
      "Pass `isUtc: true` to get a UTC moment. Without it the result is in "
      "your local timezone, so the second line below depends on where you "
      "are.",
    ),
    Live(tick: false, [
      l(
        "Moment.fromMillisecondsSinceEpoch(0, isUtc: true)",
        () => Moment.fromMillisecondsSinceEpoch(0, isUtc: true),
      ),
      l(
        "Moment.fromMillisecondsSinceEpoch(0)",
        () => Moment.fromMillisecondsSinceEpoch(0),
      ),
      l(
        "Moment.fromMicrosecondsSinceEpoch(1700000000000000, isUtc: true)",
        () => Moment.fromMicrosecondsSinceEpoch(1700000000000000, isUtc: true),
      ),
    ]),
    const H3("Parsing strings"),
    const P(
      "`Moment.parse` and `Moment.tryParse` accept exactly what "
      "`DateTime.parse` accepts, mostly ISO 8601. There is no parsing by "
      "format string. A string ending in `Z` or an offset gives a UTC moment; "
      "without one, the string is read as local time.",
    ),
    Live(tick: false, [
      l(
        "Moment.parse(\"2024-03-15T09:30:00Z\")",
        () => Moment.parse("2024-03-15T09:30:00Z"),
      ),
      l(
        "Moment.parse(\"2024-03-15T09:30:00Z\").isUtc",
        () => Moment.parse("2024-03-15T09:30:00Z").isUtc,
      ),
      l(
        "Moment.parse(\"2024-03-15 09:30\").isUtc",
        () => Moment.parse("2024-03-15 09:30").isUtc,
      ),
      l(
        "Moment.tryParse(\"next Friday\")",
        () => Moment.tryParse("next Friday"),
      ),
      t("Moment.parse(\"next Friday\")", () => Moment.parse("next Friday")),
    ]),
    const Note(NoteKind.warning, [
      P(
        "Because `toString()` returns a human-readable format, "
        "`Moment.parse(moment.toString())` throws. Store and send dates with "
        "`toIso8601String()` or `millisecondsSinceEpoch`. "
        "[Common mishaps](/common-mishaps) has more traps like this one.",
      ),
    ]),
    const H2("Static shortcuts"),
    const P(
      "`Moment` has static methods for the start and end of common periods "
      "around now. They return a plain `DateTime` in the local timezone, not "
      "a `Moment`, so call `toMoment()` when you want to format the result.",
    ),
    Live([
      l("Moment.startOfToday()", () => Moment.startOfToday()),
      l("Moment.endOfToday()", () => Moment.endOfToday()),
      l("Moment.startOfNextMonth()", () => Moment.startOfNextMonth()),
      l("Moment.endOfNextIsoWeek()", () => Moment.endOfNextIsoWeek()),
      l(
        "Moment.startOfThisLocalWeek(DateTime.sunday)",
        () => Moment.startOfThisLocalWeek(DateTime.sunday),
      ),
      l(
        "Moment.startOfTomorrow().toMoment().calendar()",
        () => Moment.startOfTomorrow().toMoment().calendar(),
      ),
    ]),
    const P(
      "Every name below also comes as `endOf…`, for example "
      "`endOfLastMonth()`. The local week versions take an optional "
      "`weekStart` (`DateTime.monday` through `DateTime.sunday`) and default "
      "to the global localization's week start. ISO weeks always start on "
      "Monday.",
    ),
    const TableBlock(
      ["Period", "This", "Next", "Last"],
      [
        ["Hour", "startOfThisHour()", "startOfNextHour()", "startOfLastHour()"],
        ["Day", "startOfToday()", "startOfTomorrow()", "startOfYesterday()"],
        [
          "Local week",
          "startOfThisLocalWeek()",
          "startOfNextLocalWeek()",
          "startOfLastLocalWeek()",
        ],
        [
          "ISO week",
          "startOfThisIsoWeek()",
          "startOfNextIsoWeek()",
          "startOfLastIsoWeek()",
        ],
        [
          "Month",
          "startOfThisMonth()",
          "startOfNextMonth()",
          "startOfLastMonth()",
        ],
        ["Year", "startOfThisYear()", "startOfNextYear()", "startOfLastYear()"],
      ],
      monoColumns: {1, 2, 3},
    ),
    const P(
      "To do the same from a date other than now, use the instance methods "
      "such as `date.startOfMonth()` on [startOf](/extension/startOf), "
      "[endOf](/extension/endOf) and the "
      "[relative finders](/extension/relativeFinders).",
    ),
    const H2("Constants"),
    const P(
      "`Moment.epoch`, `maxValue` and `minValue` are local `DateTime`s, and "
      "each has a UTC twin (`epochUtc`, `maxValueUtc`, `minValueUtc`) for the "
      "same instant. `maxValue` and `minValue` are the largest and smallest "
      "dates Dart can represent, and are useful as open ends of a "
      "[time range](/time-range).",
    ),
    Live(tick: false, [
      l("Moment.epochUtc", () => Moment.epochUtc),
      l("Moment.maxValueUtc", () => Moment.maxValueUtc),
      l("Moment.minValueUtc", () => Moment.minValueUtc),
      l(
        "Moment.maxValue.isAtSameMomentAs(Moment.maxValueUtc)",
        () => Moment.maxValue.isAtSameMomentAs(Moment.maxValueUtc),
      ),
      l(
        "Moment.daysInMonths[DateTime.february]",
        () => Moment.daysInMonths[DateTime.february],
      ),
      l(
        "Moment.daysInMonthsInLeapYear[DateTime.february]",
        () => Moment.daysInMonthsInLeapYear[DateTime.february],
      ),
    ]),
    const P(
      "Since 6.0 these are `final`. Assigning to them no longer compiles; "
      "keep your own variable if you need a different value.",
    ),
    const H2("Adding and subtracting"),
    const P(
      "A moment never changes. `add` and `subtract` return a new `Moment` "
      "and keep its localization. The `+` and `-` operators do the same, and "
      "also work on a plain `DateTime`.",
    ),
    Live(tick: false, [
      c("final m = Moment(DateTime(2024, 3, 15, 9, 30));"),
      c(""),
      l(
        "m.add(Duration(days: 1))",
        () => Moment(DateTime(2024, 3, 15, 9, 30)).add(const Duration(days: 1)),
      ),
      l(
        "m + Duration(hours: 2)",
        () => Moment(DateTime(2024, 3, 15, 9, 30)) + const Duration(hours: 2),
      ),
      l(
        "m - Duration(minutes: 45)",
        () =>
            Moment(DateTime(2024, 3, 15, 9, 30)) - const Duration(minutes: 45),
      ),
      l(
        "m.subtract(Duration(days: 365)).year",
        () =>
            Moment(DateTime(2024, 3, 15, 9, 30))
                .subtract(const Duration(days: 365))
                .year,
      ),
    ]),
    const Note(NoteKind.info, [
      P(
        "`Duration(days: 1)` is exactly 24 hours. Across a daylight saving "
        "change, adding it lands an hour off on the clock. To move by "
        "calendar days and keep the time of day, use "
        "`m.copyWith(day: m.day + 1)`. For the start of the next day, use "
        "`m.startOfNextDay()` from the "
        "[relative finders](/extension/relativeFinders).",
      ),
    ]),
    const H2("copyWith"),
    const P(
      "`copyWith` returns a new moment with some fields replaced. It takes "
      "the `DateTime` fields (`year` through `microsecond`, and `isUtc`), "
      "plus `dateTime` to replace the whole date and `localization` to "
      "replace the localization. When you pass both `dateTime` and fields, "
      "the fields are applied on top of `dateTime`.",
    ),
    Live(tick: false, [
      c("final m = Moment(DateTime(2024, 3, 15, 9, 30));"),
      c(""),
      l(
        "m.copyWith(year: 2020)",
        () => Moment(DateTime(2024, 3, 15, 9, 30)).copyWith(year: 2020),
      ),
      l(
        "m.copyWith(hour: 18, minute: 0)",
        () =>
            Moment(DateTime(2024, 3, 15, 9, 30)).copyWith(hour: 18, minute: 0),
      ),
      l(
        "m.copyWith(localization: MomentLocalizations.de())",
        () =>
            Moment(DateTime(2024, 3, 15, 9, 30))
                .copyWith(localization: MomentLocalizations.de()),
      ),
      l(
        "m.copyWith(dateTime: DateTime(2000, 1, 1), day: 20)",
        () =>
            Moment(DateTime(2024, 3, 15, 9, 30))
                .copyWith(dateTime: DateTime(2000, 1, 1), day: 20),
      ),
      l(
        "m.copyWith(isUtc: true).toIso8601String()",
        () =>
            Moment(DateTime(2024, 3, 15, 9, 30))
                .copyWith(isUtc: true)
                .toIso8601String(),
      ),
    ]),
    const P(
      "Like `DateTime.copyWith`, `isUtc: true` keeps the wall-clock fields "
      "and reinterprets them as UTC; it doesn't convert. Use `toUtc()` to "
      "convert. Out-of-range fields roll over, so `copyWith(month: 2)` on "
      "January 31 lands in March. The "
      "[clamped setters](/extension/set-clamped) stop at the end of the "
      "month instead.",
    ),
    const Note(NoteKind.info, [
      P(
        "Before 6.0, `Moment.copyWith` only took `dateTime` and "
        "`localization`, and hid `DateTime.copyWith`. Code that called "
        "`copyWith(dateTime: ...)` still works.",
      ),
    ]),
  ],
);
