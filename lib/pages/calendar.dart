import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage calendarPage = DocPage(
  path: "/calendar",
  title: "Calendar",
  group: "Displaying dates",
  summary:
      "`calendar()` describes a moment by its day relative to now: "
      "\"Yesterday at 6:00 PM\", \"Last Thursday\", or a plain date once it's "
      "more than six days away.",
  blocks: () => [
    const H2("Usage"),
    const P(
      "Call `calendar()` on a `Moment`. Use it for timestamps people scan, "
      "like a chat list or an activity feed, where the day matters more than "
      "the exact gap. For \"3 hours ago\" style text, see [relative "
      "durations](/duration).",
    ),
    Live([
      l("Moment.now().calendar()", () => Moment.now().calendar()),
      l(
        "Moment.now().subtract(Duration(days: 1)).calendar()",
        () => Moment.now().subtract(const Duration(days: 1)).calendar(),
      ),
      l(
        "Moment.now().add(Duration(days: 3)).calendar()",
        () => Moment.now().add(const Duration(days: 3)).calendar(),
      ),
      l(
        "Moment.now().subtract(Duration(days: 30)).calendar()",
        () => Moment.now().subtract(const Duration(days: 30)).calendar(),
      ),
    ]),
    const H2("How the day is picked"),
    const P(
      "`calendar()` counts calendar days between the moment and the "
      "reference, ignoring the time of day. 23:59 yesterday and 00:01 "
      "yesterday are both \"Yesterday\". Then:",
    ),
    const Bullets([
      "Days the localization has a word for use that word: today, "
          "yesterday and tomorrow, and in some languages the day before "
          "yesterday and the day after tomorrow.",
      "1 to 6 days back is \"last <weekday>\", and 1 to 6 days ahead is the "
          "weekday name.",
      "7 or more days away is a date in the `l` format, with the time "
          "left out.",
    ]),
    const P(
      "All examples below use Wednesday, March 13, 2024 at 9:00 as the "
      "reference, so they don't change from day to day.",
    ),
    Live(tick: false, [
      c("final ref = DateTime(2024, 3, 13, 9);"),
      c(""),
      l(
        "DateTime(2024, 3, 13, 18).toMoment().calendar(reference: ref)",
        () => DateTime(
          2024,
          3,
          13,
          18,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
      l(
        "DateTime(2024, 3, 12, 23, 30).toMoment().calendar(reference: ref)",
        () => DateTime(
          2024,
          3,
          12,
          23,
          30,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
      l(
        "DateTime(2024, 3, 7, 0, 5).toMoment().calendar(reference: ref)",
        () => DateTime(
          2024,
          3,
          7,
          0,
          5,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
      l(
        "DateTime(2024, 3, 6, 23, 59).toMoment().calendar(reference: ref)",
        () => DateTime(
          2024,
          3,
          6,
          23,
          59,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
      l(
        "DateTime(2024, 3, 19, 23, 59).toMoment().calendar(reference: ref)",
        () => DateTime(
          2024,
          3,
          19,
          23,
          59,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
      l(
        "DateTime(2024, 3, 20, 0, 1).toMoment().calendar(reference: ref)",
        () => DateTime(
          2024,
          3,
          20,
          0,
          1,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
    ]),
    const Note(NoteKind.info, [
      P(
        "Since 6.0 the weekday window is counted in calendar days, like "
        "moment.js. March 7 at 00:05 is six days before the reference, so "
        "it's \"last Thursday\" even though more than six times 24 hours "
        "have passed. March 6 at 23:59 is seven days back and gets a date. "
        "The day count also stays right across a DST change.",
      ),
    ]),
    const P("German, for example, has words for two days back and ahead:"),
    Live(tick: false, [
      l(
        "Moment(DateTime(2024, 3, 11, 8), localization: MomentLocalizations.de())\n"
        "    .calendar(reference: DateTime(2024, 3, 13, 9))",
        () => Moment(
          DateTime(2024, 3, 11, 8),
          localization: MomentLocalizations.de(),
        ).calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
      l(
        "Moment(DateTime(2024, 3, 15, 8), localization: MomentLocalizations.de())\n"
        "    .calendar(reference: DateTime(2024, 3, 13, 9))",
        () => Moment(
          DateTime(2024, 3, 15, 8),
          localization: MomentLocalizations.de(),
        ).calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
    ]),
    const H2("Changing the reference"),
    const P(
      "`reference` defaults to now. Pass another date to describe a moment "
      "from a different day's point of view, for example the date a report "
      "was generated. The same moment that is \"Today\" from one reference is "
      "\"Yesterday\" from the next day.",
    ),
    Live(tick: false, [
      c("final meeting = DateTime(2024, 3, 13, 15).toMoment();"),
      c(""),
      l(
        "meeting.calendar(reference: DateTime(2024, 3, 13))",
        () => DateTime(
          2024,
          3,
          13,
          15,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13)),
      ),
      l(
        "meeting.calendar(reference: DateTime(2024, 3, 14))",
        () => DateTime(
          2024,
          3,
          13,
          15,
        ).toMoment().calendar(reference: DateTime(2024, 3, 14)),
      ),
      l(
        "meeting.calendar(reference: DateTime(2024, 3, 12))",
        () => DateTime(
          2024,
          3,
          13,
          15,
        ).toMoment().calendar(reference: DateTime(2024, 3, 12)),
      ),
    ]),
    const P(
      "Days are counted in the moment's own timezone; the reference is "
      "converted to it first. A UTC moment is compared by UTC days, which "
      "may not match the reader's day. Call `toLocal()` on dates from an "
      "API before you call `calendar()`.",
    ),
    const H2("Omitting hours"),
    const P(
      "Set `omitHours: true` to drop the time, for example in a list grouped "
      "by day. Dates seven or more days away never show the time.",
    ),
    Live(tick: false, [
      c("final ref = DateTime(2024, 3, 13, 9);"),
      c("final yesterday = DateTime(2024, 3, 12, 18).toMoment();"),
      c(""),
      l(
        "yesterday.calendar(reference: ref)",
        () => DateTime(
          2024,
          3,
          12,
          18,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
      l(
        "yesterday.calendar(reference: ref, omitHours: true)",
        () => DateTime(2024, 3, 12, 18).toMoment().calendar(
          reference: DateTime(2024, 3, 13, 9),
          omitHours: true,
        ),
      ),
    ]),
    const H2("Beyond a week"),
    const P(
      "Past the six-day window, `calendar()` prints the date with the "
      "localization's `l` format. Pass `customFormat` to use another "
      "[format string](/formatting) there. With `customFormat` set, the "
      "result never includes the time, even for today or yesterday.",
    ),
    Live(tick: false, [
      c("final ref = DateTime(2024, 3, 13, 9);"),
      c(""),
      l(
        "DateTime(2024, 2, 1, 14).toMoment().calendar(reference: ref)",
        () => DateTime(
          2024,
          2,
          1,
          14,
        ).toMoment().calendar(reference: DateTime(2024, 3, 13, 9)),
      ),
      l(
        "DateTime(2024, 2, 1, 14).toMoment()\n"
        "    .calendar(reference: ref, customFormat: \"LL\")",
        () => DateTime(2024, 2, 1, 14).toMoment().calendar(
          reference: DateTime(2024, 3, 13, 9),
          customFormat: "LL",
        ),
      ),
      l(
        "DateTime(2024, 3, 12, 18).toMoment()\n"
        "    .calendar(reference: ref, customFormat: \"LL\")",
        () => DateTime(2024, 3, 12, 18).toMoment().calendar(
          reference: DateTime(2024, 3, 13, 9),
          customFormat: "LL",
        ),
      ),
    ]),
  ],
);
