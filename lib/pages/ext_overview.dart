import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final DocPage extOverviewPage = DocPage(
  path: "/extension",
  title: "Overview",
  group: "DateTime extensions",
  summary:
      "moment_dart adds methods to every `DateTime`: start and end of a "
      "unit, next Monday, same-day checks, ISO weeks and more. They work on "
      "`Moment` too, and keep the timezone you call them on.",
  blocks: () => [
    const H2("What they are"),
    const P(
      "The helpers on these pages are Dart "
      "[extension methods](https://dart.dev/language/extension-methods) on "
      "`DateTime`. Importing `package:moment_dart/moment_dart.dart` brings "
      "them into scope, so you call them on any `DateTime` without wrapping "
      "it first.",
    ),
    const P(
      "`Moment` extends `DateTime`, so every extension works on a `Moment` "
      "as well.",
    ),
    Live(tick: false, [
      c("final release = DateTime(2024, 3, 14, 15, 9, 26);"),
      c(""),
      l(
        "release.startOfMonth()",
        () => DateTime(2024, 3, 14, 15, 9, 26).startOfMonth(),
      ),
      l(
        "release.nextMonday()",
        () => DateTime(2024, 3, 14, 15, 9, 26).nextMonday(),
      ),
      l("release.quarter", () => DateTime(2024, 3, 14, 15, 9, 26).quarter),
      l(
        "release.isAtSameMonthAs(DateTime(2024, 3, 1))",
        () => DateTime(
          2024,
          3,
          14,
          15,
          9,
          26,
        ).isAtSameMonthAs(DateTime(2024, 3, 1)),
      ),
    ]),
    const H2("The timezone stays the same"),
    const P(
      "A `DateTime` is either local or UTC. Methods that return a new date "
      "return it in the same timezone as the one you called them on: the "
      "start of a UTC day is UTC midnight, not local midnight.",
    ),
    Live(tick: false, [
      c("final utc = DateTime.utc(2024, 3, 14, 15, 9);"),
      c(""),
      l(
        "utc.startOfDay()",
        () => DateTime.utc(2024, 3, 14, 15, 9).startOfDay(),
      ),
      l(
        "utc.startOfDay().isUtc",
        () => DateTime.utc(2024, 3, 14, 15, 9).startOfDay().isUtc,
      ),
      l(
        "utc.toLocal().startOfDay()",
        () => DateTime.utc(2024, 3, 14, 15, 9).toLocal().startOfDay(),
      ),
    ]),
    const P(
      "The last line converts to your timezone first, so its result depends "
      "on where you're reading this. Convert before you call a helper when "
      "you mean \"the day as the user sees it\".",
    ),
    const H2("Moments stay moments"),
    const P(
      "Most helpers that return a date have a second version declared on "
      "`Moment`. Called on a `Moment`, they return a `Moment` with the same "
      "localization: `clone()`, `date`, the `startOf…`/`endOf…` methods, the "
      "next and last finders, the weekday finders and the clamped setters. "
      "Operators `+` and `-` return a `Moment` too.",
    ),
    Live(tick: false, [
      c("final moment = DateTime(2024, 3, 14).toMoment();"),
      c(""),
      l(
        "moment.endOfMonth() is Moment",
        () =>
            (DateTime(2024, 3, 14).toMoment().endOfMonth() as Object) is Moment,
      ),
      l(
        "(moment + Duration(days: 1)) is Moment",
        () =>
            ((DateTime(2024, 3, 14).toMoment() + const Duration(days: 1))
                    as Object)
                is Moment,
      ),
      l(
        "moment.endOfMonth()",
        () => DateTime(2024, 3, 14).toMoment().endOfMonth(),
      ),
    ]),
    const P(
      "A `Moment` prints itself with the localized `LLL` format, so the last "
      "line follows the language picked in the header.",
    ),
    const Note(NoteKind.warning, [
      P(
        "Dart picks an extension by the **static** type. A `Moment` stored in "
        "a `DateTime` variable gets the `DateTime` versions, which return a "
        "plain `DateTime`. The same applies to `startOf(DurationUnit.week)`, "
        "which only `Moment` supports.",
      ),
    ]),
    Live(tick: false, [
      c("final DateTime stored = DateTime(2024, 3, 14).toMoment();"),
      c(""),
      l("stored is Moment", () {
        final DateTime stored = DateTime(2024, 3, 14).toMoment();
        return stored is Moment;
      }),
      l("stored.endOfMonth() is Moment", () {
        final DateTime stored = DateTime(2024, 3, 14).toMoment();
        return stored.endOfMonth() is Moment;
      }),
    ]),
    const H2("Where next"),
    const Bullets([
      "[Getters and operators](/extension/generic): `isLeapYear`, "
          "`quarter`, ISO `week`, `differenceInDays`, `clone()`, `format()`, "
          "and `<`, `>`, `+`, `-` on dates.",
      "[Start of a unit](/extension/startOf): `startOfDay()`, "
          "`startOfLocalWeek()`, `startOf(DurationUnit.month)` and the rest.",
      "[End of a unit](/extension/endOf): the last microsecond of a day, "
          "week, month or year.",
      "[Next and last units](/extension/relativeFinders): "
          "`startOfNextMonth()`, `endOfLastLocalWeek()` and the other "
          "neighbors.",
      "[Finding weekdays](/extension/findWeekday): `nextMonday()`, "
          "`lastFriday()`, `nextWeekday(n)`.",
      "[Comparing units](/extension/isAtSame): `isAtSameDayAs()` and "
          "friends, which changed in 6.0.",
      "[Clamped setters](/extension/set-clamped): set a day or month "
          "without spilling into the next one.",
    ]),
  ],
);
