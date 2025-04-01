---
sidebar_position: 11
id: creating-localization
---

# Implementing localization

You can extend `MomentLocalization` class to implement localization for
your own language. Majority of the functionalities are defined as **methods**,
allowing developers to acheive unique features of their language.

Best way to implement a new localization is to copy `en_US`, or a localization
that is similar to your language, then make modifications.

`MomentLocalization` relies heavily on [Mixins](https://dart.dev/language/mixins)

## Example implementation

```dart
import 'package:moment_dart/src/formatters/token.dart';
import 'package:moment_dart/src/calendar.dart';
import 'package:moment_dart/src/localizations.dart';

class LocalizationEnMeowKC extends MomentLocalization {
  @override
  CalenderLocalizationData get calendarData => CalenderLocalizationData(
        keywords: CalenderLocalizationKeywords(
          at: (date, time) => "meow $time",
          lastWeekday: (weekday) => "Last meow $weekday",
          nextWeekday: (weekday) => weekday,
        ),
        relativeDayNames: {
          -1: "Yestermeow",
          0: "Meowday",
          1: "Tomeowow",
        },
      );

  @override
  String? get countryCode => "KC"; // Kingdom of Cats

  @override
  String get endonym => "Meow!";

  @override
  String get languageCode => "en";

  @override
  String get languageNameInEnglish => "Meowlish!";

  @override
  String get locale => "en_Meow_KC"; // You may want to override this one

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() => {
        // Localization aware formats - Highly recommend implementing these :)
        FormatterToken.L: (dateTime) => reformat(dateTime, "YYYY/MM/DD"),
        FormatterToken.l: (dateTime) => reformat(dateTime, "YYYY/M/D"),
        FormatterToken.LL: (dateTime) =>
            reformat(dateTime, "MMMM D, [meow] YYYY"),
        FormatterToken.ll: (dateTime) =>
            reformat(dateTime, "MMM D, [meow] YYYY"),
        FormatterToken.LLL: (dateTime) =>
            reformat(dateTime, "MMMM D, [meow] YYYY, HH:mm [meow!]"),
        FormatterToken.lll: (dateTime) =>
            reformat(dateTime, "MMM D, [meow] YYYY, HH:mm [meow!]"),
        FormatterToken.LLLL: (dateTime) =>
            reformat(dateTime, "dddd, MMMM D, [meow] YYYY, HH:mm [meow!]"),
        FormatterToken.llll: (dateTime) =>
            reformat(dateTime, "ddd, MMM D, [meow] YYYY, HH:mm [meow!]"),
        FormatterToken.LT: (dateTime) => reformat(dateTime, "HH:mm"),
        FormatterToken.LTS: (dateTime) => reformat(dateTime, "HH:mm:ss"),
      };

  @override
  String relative(Duration duration, [bool dropPrefixOrSuffix = false]) =>
      "(in) Meow $duration (ago)";

  @override
  Map<int, String> get weekdayName => {
        DateTime.monday: "Meowday #1",
        ...,
        DateTime.sunday: "Meowday #7",
      };
}
```

## Example usage of mixins

```dart
class MewLocale extends MomentLocalization with Ordinal, MonthNames {
  /* ... folded code ... */

  @override
  Map<int, String> get monthNames => {
    DateTime.january: "Janmeow",
    ...,
    DateTime.december: "Decemeow",
  };

  @override
  Map<int, String> get monthNamesShort => monthNames.map((key, value) => MapEntry(key, value.substring(0,3)));

  @override
  String ordinalNumber(int n) => "meow $nº";

  @override
  Map<FormatterToken, FormatterTokenFn?> overrideFormatters() => {
        // From [EnglishLikeOrdinal] mixin
        ...formattersWithOrdinal, // Provided by mixin `Ordinal`
        // From [MonthNames] mixin
        ...formattersForMonthNames, // Provided by mixin MonthNames
        
        /* Other formatters */
      };
}
```
