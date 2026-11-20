import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DateTime _anchor = DateTime.utc(2024);

List<Object> _relativeRow(String label, Duration d) => [
  label,
  for (final Abbreviation form in Abbreviation.values)
    () => Moment(_anchor.subtract(d)).from(_anchor, form: form),
];

List<Object> _preciseRow(String label, Duration d) => [
  label,
  for (final Abbreviation form in Abbreviation.values)
    () => d.toDurationString(form: form, dropPrefixOrSuffix: true),
];

final DocPage durationShortFormsPage = DocPage(
  path: "/duration/short-forms",
  title: "Short forms",
  group: "Displaying dates",
  summary:
      "Pass `form:` to any relative or precise duration method for "
      "shorter unit names, such as \"37 min ago\" or \"2h 1m\".",
  blocks: () => [
    const H2("The three forms"),
    const P(
      "`Abbreviation` has three values. Every method on the [relative]"
      "(/duration) and [precise](/duration/precise) pages takes one as "
      "`form:`, so short output works the same way everywhere.",
    ),
    TableBlock(
      ["Value", "Use it for", "2 hours 1 minute"],
      [
        [
          "Abbreviation.none",
          "Full words, the default. Body text and screen readers.",
          () => const Duration(
            hours: 2,
            minutes: 1,
          ).toDurationString(dropPrefixOrSuffix: true),
        ],
        [
          "Abbreviation.semi",
          "Shortened words. Lists and table cells.",
          () => const Duration(
            hours: 2,
            minutes: 1,
          ).toDurationString(form: Abbreviation.semi, dropPrefixOrSuffix: true),
        ],
        [
          "Abbreviation.full",
          "The shortest form, usually one letter. Badges and tight layouts.",
          () => const Duration(
            hours: 2,
            minutes: 1,
          ).toDurationString(form: Abbreviation.full, dropPrefixOrSuffix: true),
        ],
      ],
      monoColumns: const {0},
    ),
    const Note(NoteKind.info, [
      P(
        "`Abbreviation.full` means fully abbreviated, not full words. Full "
        "words are `Abbreviation.none`.",
      ),
    ]),
    const H2("Relative durations"),
    Live([
      l(
        "Moment.now().subtract(Duration(minutes: 37)).fromNow(form: Abbreviation.semi)",
        () => Moment.now()
            .subtract(const Duration(minutes: 37))
            .fromNow(form: Abbreviation.semi),
      ),
      l(
        "Moment.now().subtract(Duration(minutes: 37)).fromNow(form: Abbreviation.full)",
        () => Moment.now()
            .subtract(const Duration(minutes: 37))
            .fromNow(form: Abbreviation.full),
      ),
      l(
        "Moment.now().add(Duration(minutes: 50)).fromNow(form: Abbreviation.full)",
        () => Moment.now()
            .add(const Duration(minutes: 50))
            .fromNow(form: Abbreviation.full),
      ),
    ]),
    const P(
      "The thresholds don't change with the form. Words like \"an hour\" "
      "become a number in the short forms, as in the last line.",
    ),
    const H2("Precise durations"),
    Live([
      l(
        "Moment.now().subtract(Duration(hours: 5, minutes: 12)).fromNowPrecise(form: Abbreviation.full)",
        () => Moment.now()
            .subtract(const Duration(hours: 5, minutes: 12))
            .fromNowPrecise(form: Abbreviation.full),
      ),
    ]),
    Live(tick: false, [
      l(
        "Duration(days: 3, hours: 4).toDurationString(form: Abbreviation.semi)",
        () => const Duration(
          days: 3,
          hours: 4,
        ).toDurationString(form: Abbreviation.semi),
      ),
      l(
        "Moment.duration(Duration(minutes: 90), form: Abbreviation.full, dropPrefixOrSuffix: true)",
        () => Moment.duration(
          const Duration(minutes: 90),
          form: Abbreviation.full,
          dropPrefixOrSuffix: true,
        ),
      ),
    ]),
    const H2("Side by side"),
    const P(
      "Each cell is computed live in the language you picked in the header. "
      "Relative output, for a moment that long ago:",
    ),
    TableBlock(
      ["Ago", "none", "semi", "full"],
      [
        _relativeRow("20 seconds", const Duration(seconds: 20)),
        _relativeRow("1 minute", const Duration(minutes: 1)),
        _relativeRow("37 minutes", const Duration(minutes: 37)),
        _relativeRow("1 hour", const Duration(hours: 1)),
        _relativeRow("5 hours", const Duration(hours: 5)),
        _relativeRow("1 day", const Duration(days: 1)),
        _relativeRow("9 days", const Duration(days: 9)),
        _relativeRow("1 month", const Duration(days: 30)),
        _relativeRow("4 months", const Duration(days: 120)),
        _relativeRow("1 year", const Duration(days: 365)),
        _relativeRow("3 years", const Duration(days: 3 * 365)),
      ],
    ),
    const P(
      "Precise output from `toDurationString(form: …, "
      "dropPrefixOrSuffix: true)`:",
    ),
    TableBlock(
      ["Duration", "none", "semi", "full"],
      [
        _preciseRow("42 seconds", const Duration(seconds: 42)),
        _preciseRow(
          "3 minutes 12 seconds",
          const Duration(minutes: 3, seconds: 12),
        ),
        _preciseRow("1 hour 1 minute", const Duration(hours: 1, minutes: 1)),
        _preciseRow("2 days 5 hours", const Duration(days: 2, hours: 5)),
        _preciseRow("1 month 10 days", const Duration(days: 40)),
        _preciseRow("1 year 2 months", const Duration(days: 425)),
      ],
    ),
    const Note(NoteKind.tip, [
      P(
        "Some languages have no shorter words for some units and print the "
        "same text in every form. If the short forms for your language could "
        "be better, see the [contribution guide]"
        "(https://github.com/sadespresso/moment_dart/blob/master/CONTRIBUTE.md).",
      ),
    ]),
  ],
);
