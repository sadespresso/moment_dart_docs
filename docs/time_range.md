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

* `next`

  Returns a new instance of the next interval.
  
  Not available for `CustomTimeRange`.

* `last`

  Returns a new instance of the last interval.
  
  Not available for `CustomTimeRange`.

* `isUtc`

  Returns whether the range is in UTC timezone.

  Not available for `LocalWeekTimeRange` or `IsoWeekTimeRange`, and will throw
  `UnsupportedError` when called.

* `duration`

  Returns how long the **TimeRange** spans

* `from`

  Beggining of the **TimeRange**

* `to`

  Ending of the **TimeRange** (last microsecond)

[See full API reference](https://pub.dev/documentation/moment_dart/latest/moment_dart/TimeRange-class.html)

## Create an instance

* `CustomTimeRange(from, to)`
  * `LocalWeekTimeRange`
  * `IsoWeekTimeRange`
* `YearTimeRange`
* `MonthTimeRange`
* `DayTimeRange`
* `HourTimeRange`
* Static methods:
  * `TimeRange.thisHour()`
  * `TimeRange.nextHour()`
  * `TimeRange.lastHour()`
  * `TimeRange.today()`
  * `TimeRange.tomorrow()`
  * `TimeRange.yesterday()`
  * `TimeRange.today()`
  * `TimeRange.tomorrow()`
  * `TimeRange.yesterday()`
  * `TimeRange.thisMonth()`
  * `TimeRange.nextMonth()`
  * `TimeRange.lastMonth()`
  * `TimeRange.thisYear()`
  * `TimeRange.nextYear()`
  * `TimeRange.lastYear()`