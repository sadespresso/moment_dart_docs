import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DateTime _start = DateTime.utc(2024, 3, 13, 9);

const DurationFormat _dhm = DurationFormat([
  DurationUnit.day,
  DurationUnit.hour,
  DurationUnit.minute,
]);

const DurationFormat _hms = DurationFormat([
  DurationUnit.hour,
  DurationUnit.minute,
  DurationUnit.second,
]);

List<Object> _format(
  String name,
  String units,
  String auto,
  String example,
  Duration duration,
  DurationFormat format,
) => [
  name,
  units,
  auto,
  example,
  () => duration.toDurationString(format: format, dropPrefixOrSuffix: true),
];

final DocPage durationPrecisePage = DocPage(
  path: "/duration/precise",
  title: "Precise durations",
  group: "Displaying dates",
  summary:
      "`fromPrecise()`, `fromNowPrecise()` and "
      "`Duration.toDurationString()` spell out a duration in exact units, "
      "such as \"in 2 hours 1 minute\". `DurationFormat` picks which units "
      "appear.",
  blocks: () => [
    const H2("Between two moments"),
    const P(
      "`fromPrecise(anchor)` and `fromNowPrecise()` are the exact "
      "counterparts of [`from` and `fromNow`](/duration). Use them when the "
      "amount matters, for example in a countdown or a log entry.",
    ),
    Live(tick: false, [
      c("final start = DateTime.utc(2024, 3, 13, 9);"),
      c("final end = DateTime.utc(2024, 3, 13, 11, 1).toMoment();"),
      c(""),
      l(
        "end.fromPrecise(start)",
        () => DateTime.utc(2024, 3, 13, 11, 1).toMoment().fromPrecise(_start),
      ),
      l(
        "end.from(start)",
        () => DateTime.utc(2024, 3, 13, 11, 1).toMoment().from(_start),
      ),
    ]),
    Live([
      l(
        "Moment.now().subtract(Duration(minutes: 3, seconds: 12)).fromNowPrecise()",
        () => Moment.now()
            .subtract(const Duration(minutes: 3, seconds: 12))
            .fromNowPrecise(),
      ),
    ]),
    const P(
      "Since 6.0, a single unit is written with its number in precise "
      "output, while relative output keeps the word:",
    ),
    Live(tick: false, [
      c("final start = DateTime.utc(2024, 3, 13, 9);"),
      c("final end = DateTime.utc(2024, 3, 13, 10, 1).toMoment();"),
      c(""),
      l(
        "end.fromPrecise(start)",
        () => DateTime.utc(2024, 3, 13, 10, 1).toMoment().fromPrecise(_start),
      ),
      l(
        "end.from(start)",
        () => DateTime.utc(2024, 3, 13, 10, 1).toMoment().from(_start),
      ),
    ]),
    const H2("Formatting a Duration"),
    const P(
      "For a `Duration` you already have, such as a video length or a timer, "
      "call `toDurationString()` or the static `Moment.duration()`. Both take "
      "a named `localization:` and fall back to the global one. A positive "
      "duration reads as future (\"in …\") and a negative one as past, so "
      "pass `dropPrefixOrSuffix: true` for the bare amount.",
    ),
    Live(tick: false, [
      l(
        "Duration(minutes: 95).toDurationString()",
        () => const Duration(minutes: 95).toDurationString(),
      ),
      l(
        "Duration(minutes: -95).toDurationString()",
        () => const Duration(minutes: -95).toDurationString(),
      ),
      l(
        "Duration(minutes: 95).toDurationString(dropPrefixOrSuffix: true)",
        () =>
            const Duration(minutes: 95)
                .toDurationString(dropPrefixOrSuffix: true),
      ),
      l(
        "Moment.duration(Duration(minutes: 95), dropPrefixOrSuffix: true)",
        () => Moment.duration(
          const Duration(minutes: 95),
          dropPrefixOrSuffix: true,
        ),
      ),
      l(
        "Duration(minutes: 95).toDurationString(localization: MomentLocalizations.de())",
        () =>
            const Duration(minutes: 95)
                .toDurationString(localization: MomentLocalizations.de()),
      ),
    ]),
    const H2("Default formats"),
    const P(
      "By default (`DurationFormat.auto`) the first row below that fits the "
      "duration is used, which gives its two largest units. You can also pass any of these formats yourself. "
      "A month counts as 30 days and a year as 365, regardless of the "
      "calendar.",
    ),
    TableBlock(
      ["Format", "Units", "Auto picks it for", "Example", "Result"],
      [
        _format(
          "DurationFormat.ym",
          "year, month",
          "1 year or more",
          "Duration(days: 400)",
          const Duration(days: 400),
          DurationFormat.ym,
        ),
        _format(
          "DurationFormat.md",
          "month, day",
          "30 days or more",
          "Duration(days: 40)",
          const Duration(days: 40),
          DurationFormat.md,
        ),
        _format(
          "DurationFormat.wd",
          "week, day",
          "7 days or more, only with `includeWeeks: true`",
          "Duration(days: 9)",
          const Duration(days: 9),
          DurationFormat.wd,
        ),
        _format(
          "DurationFormat.dh",
          "day, hour",
          "1 day or more",
          "Duration(days: 3, hours: 4)",
          const Duration(days: 3, hours: 4),
          DurationFormat.dh,
        ),
        _format(
          "DurationFormat.hm",
          "hour, minute",
          "1 hour or more",
          "Duration(hours: 2, minutes: 5)",
          const Duration(hours: 2, minutes: 5),
          DurationFormat.hm,
        ),
        _format(
          "DurationFormat.ms",
          "minute, second",
          "1 minute or more",
          "Duration(minutes: 3, seconds: 12)",
          const Duration(minutes: 3, seconds: 12),
          DurationFormat.ms,
        ),
        _format(
          "DurationFormat.s",
          "second",
          "under 1 minute",
          "Duration(seconds: 42)",
          const Duration(seconds: 42),
          DurationFormat.s,
        ),
        _format(
          "DurationFormat.all",
          "year to second",
          "never",
          "Duration(days: 400, hours: 5, minutes: 6)",
          const Duration(days: 400, hours: 5, minutes: 6),
          DurationFormat.all,
        ),
      ],
      monoColumns: const {0, 3},
    ),
    const P(
      "The results use `dropPrefixOrSuffix: true` and your selected "
      "language.",
    ),
    const H2("Weeks"),
    const P(
      "Weeks are only used by `DurationFormat.auto` when `includeWeeks` is "
      "true. The default differs: `fromPrecise` and `fromNowPrecise` "
      "include weeks, while `toDurationString` and `Moment.duration` "
      "don't.",
    ),
    Live(tick: false, [
      c("final start = DateTime.utc(2024, 3, 13, 9);"),
      c("final end = DateTime.utc(2024, 3, 22, 9).toMoment();"),
      c(""),
      l(
        "end.fromPrecise(start)",
        () => DateTime.utc(2024, 3, 22, 9).toMoment().fromPrecise(_start),
      ),
      l(
        "end.fromPrecise(start, includeWeeks: false)",
        () => DateTime.utc(
          2024,
          3,
          22,
          9,
        ).toMoment().fromPrecise(_start, includeWeeks: false),
      ),
      l(
        "Duration(days: 9).toDurationString()",
        () => const Duration(days: 9).toDurationString(),
      ),
      l(
        "Duration(days: 9).toDurationString(includeWeeks: true)",
        () => const Duration(days: 9).toDurationString(includeWeeks: true),
      ),
    ]),
    const H2("Custom unit lists"),
    const P(
      "Build a `DurationFormat` from a list of `DurationUnit`s, largest "
      "first, to show exactly those units. This is how you get \"13 days "
      "left\" instead of \"1 week 6 days\", or hours past 24. The units are "
      "`year`, `month`, `week`, `day`, `hour`, `minute` and `second`; "
      "anything smaller than a second isn't supported.",
    ),
    Live(tick: false, [
      c("final days = DurationFormat([DurationUnit.day]);"),
      c("final hours = DurationFormat([DurationUnit.hour]);"),
      c("final dayHourMinute = DurationFormat(["),
      c("  DurationUnit.day,"),
      c("  DurationUnit.hour,"),
      c("  DurationUnit.minute,"),
      c("]);"),
      c(""),
      l(
        "Duration(days: 13).toDurationString(format: days)",
        () => const Duration(days: 13)
            .toDurationString(format: const DurationFormat([DurationUnit.day])),
      ),
      l(
        "Duration(hours: 50).toDurationString(format: hours)",
        () => const Duration(
          hours: 50,
        ).toDurationString(format: const DurationFormat([DurationUnit.hour])),
      ),
      l(
        "Duration(days: 3, hours: 4, minutes: 5).toDurationString(format: dayHourMinute)",
        () => const Duration(
          days: 3,
          hours: 4,
          minutes: 5,
        ).toDurationString(format: _dhm),
      ),
    ]),
    const H2("Dropping smaller units"),
    const P(
      "Units smaller than the last unit in the format are not shown. Their "
      "time is rounded into the last unit. Since the default format has two "
      "units, a duration with three nonzero parts loses the smallest one.",
    ),
    Live(tick: false, [
      l(
        "Duration(days: 3, hours: 4, minutes: 5).toDurationString(dropPrefixOrSuffix: true)",
        () => const Duration(
          days: 3,
          hours: 4,
          minutes: 5,
        ).toDurationString(dropPrefixOrSuffix: true),
      ),
      l(
        "Duration(days: 1, hours: 1).toDurationString(\n"
        "  format: DurationFormat([DurationUnit.day]),\n"
        "  dropPrefixOrSuffix: true,\n"
        ")",
        () => const Duration(days: 1, hours: 1).toDurationString(
          format: const DurationFormat([DurationUnit.day]),
          dropPrefixOrSuffix: true,
        ),
      ),
      l(
        "Duration(days: 1, hours: 1).toDurationString(\n"
        "  format: DurationFormat([DurationUnit.hour]),\n"
        "  dropPrefixOrSuffix: true,\n"
        ")",
        () => const Duration(days: 1, hours: 1).toDurationString(
          format: const DurationFormat([DurationUnit.hour]),
          dropPrefixOrSuffix: true,
        ),
      ),
    ]),
    const H2("Rounding"),
    const P(
      "`round` defaults to true and rounds the last unit to the nearest "
      "whole number. Set `round: false` to cut it off instead, which suits "
      "\"time elapsed\" displays that must never run ahead. The duration is "
      "rounded before it is split into units, so it carries over cleanly: "
      "59 minutes 59.6 seconds is \"1 hour\", not \"59 minutes 60 "
      "seconds\".",
    ),
    Live(tick: false, [
      c(
        "final almostAnHour = Duration(minutes: 59, seconds: 59, milliseconds: 600);",
      ),
      c(""),
      l(
        "almostAnHour.toDurationString(dropPrefixOrSuffix: true)",
        () => const Duration(
          minutes: 59,
          seconds: 59,
          milliseconds: 600,
        ).toDurationString(dropPrefixOrSuffix: true),
      ),
      l(
        "almostAnHour.toDurationString(dropPrefixOrSuffix: true, round: false)",
        () => const Duration(
          minutes: 59,
          seconds: 59,
          milliseconds: 600,
        ).toDurationString(dropPrefixOrSuffix: true, round: false),
      ),
    ]),
    const H2("Zero units"),
    const P(
      "`omitZeros` defaults to true, which leaves out units that come to "
      "zero. Set it to false for a fixed layout. When every unit is zero the "
      "result is the localization's \"a few seconds\".",
    ),
    Live(tick: false, [
      c("final dayHourMinute = DurationFormat(["),
      c("  DurationUnit.day,"),
      c("  DurationUnit.hour,"),
      c("  DurationUnit.minute,"),
      c("]);"),
      c(""),
      l(
        "Duration(days: 3, minutes: 5).toDurationString(format: dayHourMinute)",
        () =>
            const Duration(days: 3, minutes: 5).toDurationString(format: _dhm),
      ),
      l(
        "Duration(days: 3, minutes: 5).toDurationString(format: dayHourMinute, omitZeros: false)",
        () => const Duration(
          days: 3,
          minutes: 5,
        ).toDurationString(format: _dhm, omitZeros: false),
      ),
      l(
        "Duration(milliseconds: 300).toDurationString()",
        () => const Duration(milliseconds: 300).toDurationString(),
      ),
    ]),
    const H2("Delimiter"),
    const P(
      "Units are joined with the localization's separator, a space in most "
      "languages. Pass `delimiter` to use your own. Some languages join the "
      "last two units with a word such as \"и\" in Russian.",
    ),
    Live(tick: false, [
      c("final hms = DurationFormat(["),
      c("  DurationUnit.hour,"),
      c("  DurationUnit.minute,"),
      c("  DurationUnit.second,"),
      c("]);"),
      c("final time = Duration(hours: 2, minutes: 3, seconds: 4);"),
      c(""),
      l(
        "time.toDurationString(format: hms, delimiter: \", \")",
        () => const Duration(
          hours: 2,
          minutes: 3,
          seconds: 4,
        ).toDurationString(format: _hms, delimiter: ", "),
      ),
      l(
        "time.toDurationString(format: hms, localization: MomentLocalizations.ru())",
        () => const Duration(hours: 2, minutes: 3, seconds: 4).toDurationString(
          format: _hms,
          localization: MomentLocalizations.ru(),
        ),
      ),
    ]),
    const P(
      "The options combine. For abbreviated units, add `form:` (see [short "
      "forms](/duration/short-forms)):",
    ),
    Live(tick: false, [
      l(
        "Duration(days: 365).toDurationString(\n"
        "  format: DurationFormat.all,\n"
        "  omitZeros: false,\n"
        "  form: Abbreviation.semi,\n"
        "  delimiter: \", \",\n"
        ")",
        () => const Duration(days: 365).toDurationString(
          format: DurationFormat.all,
          omitZeros: false,
          form: Abbreviation.semi,
          delimiter: ", ",
        ),
      ),
    ]),
  ],
);
