import '../docs/model.dart';
import '../playground/duration_playground.dart';
import '../playground/format_playground.dart';
import '../playground/range_playground.dart';

final DocPage playgroundPage = DocPage(
  path: "/playground",
  title: "Playground",
  group: "Try it",
  summary:
      "Try formats, durations and time ranges without writing a line. "
      "Everything here runs moment_dart in your browser, in the language "
      "picked in the header.",
  blocks: () => [
    const H2("Format a date"),
    const P(
      "Type a format string or tap tokens to insert them. The full list, "
      "with descriptions, is in [formatter tokens](/formatting#formatter-tokens).",
    ),
    Embed(
      (_) => const FormatPlayground(),
      searchText: "format string tokens playground date picker utc",
    ),
    const H2("Describe a duration"),
    const P(
      "Set a duration and the options for "
      "[`toDurationString`](/duration/precise) and [`fromNow`](/duration). "
      "The code below the result updates with your choices.",
    ),
    Embed(
      (_) => const DurationPlayground(),
      searchText:
          "duration toDurationString fromNow abbreviation omitZeros "
          "includeWeeks dropPrefixOrSuffix playground",
    ),
    const H2("Page through time ranges"),
    const P(
      "Pick a range type and step through it with `last` and `next`. "
      "See [time ranges](/time-range) for everything a range can do.",
    ),
    Embed(
      (_) => const RangePlayground(),
      searchText:
          "time range year month week day hour next last encode "
          "playground",
    ),
  ],
);
