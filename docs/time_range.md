---
sidebar_position: 6
id: time-range
---

# Time range

TimeRange is a simple class that holds `from` and `to` DateTime values. It's
designed to be helpful for filters when filtering data. For example, in Flutter,
it'd be useful to pattern match against the different time range
classes. For example:

```dart
Future<void> pickRange() async {
    final TimeRange? range = await switch(range) {
        YearTimeRange yearRange => pickYear(...),
        MonthTimeRange monthRange => pickYearMonth(...),
        LocalWeekTimeRange weekRange => pickWeek(...),
        DayTimeRange dayRange => pickDate(...),
        HourTimeRange hourRange => pickDateAndHour(...),
        CustomTimeRange custom => pickRange(...),
        _ => null,
    }
    
    if(!mounted) return;

    setState(() => currentRange = range);
}
```

You can easily iterate through time ranges (except `CustomTimeRange`) like so:

```dart
final LocalWeekTimeRange thisWeek = TimeRange.thisLocalWeek();

// If you have generic type variable, check using `is PageableRange`

final TimeRange generic = ...;
final TimeRange? nextRange = generic is PageableRange ? (generic as PageableRange).next : null;
```

## Serializing and parsing

Serialized time ranges **will preserve** its type.

You can serialize time ranges like so:

```dart
final YearTimeRange thisYear = TimeRange.thisYear();

thisYear.encode(); // YearTimeRange@2024-01-01T00:00:00.000
thisYear.encodeShort(); // Y#gs14fme4g0

// identical with .encode()
thisYear.toString(); //YearTimeRange@2024-01-01T00:00:00.000
```

Parsing works for both short and long formats. e.g.,

```dart
final fromShort = TimeRange.parse("Y#gs14fme4g0"); // -> YearTimeRange(2024)
final fromEncoded = TimeRange.parse("YearTimeRange@2024-01-01T00:00:00.000"); // -> YearTimeRange(2024)
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

* `intersect(TimeRange other)`

  Returns the intersection of two ranges, or null if they do not overlap.

  ```dart
  final TimeRange a = DateTime(1970).rangeTo(DateTime(2000).endOfYear());
  final TimeRange b = DateTime(1975).rangeTo(DateTime(3000));

  final TimeRange? intersection = a.intersect(b); // CustomTimeRange(DateTime(1975), DateTime(2000, 12, 31, 23, 59, 59, 999, 999))

  final TimeRange century20 = DateTime(1900).rangeTo(DateTime(1999).endOfYear());
  final TimeRange century21 = DateTime(2000).rangeTo(DateTime(2999).endOfYear());

  final TimeRange? centuriesIntersection = century20 & century21; // null
  ```

* `toCustom()`

  Returns this as a custom time range. You can also use the `.asCustom` getter.
  If it's already a [`CustomTimeRange`](https://pub.dev/documentation/moment_dart/latest/moment_dart/CustomTimeRange-class.html),
  it returns itself.

  ```dart
  final todayRange = TimeRange.today(); // DayTimeRange(2025, 4, 20)
  todayRange.toCustom(); // CustomTimeRange(DateTime(2025, 4, 20), DateTime(2025, 4, 20, 23, 59, 999, 999))
  ```

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
  * `TimeRange.allTime()`
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
