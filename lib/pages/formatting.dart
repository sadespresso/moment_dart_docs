import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

List<Object> _token(String unit, String token, String values) => [
  unit,
  token,
  values,
  () => Moment.now().format(token),
];

final DocPage formattingPage = DocPage(
  path: "/formatting",
  title: "Formatting",
  group: "Displaying dates",
  summary:
      "`format()` turns a moment into text from a pattern of tokens such "
      "as `YYYY` and `MMMM`. Locale-aware formats like `LL` and `LT` follow "
      "the active localization.",
  blocks: () => [
    const H2("Format strings"),
    const P(
      "Pass a pattern to `format`. Each token in it is replaced with part of "
      "the date, and everything else is copied through. Tokens are "
      "case-sensitive: `MM` is the month, `mm` the minute. Without a pattern "
      "you get `l`, the localization's short date.",
    ),
    Live([
      l(
        "Moment.now().format(\"YYYY-MM-DD HH:mm:ss\")",
        () => Moment.now().format("YYYY-MM-DD HH:mm:ss"),
      ),
      l(
        "Moment.now().format(\"dddd, MMMM Do\")",
        () => Moment.now().format("dddd, MMMM Do"),
      ),
      l("Moment.now().format()", () => Moment.now().format()),
    ]),
    const P(
      "A plain `DateTime` has `format` too. It takes named arguments, so you "
      "can also pick a localization for one call:",
    ),
    Live([
      l(
        "DateTime.now().format(payload: \"MMM D, h:mm A\")",
        () => DateTime.now().format(payload: "MMM D, h:mm A"),
      ),
      l(
        "DateTime.now().format(payload: \"LLLL\", localization: MomentLocalizations.fr())",
        () => DateTime.now().format(
          payload: "LLLL",
          localization: MomentLocalizations.fr(),
        ),
      ),
    ]),
    const H2("Escaping text"),
    const P(
      "Wrap text in square brackets to print it as written. The formatter "
      "finds tokens anywhere, even inside words, so any Latin word in a "
      "pattern usually needs brackets: \"at\" holds `a` (am/pm), and \"day\" "
      "holds `d`, `a` and `y`.",
    ),
    Live(tick: false, [
      c("final date = DateTime(2024, 3, 5, 14, 7).toMoment();"),
      c(""),
      l(
        "date.format(\"[Today is] dddd\")",
        () => DateTime(2024, 3, 5, 14, 7).toMoment().format("[Today is] dddd"),
      ),
      l(
        "date.format(\"Today is dddd\")",
        () => DateTime(2024, 3, 5, 14, 7).toMoment().format("Today is dddd"),
      ),
      l(
        "date.format(\"YYYY [YYYY] Do [Do] LT [A]\")",
        () => DateTime(
          2024,
          3,
          5,
          14,
          7,
        ).toMoment().format("YYYY [YYYY] Do [Do] LT [A]"),
      ),
    ]),
    const P(
      "A bracketed part ends at the first `]`, so brackets don't nest, and "
      "empty brackets `[]` print as they are.",
    ),
    const H2("Text that isn't a token"),
    const P(
      "Characters that aren't part of any token pass through unchanged. "
      "Digits, punctuation and most non-Latin scripts need no brackets, "
      "which makes patterns for languages like Korean or Japanese easy to "
      "read:",
    ),
    Live(tick: false, [
      l(
        "Moment(DateTime(2024, 3, 5, 14, 7), localization: MomentLocalizations.koKr())\n"
        "    .format(\"YYYY년 MMM D일 ddd A h:mm\")",
        () => Moment(
          DateTime(2024, 3, 5, 14, 7),
          localization: MomentLocalizations.koKr(),
        ).format("YYYY년 MMM D일 ddd A h:mm"),
      ),
    ]),
    const H2("Locale-aware formats"),
    const P(
      "These tokens come from the localization, so the order of parts, the "
      "separators and the 12- or 24-hour clock change with the language. "
      "Use them when you show dates to people instead of writing your own "
      "pattern. Lowercase versions are the shorter forms. Most have a getter "
      "and a method on `Moment`; the method takes an optional `forceLocal` "
      "flag (see below).",
    ),
    TableBlock(
      ["Token", "Getter", "Method", "Now"],
      [
        ["L", "—", "—", () => Moment.now().format("L")],
        ["l", "—", "—", () => Moment.now().format("l")],
        ["LL", ".LL", "formatDate()", () => Moment.now().LL],
        ["ll", ".ll", "formatDateShort()", () => Moment.now().ll],
        ["LLL", ".LLL", "formatDateTime()", () => Moment.now().LLL],
        ["lll", ".lll", "formatDateTimeShort()", () => Moment.now().lll],
        [
          "LLLL",
          ".LLLL",
          "formatDateTimeWithWeekday()",
          () => Moment.now().LLLL,
        ],
        [
          "llll",
          ".llll",
          "formatDateTimeWithWeekdayShort()",
          () => Moment.now().llll,
        ],
        ["LT", ".LT", "formatTime()", () => Moment.now().LT],
        ["LTS", ".LTS", "formatTimeWithSeconds()", () => Moment.now().LTS],
      ],
      monoColumns: const {0, 1, 2},
    ),
    const P(
      "`L` and `l` have no getter; use `format(\"L\")`. A moment's "
      "`toString()` returns `LLL`. Compare a few languages:",
    ),
    Live([
      l(
        "Moment.now(localization: MomentLocalizations.de()).LLL",
        () => Moment.now(localization: MomentLocalizations.de()).LLL,
      ),
      l(
        "Moment.now(localization: MomentLocalizations.jaJp()).LLL",
        () => Moment.now(localization: MomentLocalizations.jaJp()).LLL,
      ),
      l(
        "Moment.now(localization: MomentLocalizations.ru()).LLLL",
        () => Moment.now(localization: MomentLocalizations.ru()).LLLL,
      ),
    ]),
    const H2("Timezones and forceLocal"),
    const P(
      "`format` prints a moment in its own timezone, so a UTC moment prints "
      "UTC wall-clock time. Dates parsed from ISO 8601 strings or received "
      "from an API are often UTC. Set `forceLocal` to convert to local time "
      "before formatting. It's positional on `Moment.format` and the "
      "`format…()` methods, and named on `DateTime.format`.",
    ),
    const P(
      "The results below depend on your timezone. The first line is the same "
      "everywhere; the rest show 12:00 UTC in your local time.",
    ),
    Live(tick: false, [
      c("final utc = Moment(DateTime.utc(2024, 3, 5, 12));"),
      c(""),
      l("utc.LT", () => Moment(DateTime.utc(2024, 3, 5, 12)).LT),
      l(
        "utc.format(\"LT\", true)",
        () => Moment(DateTime.utc(2024, 3, 5, 12)).format("LT", true),
      ),
      l(
        "utc.formatTime(true)",
        () => Moment(DateTime.utc(2024, 3, 5, 12)).formatTime(true),
      ),
      l(
        "utc.toLocal().LT",
        () => Moment(DateTime.utc(2024, 3, 5, 12)).toLocal().LT,
      ),
      l(
        "DateTime.utc(2024, 3, 5, 12).format(payload: \"LT\", forceLocal: true)",
        () => DateTime.utc(
          2024,
          3,
          5,
          12,
        ).format(payload: "LT", forceLocal: true),
      ),
    ]),
    const P(
      "The getters (`LL`, `LT`, ...) have no `forceLocal` flag. Call "
      "`toLocal()` first, as in the fourth line.",
    ),
    const H2("Formatter tokens"),
    const P(
      "Every token `format` understands. When two tokens start at the same "
      "place the longer one wins, so `MMMM` is the month name rather than "
      "four month numbers. Values are English examples; the last column "
      "formats the current moment in the language you picked in the "
      "header.",
    ),
    TableBlock(
      ["Unit", "Token", "Values", "Now"],
      [
        _token("Month", "M", "1 2 … 11 12"),
        _token("", "Mo", "1st 2nd … 11th 12th"),
        _token("", "MM", "01 02 … 11 12"),
        _token("", "MMM", "Jan Feb … Nov Dec"),
        _token("", "MMMM", "January February … November December"),
        _token("Quarter", "Q", "1 2 3 4"),
        _token("", "Qo", "1st 2nd 3rd 4th"),
        _token("Day of month", "D", "1 2 … 30 31"),
        _token("", "Do", "1st 2nd … 30th 31st"),
        _token("", "DD", "01 02 … 30 31"),
        _token("Day of year", "DDD", "1 2 … 365 366"),
        _token("", "DDDo", "1st 2nd … 365th 366th"),
        _token("", "DDDD", "001 002 … 365 366"),
        _token("Day of week", "d", "1 2 … 6 7 (Monday is 1)"),
        _token("", "d_o", "1st 2nd … 6th 7th"),
        _token("", "dd", "Mo Tu … Sa Su"),
        _token("", "ddd", "Mon Tue … Sat Sun"),
        _token("", "dddd", "Monday Tuesday … Sunday"),
        _token("Day of week (ISO)", "e", "1 2 … 6 7"),
        _token("Week of year (ISO)", "w", "1 2 … 52 53"),
        _token("", "wo", "1st 2nd … 52nd 53rd"),
        _token("", "ww", "01 02 … 52 53"),
        _token("Year", "YY", "70 71 … 29 30, other years in full"),
        _token("", "YYYY", "Full year: 1999 2024"),
        _token("Era year", "y", "1 2 … 2024 (counts up in both eras)"),
        _token("Era", "NN", "B.C. A.D."),
        _token("", "NNNN", "Before Christ, Anno Domini"),
        _token("", "NNNNN", "BC AD"),
        _token("Week year (ISO)", "gg", "70 71 … 29 30, other years in full"),
        _token("", "gggg", "Full week year: 1999 2024"),
        _token("AM/PM", "A", "AM PM"),
        _token("", "a", "am pm"),
        _token("Hour", "H", "0 1 … 22 23"),
        _token("", "HH", "00 01 … 22 23"),
        _token("", "h", "1 2 … 11 12"),
        _token("", "hh", "01 02 … 11 12"),
        _token("", "k", "1 2 … 23 24 (midnight is 24)"),
        _token("", "kk", "01 02 … 23 24"),
        _token("Minute", "m", "0 1 … 58 59"),
        _token("", "mm", "00 01 … 58 59"),
        _token("Second", "s", "0 1 … 58 59"),
        _token("", "ss", "00 01 … 58 59"),
        _token("Fraction of a second", "S", "0 1 … 9 (tenths)"),
        _token("", "SS", "00 01 … 99 (hundredths)"),
        _token("", "SSS", "000 001 … 999 (milliseconds)"),
        _token("", "SSSS", "0000 … 9999"),
        _token("", "SSSSS", "00000 … 99999"),
        _token("", "SSSSSS", "000000 … 999999 (microseconds)"),
        _token("Timezone offset", "Z", "-07:00 -06:00 … +06:00 +07:00"),
        _token("", "ZZ", "-0700 -0600 … +0600 +0700"),
        _token("Timezone name", "ZZZ", "DateTime.timeZoneName"),
        _token("Unix timestamp", "X", "Seconds"),
        _token("", "x", "Milliseconds"),
        _token("", "xx", "Microseconds"),
        _token("Localized date", "l", "Short date, unpadded"),
        _token("", "L", "Short date, padded"),
        _token("", "ll", "Short month name, day, year"),
        _token("", "LL", "Month name, day, year"),
        _token("", "lll", "ll with time"),
        _token("", "LLL", "LL with time"),
        _token("", "llll", "Short weekday, ll and time"),
        _token("", "LLLL", "Weekday, LL and time"),
        _token("Localized time", "LT", "Time without seconds"),
        _token("", "LTS", "Time with seconds"),
      ],
      monoColumns: const {1},
    ),
    const H3("Notes on some tokens"),
    const Bullets([
      "`d` and `e` both run 1 to 7 with Monday as 1, like "
          "`DateTime.weekday`. In moment.js `d` runs 0 to 6.",
      "The ordinal weekday is `d_o`, because `do` is a Dart keyword and "
          "can't name the enum value. In a pattern, `do` prints `d` followed "
          "by the letter \"o\".",
      "`YY` and `gg` give two digits only for 1970 through 2030 and print "
          "other years in full, so the short form can't be misread.",
      "`w`, `ww`, `wo`, `gg` and `gggg` use ISO 8601 weeks, which start on "
          "Monday. A date in late December can be in week 1 of the next week "
          "year.",
      "`ZZZ` is whatever `DateTime.timeZoneName` returns, which differs "
          "between platforms and browsers. Use `Z` or `ZZ` when the output "
          "has to be stable.",
      "Ordinals, month and weekday names, AM/PM, eras and the `L…` formats "
          "come from the localization. A [custom localization]"
          "(/creating-localization) that leaves one out prints a readable "
          "fallback such as \"Day 65 of the year (ordered)\".",
    ]),
    const P(
      "Dart counts 1 BC as year 0 and 44 BC as -43. `YYYY` prints that "
      "number, while `y` prints the year within its era. `X` rounds toward "
      "the past, so half a second before the epoch is -1:",
    ),
    Live(tick: false, [
      l(
        "DateTime.utc(-43, 3, 15).format(payload: \"y NN\")",
        () => DateTime.utc(-43, 3, 15).format(payload: "y NN"),
      ),
      l(
        "DateTime.utc(-43, 3, 15).format(payload: \"YYYY\")",
        () => DateTime.utc(-43, 3, 15).format(payload: "YYYY"),
      ),
      l(
        "DateTime.utc(1969, 12, 31, 23, 59, 59, 500).format(payload: \"X\")",
        () => DateTime.utc(1969, 12, 31, 23, 59, 59, 500).format(payload: "X"),
      ),
    ]),
  ],
);
