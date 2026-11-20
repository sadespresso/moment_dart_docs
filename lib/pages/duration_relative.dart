import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DateTime _anchor = DateTime.utc(2024);

String Function() _rel(Duration d) =>
    () => Moment(_anchor.add(d)).from(_anchor, dropPrefixOrSuffix: true);

List<Object> _row(String shows, String until, Duration before, Duration at) => [
  shows,
  until,
  _rel(before),
  _rel(at),
];

final DocPage durationRelativePage = DocPage(
  path: "/duration",
  title: "Relative durations",
  group: "Displaying dates",
  summary:
      "`fromNow()` and `from()` describe the gap between two moments in "
      "rounded words, such as \"3 hours ago\" or \"in a few seconds\", using "
      "the same thresholds as moment.js.",
  blocks: () => [
    const H2("From now"),
    const P(
      "`fromNow()` compares a moment with the current time. Past moments get "
      "\"ago\", future ones get \"in\", each in the moment's language.",
    ),
    Live([
      l(
        "Moment.now().subtract(Duration(seconds: 20)).fromNow()",
        () => Moment.now().subtract(const Duration(seconds: 20)).fromNow(),
      ),
      l(
        "Moment.now().subtract(Duration(hours: 3)).fromNow()",
        () => Moment.now().subtract(const Duration(hours: 3)).fromNow(),
      ),
      l(
        "Moment.now().add(Duration(days: 40)).fromNow()",
        () => Moment.now().add(const Duration(days: 40)).fromNow(),
      ),
    ]),
    const Note(NoteKind.warning, [
      P(
        "Relative text is rounded on purpose: 40 days is \"a month\". For "
        "countdowns, timers or anything where the exact amount matters, use "
        "[precise durations](/duration/precise).",
      ),
    ]),
    const H2("From another date"),
    const P(
      "`from(anchor)` measures from any date instead of now. The moment is "
      "\"in …\" when it's after the anchor and \"… ago\" when it's before.",
    ),
    Live(tick: false, [
      c("final launch = DateTime(2024, 3, 13, 9);"),
      c(""),
      l(
        "DateTime(2024, 3, 13, 12).toMoment().from(launch)",
        () =>
            DateTime(2024, 3, 13, 12).toMoment().from(DateTime(2024, 3, 13, 9)),
      ),
      l(
        "DateTime(2024, 2, 20).toMoment().from(launch)",
        () => DateTime(2024, 2, 20).toMoment().from(DateTime(2024, 3, 13, 9)),
      ),
    ]),
    const H2("Without \"ago\" or \"in\""),
    const P(
      "Set `dropPrefixOrSuffix: true` to get only the amount. Use it when "
      "your own text supplies the direction, or when you need the size of a "
      "gap with no direction at all.",
    ),
    Live([
      l(
        "Moment.now().subtract(Duration(minutes: 5)).fromNow(dropPrefixOrSuffix: true)",
        () => Moment.now()
            .subtract(const Duration(minutes: 5))
            .fromNow(dropPrefixOrSuffix: true),
      ),
      l(
        "Moment.now().add(Duration(minutes: 5)).fromNow(dropPrefixOrSuffix: true)",
        () => Moment.now()
            .add(const Duration(minutes: 5))
            .fromNow(dropPrefixOrSuffix: true),
      ),
    ]),
    const P(
      "Both methods also take `form:` for abbreviated output such as "
      "\"3h ago\". See [short forms](/duration/short-forms).",
    ),
    const H2("Thresholds"),
    const P(
      "The wording steps up through the table below. Each step rounds the "
      "duration to its own unit and checks that number, which is also the "
      "number that gets printed. That's why the switches fall on halves: 44 "
      "minutes 30 seconds rounds to 45 minutes, which is past the \"minutes\" "
      "step, so it reads \"an hour\". Here a month is 30 days and a year is "
      "365 days.",
    ),
    const P(
      "The last two columns are computed live in your language. \"Just "
      "before\" is one second before the switch (one millisecond in the "
      "first row).",
    ),
    TableBlock(
      ["Shows", "Until", "Just before", "At the switch"],
      [
        _row(
          "a few seconds",
          "44.5 seconds",
          const Duration(seconds: 44, milliseconds: 499),
          const Duration(seconds: 44, milliseconds: 500),
        ),
        _row(
          "a minute",
          "90 seconds",
          const Duration(seconds: 89),
          const Duration(seconds: 90),
        ),
        _row(
          "`n` minutes (2 to 44)",
          "44 minutes 30 seconds",
          const Duration(minutes: 44, seconds: 29),
          const Duration(minutes: 44, seconds: 30),
        ),
        _row(
          "an hour",
          "90 minutes",
          const Duration(minutes: 89, seconds: 59),
          const Duration(minutes: 90),
        ),
        _row(
          "`n` hours (2 to 21)",
          "21 hours 30 minutes",
          const Duration(hours: 21, minutes: 29, seconds: 59),
          const Duration(hours: 21, minutes: 30),
        ),
        _row(
          "a day",
          "36 hours",
          const Duration(hours: 35, minutes: 59, seconds: 59),
          const Duration(hours: 36),
        ),
        _row(
          "`n` days (2 to 25)",
          "25 days 12 hours",
          const Duration(days: 25, hours: 11, minutes: 59, seconds: 59),
          const Duration(days: 25, hours: 12),
        ),
        _row(
          "a month",
          "45 days",
          const Duration(days: 44, hours: 23, minutes: 59, seconds: 59),
          const Duration(days: 45),
        ),
        _row(
          "`n` months (2 to 10)",
          "315 days",
          const Duration(days: 314, hours: 23, minutes: 59, seconds: 59),
          const Duration(days: 315),
        ),
        _row(
          "a year",
          "548 days",
          const Duration(days: 547, hours: 23, minutes: 59, seconds: 59),
          const Duration(days: 548),
        ),
        ["`n` years (2 and up)", "—", "—", "—"],
      ],
    ),
    const P(
      "Relative text never says \"`n` seconds\" or uses weeks. Precise "
      "durations do both.",
    ),
    const Note(NoteKind.info, [
      P(
        "6.0 changed how the thresholds are checked. 5.x compared the exact "
        "duration with fixed limits, so 44 minutes 30 seconds read as \"45 "
        "minutes\" and \"a year\" started at 320 days. 6.0 rounds first, as "
        "moment.js does.",
      ),
    ]),
    const P("Check any boundary yourself:"),
    Live(tick: false, [
      c("final anchor = DateTime.utc(2024);"),
      c(""),
      l(
        "anchor.subtract(Duration(minutes: 44, seconds: 29)).toMoment().from(anchor)",
        () =>
            DateTime.utc(2024)
                .subtract(const Duration(minutes: 44, seconds: 29))
                .toMoment()
                .from(DateTime.utc(2024)),
      ),
      l(
        "anchor.subtract(Duration(minutes: 44, seconds: 30)).toMoment().from(anchor)",
        () =>
            DateTime.utc(2024)
                .subtract(const Duration(minutes: 44, seconds: 30))
                .toMoment()
                .from(DateTime.utc(2024)),
      ),
    ]),
  ],
);
