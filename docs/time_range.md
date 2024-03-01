---
sidebar_position: 5
id: time-range
---

# Time range

> Available since v1.2.0

Time ranges are a simple class holds `from` and `to` DateTime values. It's
specifically designed to be used for filters when filtering data. For example,
in Flutter, it'd be useful to pattern match against the different time range
classes. For example:

```dart
Future<void> pickRange() async {
    final range = await switch(range) {
        CustomTimeRange custom => pickRange(...),
        YearTimeRange yearRange => pickYear(...),
        MonthTimeRange monthRange => pickYearMonth(...),
        DayTimeRange dayRange => pickDate(...),
        _ => changeRangeMode(),
    }

    if(!mounted) return;

    setState(() => currentRange = range);
}
```

> `moment_dart` is still a Dart library, and can be used without Flutter

## Methods

* `toUtc()`

  Returns new instance in UTC timezone, or `this` if `this.isUtc == true`.

  :::warning

  All `TimeRange`s store the relevant info (e.g., `year`) and construct
  `DateTime` based on that information. This means `.toUtc()` will behave
  differently than you might expect.

  ```dart
  TimeRange().toUtc().from != TimeRange().from.toUtc();
  TimeRange().toUtc().to != TimeRange().to.toUtc();
  ```

  However, the above isn't true for `CustomTimeRange`, which stores actual
  `DateTime` object, and transforms it.

  :::

* `contains(DateTime point)`

  Returns whether this range contains a point in time (inclusive)

* `containsRange(TimeRange other)`

  Returns whether this range contains the other range (inclusive)

[See full API reference](https://pub.dev/documentation/moment_dart/latest/moment_dart/TimeRange-class.html)

## Getters

* `isUtc`

  Returns whether the range is in UTC timezone

* `duration`

  Returns how long the **TimeRange** spans

* `from`

  Beggining of the **TimeRange**

* `to`

  Ending of the **TimeRange** (last microsecond)

[See full API reference](https://pub.dev/documentation/moment_dart/latest/moment_dart/TimeRange-class.html)

## Create an instance

Relative constructors are inclusive. Meaning `TimeRange.today().to` will equal to
today at `23:59:59.999999`. True for all `TimeRange.` constructors

* `TimeRange.today()`
* `TimeRange.tomorrow()`
* `TimeRange.yesterday()`
* `TimeRange.thisMonth()`
* `TimeRange.nextMonth()`
* `TimeRange.prevMonth()`
* `TimeRange.thisYear()`
* `TimeRange.nextYear()`
* `TimeRange.prevYear()`
* `CustomTimeRange(from, to)`
* `YearTimeRange`
* `MonthTimeRange`
* `DayTimeRange`
