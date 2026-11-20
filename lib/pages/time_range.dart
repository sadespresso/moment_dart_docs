import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DateTime _anchor = DateTime(2024, 3, 14);

List<Object> _now(String constructor, String type, TimeRange Function() make) =>
    [constructor, type, () => make().format()];

final DocPage timeRangePage = DocPage(
  path: "/time-range",
  title: "Time ranges",
  group: "Time ranges",
  summary:
      "A `TimeRange` is a span from `from` to `to`, both inclusive. Typed "
      "ranges such as a month or a week suit filters you can page through; "
      "`CustomTimeRange` covers any other span.",
  blocks: () => [
    const H2("Range types"),
    const P(
      "Every range has `from`, `to`, `isUtc` and `unit`. The typed ranges "
      "store their calendar fields (year, month, …) and build `from` and "
      "`to` from them.",
    ),
    TableBlock(
      ["Type", "Covers", "Create one with"],
      [
        ["YearTimeRange", "A calendar year", "`YearTimeRange(2024)`"],
        ["MonthTimeRange", "A calendar month", "`MonthTimeRange(2024, 3)`"],
        [
          "LocalWeekTimeRange",
          "A week starting on `weekStart`, or on the global localization's "
              "week start when it's null",
          "`LocalWeekTimeRange(date, DateTime.sunday)`",
        ],
        [
          "IsoWeekTimeRange",
          "An ISO week, Monday to Sunday",
          "`IsoWeekTimeRange(date)`",
        ],
        ["DayTimeRange", "A day", "`DayTimeRange(2024, 3, 13)`"],
        ["HourTimeRange", "An hour", "`HourTimeRange(2024, 3, 13, 14)`"],
        [
          "CustomTimeRange",
          "Any span between two instants",
          "`CustomTimeRange(from, to)` or `from.rangeTo(to)`",
        ],
      ],
      monoColumns: const {0},
    ),
    const P(
      "Year, month, day and hour ranges take a named `isUtc:` and have a "
      "`fromDateTime` factory that keeps the timezone of the date you pass. "
      "Week ranges take their timezone from the date. Fields out of range "
      "roll over the way `DateTime` does.",
    ),
    Live(tick: false, [
      c("final march = MonthTimeRange(2024, 3);"),
      c(""),
      l("march.from", () => MonthTimeRange(2024, 3).from),
      l("march.to", () => MonthTimeRange(2024, 3).to),
      l("march.unit", () => MonthTimeRange(2024, 3).unit),
      l("DayTimeRange(2024, 3, 32).from", () => DayTimeRange(2024, 3, 32).from),
      l(
        "DayTimeRange.fromDateTime(DateTime.utc(2024, 3, 13, 15)).isUtc",
        () => DayTimeRange.fromDateTime(DateTime.utc(2024, 3, 13, 15)).isUtc,
      ),
      l(
        "LocalWeekTimeRange(DateTime(2024, 3, 13), DateTime.sunday).from",
        () => LocalWeekTimeRange(DateTime(2024, 3, 13), DateTime.sunday).from,
      ),
      l(
        "IsoWeekTimeRange(DateTime(2024, 3, 13)).week",
        () => IsoWeekTimeRange(DateTime(2024, 3, 13)).week,
      ),
    ]),
    const H2("Ranges around now"),
    const P(
      "The `TimeRange` static constructors build common ranges from the "
      "current time, in the local timezone. The week constructors take an "
      "optional `weekStart`.",
    ),
    TableBlock(
      ["Constructor", "Returns", "format() right now"],
      [
        _now("TimeRange.thisHour()", "HourTimeRange", TimeRange.thisHour),
        _now("TimeRange.nextHour()", "HourTimeRange", TimeRange.nextHour),
        _now("TimeRange.lastHour()", "HourTimeRange", TimeRange.lastHour),
        _now("TimeRange.today()", "DayTimeRange", TimeRange.today),
        _now("TimeRange.tomorrow()", "DayTimeRange", TimeRange.tomorrow),
        _now("TimeRange.yesterday()", "DayTimeRange", TimeRange.yesterday),
        _now(
          "TimeRange.thisLocalWeek()",
          "LocalWeekTimeRange",
          TimeRange.thisLocalWeek,
        ),
        _now(
          "TimeRange.nextLocalWeek()",
          "LocalWeekTimeRange",
          TimeRange.nextLocalWeek,
        ),
        _now(
          "TimeRange.lastLocalWeek()",
          "LocalWeekTimeRange",
          TimeRange.lastLocalWeek,
        ),
        _now(
          "TimeRange.thisIsoWeek()",
          "IsoWeekTimeRange",
          TimeRange.thisIsoWeek,
        ),
        _now(
          "TimeRange.nextIsoWeek()",
          "IsoWeekTimeRange",
          TimeRange.nextIsoWeek,
        ),
        _now(
          "TimeRange.lastIsoWeek()",
          "IsoWeekTimeRange",
          TimeRange.lastIsoWeek,
        ),
        _now("TimeRange.thisMonth()", "MonthTimeRange", TimeRange.thisMonth),
        _now("TimeRange.nextMonth()", "MonthTimeRange", TimeRange.nextMonth),
        _now("TimeRange.lastMonth()", "MonthTimeRange", TimeRange.lastMonth),
        _now("TimeRange.thisYear()", "YearTimeRange", TimeRange.thisYear),
        _now("TimeRange.nextYear()", "YearTimeRange", TimeRange.nextYear),
        _now("TimeRange.lastYear()", "YearTimeRange", TimeRange.lastYear),
        _now("TimeRange.allTime()", "CustomTimeRange", TimeRange.allTime),
      ],
      monoColumns: const {0, 1},
    ),
    const P(
      "`TimeRange.fromStartAndDuration(start, duration)` makes a "
      "`CustomTimeRange` from `start` to `start + duration`.",
    ),
    const H2("Paging with next and last"),
    const P(
      "Every typed range mixes in `PageableRange`, whose `next` and `last` "
      "return the following and preceding range of the same type. They keep "
      "the timezone, and week ranges keep their `weekStart`. "
      "`CustomTimeRange` has no fixed length, so it can't page.",
    ),
    Live(tick: false, [
      l(
        "MonthTimeRange(2024, 12).next.format(useRelative: false)",
        () => MonthTimeRange(2024, 12).next.format(useRelative: false),
      ),
      l(
        "DayTimeRange(2024, 3, 1).last.format(useRelative: false)",
        () => DayTimeRange(2024, 3, 1).last.format(useRelative: false),
      ),
      l(
        "LocalWeekTimeRange(DateTime(2024, 3, 13), DateTime.sunday).next.weekStart",
        () => LocalWeekTimeRange(
          DateTime(2024, 3, 13),
          DateTime.sunday,
        ).next.weekStart,
      ),
    ]),
    const P("When all you have is a `TimeRange`, check for `PageableRange`:"),
    Live([
      c("final TimeRange range = TimeRange.thisMonth();"),
      c(""),
      l("range is PageableRange ? range.next.format() : null", () {
        final TimeRange range = TimeRange.thisMonth();
        return range is PageableRange ? range.next.format() : null;
      }),
    ]),
    const H2("Checking dates and ranges"),
    const P(
      "`contains(date)` is true when the date falls between `from` and `to`, "
      "both ends included. `containsRange(other)` is true when the other "
      "range fits entirely inside. Both compare instants, so mixing UTC and "
      "local dates is fine.",
    ),
    Live(tick: false, [
      c("final year = YearTimeRange(2024);"),
      c(""),
      l(
        "year.contains(DateTime(2024, 12, 31, 23, 59))",
        () => YearTimeRange(2024).contains(DateTime(2024, 12, 31, 23, 59)),
      ),
      l(
        "year.contains(DateTime(2025))",
        () => YearTimeRange(2024).contains(DateTime(2025)),
      ),
      l(
        "year.containsRange(MonthTimeRange(2024, 6))",
        () => YearTimeRange(2024).containsRange(MonthTimeRange(2024, 6)),
      ),
      l(
        "year.containsRange(DateTime(2024, 12, 20).rangeTo(DateTime(2025, 1, 5)))",
        () => YearTimeRange(
          2024,
        ).containsRange(DateTime(2024, 12, 20).rangeTo(DateTime(2025, 1, 5))),
      ),
    ]),
    const P(
      "`intersect(other)`, or the `&` operator, returns the overlap as a "
      "`CustomTimeRange`, or null when the ranges don't overlap. If both "
      "ranges are the same span, you get the first one back unchanged.",
    ),
    Live(tick: false, [
      c("final a = DateTime(1970).rangeTo(DateTime(2000).endOfYear());"),
      c("final b = DateTime(1975).rangeTo(DateTime(3000));"),
      c(""),
      l(
        "a.intersect(b)",
        () =>
            DateTime(1970)
                .rangeTo(DateTime(2000).endOfYear())
                .intersect(DateTime(1975).rangeTo(DateTime(3000))),
      ),
      l(
        "a & DateTime(2001).rangeTo(DateTime(2002))",
        () =>
            DateTime(1970).rangeTo(DateTime(2000).endOfYear()) &
            DateTime(2001).rangeTo(DateTime(2002)),
      ),
    ]),
    const P(
      "Two ranges are `==` when they have the same type, `from`, `to` and "
      "timezone:",
    ),
    Live(tick: false, [
      l(
        "DayTimeRange(2024, 3, 13) == DayTimeRange.fromDateTime(DateTime(2024, 3, 13, 15))",
        () =>
            DayTimeRange(2024, 3, 13) ==
            DayTimeRange.fromDateTime(DateTime(2024, 3, 13, 15)),
      ),
      l(
        "DayTimeRange(2024, 3, 13) == DayTimeRange(2024, 3, 13).toCustom()",
        () => DayTimeRange(2024, 3, 13) == DayTimeRange(2024, 3, 13).toCustom(),
      ),
    ]),
    const H2("Converting to a custom range"),
    const P(
      "`toCustom()`, or the `asCustom` getter, returns a `CustomTimeRange` "
      "with the same `from` and `to`. Use it when you want to adjust one end "
      "of a typed range. A range that is already custom is returned as is.",
    ),
    Live(tick: false, [
      l(
        "DayTimeRange(2024, 3, 13).toCustom()",
        () => DayTimeRange(2024, 3, 13).toCustom(),
      ),
      l(
        "DayTimeRange(2024, 3, 13).asCustom.to",
        () => DayTimeRange(2024, 3, 13).asCustom.to,
      ),
    ]),
    const Note(NoteKind.warning, [
      P(
        "`LocalWeekTimeRange` and `IsoWeekTimeRange` are subclasses of "
        "`CustomTimeRange`. `toCustom()` returns a week range unchanged, and "
        "`week is CustomTimeRange` is true. To get a plain custom range, "
        "write `CustomTimeRange(week.from, week.to)`.",
      ),
    ]),
    Live([
      l(
        "TimeRange.thisIsoWeek().toCustom() is IsoWeekTimeRange",
        () => TimeRange.thisIsoWeek().toCustom() is IsoWeekTimeRange,
      ),
    ]),
    const H2("Duration"),
    const P(
      "`duration` is `to.difference(from)`. Because `to` is the last "
      "microsecond of the range, it's one microsecond short of the length "
      "you might expect. Local ranges that cross a DST change are also an "
      "hour shorter or longer, which is why this example uses UTC.",
    ),
    Live(tick: false, [
      l(
        "DayTimeRange(2024, 3, 13, isUtc: true).duration",
        () => DayTimeRange(2024, 3, 13, isUtc: true).duration,
      ),
      l(
        "DayTimeRange(2024, 3, 13, isUtc: true).duration + Duration(microseconds: 1)",
        () =>
            DayTimeRange(2024, 3, 13, isUtc: true).duration +
            const Duration(microseconds: 1),
      ),
    ]),
    const H2("UTC"),
    const P(
      "`toUtc()` on a typed range keeps its fields and switches the "
      "timezone. `YearTimeRange(2024).toUtc()` is the UTC year 2024, not the "
      "local year 2024 expressed in UTC, so its `from` differs from "
      "`from.toUtc()` unless you're in UTC. `CustomTimeRange.toUtc()` "
      "converts both instants instead. The second and third lines below "
      "depend on your timezone.",
    ),
    Live(tick: false, [
      c("final local = YearTimeRange(2024);"),
      c(""),
      l("local.toUtc().from", () => YearTimeRange(2024).toUtc().from),
      l("local.from.toUtc()", () => YearTimeRange(2024).from.toUtc()),
      l(
        "local.toCustom().toUtc().from",
        () => YearTimeRange(2024).toCustom().toUtc().from,
      ),
    ]),
    const P(
      "Week ranges can't convert: `toUtc()` throws `UnsupportedError`. Build "
      "them from a UTC date instead.",
    ),
    Live([
      t(
        "TimeRange.thisLocalWeek().toUtc()",
        () => TimeRange.thisLocalWeek().toUtc(),
      ),
      l(
        "LocalWeekTimeRange(DateTime.now().toUtc()).isUtc",
        () => LocalWeekTimeRange(DateTime.now().toUtc()).isUtc,
      ),
    ]),
    const H2("Formatting"),
    const P(
      "`format()` describes a range in words, relative to `anchor` (now by "
      "default). Set `useRelative: false` for absolute dates, and pass "
      "`localization:` to override the global language.",
    ),
    Live(tick: false, [
      c("final anchor = DateTime(2024, 3, 14);"),
      c(""),
      l(
        "YearTimeRange(2024).format(anchor: anchor)",
        () => YearTimeRange(2024).format(anchor: _anchor),
      ),
      l(
        "YearTimeRange(2023).format(anchor: anchor)",
        () => YearTimeRange(2023).format(anchor: _anchor),
      ),
      l(
        "MonthTimeRange(2024, 3).format(anchor: anchor)",
        () => MonthTimeRange(2024, 3).format(anchor: _anchor),
      ),
      l(
        "MonthTimeRange(2024, 1).format(anchor: anchor)",
        () => MonthTimeRange(2024, 1).format(anchor: _anchor),
      ),
      l(
        "LocalWeekTimeRange(anchor).format(anchor: anchor)",
        () => LocalWeekTimeRange(_anchor).format(anchor: _anchor),
      ),
      l(
        "DayTimeRange(2024, 3, 13).format(anchor: anchor)",
        () => DayTimeRange(2024, 3, 13).format(anchor: _anchor),
      ),
      l(
        "DayTimeRange(2024, 3, 13).format(anchor: anchor, useRelative: false)",
        () => DayTimeRange(
          2024,
          3,
          13,
        ).format(anchor: _anchor, useRelative: false),
      ),
      l(
        "HourTimeRange(2024, 3, 14, 9).format(anchor: anchor)",
        () => HourTimeRange(2024, 3, 14, 9).format(anchor: _anchor),
      ),
      l(
        "DateTime(2024, 3, 1).rangeTo(DateTime(2024, 3, 10)).format(anchor: anchor)",
        () => DateTime(
          2024,
          3,
          1,
        ).rangeTo(DateTime(2024, 3, 10)).format(anchor: _anchor),
      ),
      l(
        "DateTime(2024, 3, 1).rangeToMax().format(anchor: anchor)",
        () => DateTime(2024, 3, 1).rangeToMax().format(anchor: _anchor),
      ),
      l("TimeRange.allTime().format()", () => TimeRange.allTime().format()),
      l(
        "YearTimeRange(2024).format(anchor: anchor, localization: MomentLocalizations.de())",
        () => YearTimeRange(2024)
            .format(anchor: _anchor, localization: MomentLocalizations.de()),
      ),
    ]),
    const H2("Encoding and parsing"),
    const P(
      "`encode()` (also what `toString()` returns) writes the type and ISO "
      "8601 dates. `encodeShort()` writes a compact form: a type letter, "
      "`from` as base-36 microseconds since the epoch, and a flags part when "
      "needed (`u` for UTC, a digit 1 to 7 for a week's `weekStart`). "
      "`TimeRange.parse` reads both and returns the original type; "
      "`TimeRange.tryParse` returns null instead of throwing.",
    ),
    Live(tick: false, [
      c(
        "final week = LocalWeekTimeRange(DateTime(2024, 3, 13), DateTime.sunday);",
      ),
      c(""),
      l(
        "week.encode()",
        () =>
            LocalWeekTimeRange(DateTime(2024, 3, 13), DateTime.sunday).encode(),
      ),
      l(
        "week.encodeShort()",
        () => LocalWeekTimeRange(
          DateTime(2024, 3, 13),
          DateTime.sunday,
        ).encodeShort(),
      ),
      l("TimeRange.parse(week.encodeShort()) == week", () {
        final week = LocalWeekTimeRange(DateTime(2024, 3, 13), DateTime.sunday);
        return TimeRange.parse(week.encodeShort()) == week;
      }),
      l(
        "YearTimeRange(2024, isUtc: true).encodeShort()",
        () => YearTimeRange(2024, isUtc: true).encodeShort(),
      ),
      l(
        "TimeRange.parse(\"Y#gs1hnx62o0#u\")",
        () => TimeRange.parse("Y#gs1hnx62o0#u"),
      ),
      l(
        "TimeRange.tryParse(\"not a range\")",
        () => TimeRange.tryParse("not a range"),
      ),
      t(
        "TimeRange.parse(\"not a range\")",
        () => TimeRange.parse("not a range"),
      ),
    ]),
    const P(
      "Since 6.0 both forms keep UTC and `weekStart`, so a parsed range "
      "equals the one you encoded. Strings written by 5.x still parse the "
      "same way.",
    ),
    const Note(NoteKind.warning, [
      P(
        "The short form of a local range stores an instant, so decoding it in "
        "another timezone can give a different day, or even a different year. "
        "That's why `week.encodeShort()` above depends on your timezone. "
        "`encode()` stores the local wall-clock time and decodes to the same "
        "calendar range everywhere. Use it, or UTC ranges, for values you "
        "share between devices. Also pass `weekStart` explicitly: a null "
        "`weekStart` means the global localization's week start at the time "
        "the range is built.",
      ),
    ]),
    const H2("rangeTo"),
    const P(
      "`DateTime.rangeTo(other)` makes a `CustomTimeRange` between two "
      "dates and swaps them if `other` comes first. `rangeToMax()` makes a "
      "range that never ends.",
    ),
    Live(tick: false, [
      l(
        "DateTime(2024, 3, 10).rangeTo(DateTime(2024, 3, 1)).from",
        () => DateTime(2024, 3, 10).rangeTo(DateTime(2024, 3, 1)).from,
      ),
      l(
        "DateTime(2024, 3, 1).rangeToMax().to == Moment.maxValue",
        () => DateTime(2024, 3, 1).rangeToMax().to == Moment.maxValue,
      ),
    ]),
    const H2("Custom ranges"),
    const P(
      "`CustomTimeRange(from, to)` throws `ArgumentError` when `to` is "
      "before `from`. In 5.x this was only an assert, so release builds "
      "accepted reversed ranges. Use `rangeTo` when you don't know the "
      "order. `from` and `to` may be equal. Both should be in the same "
      "timezone; that is only checked by an assert, and `isUtc` follows "
      "`from`.",
    ),
    Live(tick: false, [
      t(
        "CustomTimeRange(DateTime(2024, 3, 10), DateTime(2024, 3, 1))",
        () => CustomTimeRange(DateTime(2024, 3, 10), DateTime(2024, 3, 1)),
      ),
      l(
        "CustomTimeRange(DateTime(2024), DateTime(2024)).duration",
        () => CustomTimeRange(DateTime(2024), DateTime(2024)).duration,
      ),
    ]),
    const H2("Pattern matching"),
    const P(
      "Each range type is its own class, so a `switch` can pick the right UI "
      "for it, such as a date picker for a day and a month picker for a "
      "month. `TimeRange` isn't sealed, so add a default case. Put the week "
      "cases before `CustomTimeRange`, since weeks are custom ranges too.",
    ),
    const Code(
      "Future<TimeRange?> pickRange(BuildContext context, TimeRange current) {\n"
      "  return switch (current) {\n"
      "    YearTimeRange() => pickYear(context, current),\n"
      "    MonthTimeRange() => pickMonth(context, current),\n"
      "    LocalWeekTimeRange() || IsoWeekTimeRange() => pickWeek(context, current),\n"
      "    DayTimeRange() => pickDay(context, current),\n"
      "    HourTimeRange() => pickHour(context, current),\n"
      "    CustomTimeRange() => pickCustomRange(context, current),\n"
      "    _ => Future.value(null),\n"
      "  };\n"
      "}",
    ),
    const P(
      "Object patterns can read fields too, for example "
      "`MonthTimeRange(:final year, :final month)`.",
    ),
  ],
);
