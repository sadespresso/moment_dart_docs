---
sidebar_position: 4
id: formatting
---

# Formatting

## Usage

Formatter uses custom tokens. See list of [formatter tokens](#formatter-tokens-)

Escape strings by **encasulating them in square brackets ([])**.

```dart
epoch.format("YYYY [YYYY] MMMM [MMMM] Do [Do] LT [A]"); // 1970 YYYY January MMMM 1st Do 12:00 AM A
```

Alternatively, unmatched tokens will be left as is

```dart
epoch.format("YYYY년 MMM D일 ddd A h:mm"); // 1970년 1월 1일 목 오전 8:00 (Localization: KO)
```

## Locale-specific formatters

```dart
// Same as calling the getter. [now.LL]
now.formatDate(); // July 14 2023

// Same as calling the getter. [now.ll]
now.formatDateShort(); // Jul 14 2023

// Same as calling the getter. [now.LLL]
now.formatDateTime(); // July 14 2023 03:50 AM

// Same as calling the getter. [now.lll]
now.formatDateTimeShort(); // Jul 14 2023 3:50 AM

// Same as calling the getter. [now.LLLL]
now.formatDateTimeWithWeekday(); // Friday, July 14 2023 03:50 AM

// Same as calling the getter. [now.llll]
now.formatDateTimeWithWeekdayShort(); // Fri, Jul 14 2023 3:50 AM

// Same as calling the getter. [now.LT]
now.formatTime(); // 3:50 AM

// Same as calling the getter. [now.LTS]
now.formatTimeWithSeconds(); // 3:50:46 AM
```

:::tip

Settings `forceLocal: true` converts DateTime to local one before formatting. Useful
for parsed `DateTime`s and ones came from API.

```dart
now.formatTime(forceLocal: true);
now.toLocal().LTS;
```

:::

See [localization specific tokens](#localization-specific-tokens)

## Formatter Tokens 🔑

| Type                      | Token  | Example                                | Description                                                                                   |
| ------------------------- | ------ | -------------------------------------- | --------------------------------------------------------------------------------------------- |
| Month                     | M      | 1 2 ... 11 12                          |                                                                                               |
|                           | Mo     | 1st 2nd ... 11th 12th                  |                                                                                               |
|                           | MM     | 01 02 ... 11 12                        |                                                                                               |
|                           | MMM    | Jan Feb ... Nov Dec                    |                                                                                               |
|                           | MMMM   | January February ... November December |                                                                                               |
| Quarter of year           | Q      | 1 2 3 4                                |                                                                                               |
|                           | Qo     | 1st 2nd 3rd 4th                        |                                                                                               |
| Day of month              | D      | 1 2 ... 30 31                          |                                                                                               |
|                           | Do     | 1st 2nd ... 30th 31st                  |                                                                                               |
|                           | DD     | 01 02 ... 30 31                        |                                                                                               |
| Day of year               | DDD    | 1 2 ... 364 365                        |                                                                                               |
|                           | DDDo   | 1st 2nd ... 364th 365th                |                                                                                               |
|                           | DDDD   | 001 002 ... 364 365                    |                                                                                               |
| Day of week               | d      | 1 2 ...6 7                             | Moment.js uses \`0-6\`. However, we'll be using \`1-7\` to be in accordance with \[DateTime\] |
|                           | d\_o   | 1st 2nd ... 6th 7th                    | "do" is Dart language keyword                                                                 |
|                           | dd     | Mo Tu ... Sa Su                        |                                                                                               |
|                           | ddd    | Mon Tue ... Sat Sun                    |                                                                                               |
|                           | dddd   | Monday ... Saturday Sunday             |                                                                                               |
| Day of week (ISO)         | e      | 1 2 ... 6 7                            |                                                                                               |
| Week of year (ISO)        | w      | 1 2 ... 52 53                          |                                                                                               |
|                           | wo     | 1st 2nd ... 52nd 53rd                  |                                                                                               |
|                           | ww     | 01 02 ... 52 53                        |                                                                                               |
| Year                      | YY     | 70 71 ... 29 30                        |                                                                                               |
|                           | YYYY   | 1970 1971 ... 2029 2030                |                                                                                               |
| Era Year                  | y      | 1 2 ... 2020 ...                       |                                                                                               |
| Era                       | NN     | BC AD                                  | Abbr era name                                                                                 |
|                           | NNNN   | Before Christ, Anno Domini             | Full era name                                                                                 |
|                           | NNNNN  | BC AD                                  | Narrow era name                                                                               |
| Week year                 | gg     | 70 71 ... 29 30                        |                                                                                               |
|                           | gggg   | 1970 1971 ... 2029 2030                |                                                                                               |
| AM/PM                     | A      | AM PM                                  | UPPERCASE                                                                                     |
|                           | a      | am pm                                  | lowercase                                                                                     |
| Hour                      | H      | 0 1 ... 22 23                          |                                                                                               |
|                           | HH     | 00 01 ... 22 23                        |                                                                                               |
|                           | h      | 1 2 ... 11 12                          |                                                                                               |
|                           | hh     | 01 02 ... 11 12                        |                                                                                               |
|                           | k      | 1 2 ... 23 24                          |                                                                                               |
|                           | kk     | 01 02 ... 23 24                        |                                                                                               |
| Minute                    | m      | 0 1 ... 58 59                          |                                                                                               |
|                           | mm     | 00 01 ... 58 59                        |                                                                                               |
| Second                    | s      | 0 1 ... 58 59                          |                                                                                               |
|                           | ss     | 00 01 ... 58 59                        |                                                                                               |
| Fractional second         | S      | 0 1 ... 8 9                            |                                                                                               |
|                           | SS     | 00 01 ... 98 99                        |                                                                                               |
|                           | SSS    | 000 001 ... 998 999                    |                                                                                               |
|                           | SSSS   | 0000 0001 ... 9998,9999                |                                                                                               |
|                           | SSSSS  | 00000 00001 ... 99998,99999            |                                                                                               |
|                           | SSSSSS | 000000 000001 ... 999998,999999        |                                                                                               |
| Timezone                  | Z      | \-07:00 -06:00 ... +06:00 +07:00       |                                                                                               |
|                           | ZZ     | \-0700 -0600 ... +0600 +0700           |                                                                                               |
| Timezone name             | ZZZ    |                                        | Returns \[DateTime.timeZoneName\], results may not be consistent across platforms             |
| Unix timestamp in seconds | X      | 1654063960                             |                                                                                               |
| Unix timestamp            | x      | 1654063974620                          |                                                                                               |

### Localization specific tokens

Following fromatters are specific to each localization, and are implemented
at per-localization level.

| Token | Example                             | Description                                                 |
| ----- | ----------------------------------- | ----------------------------------------------------------- |
| l     | 9/4/1986                            | Date (in local format, shorter)                             |
| L     | 09/04/1986                          | Date (in local format)                                      |
| ll    | Sep 4 1986                          | Month name, day of month, year (shorter)                    |
| LL    | September 04 1986                   | Month name, day of month, year                              |
| lll   | Sep 4 1986 8:30 PM                  | Month name, day of month, year, time                        |
| LLL   | September 04 1986 8:30 PM           | Month name, day of month, year, time                        |
| llll  | Thu, Sep 4 1986 8:30 PM             | Day of week, month name, day of month, year, time (shorter) |
| LLLL  | Thursday, September 04 1986 8:30 PM | Day of week, month name, day of month, year, time           |
| LT    | 8:30 PM                             | Time (without seconds)                                      |
| LTS   | 8:30:00 PM                          | Time (with seconds)                                         |
