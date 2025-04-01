---
sidebar_position: 5
id: isAtSame
---

# Is at same year/month/.../second

Unit comparison cascades. Meaning, if the following is true

```dart
this.isAtSameDayAs(other) == true;
```

these are naturally true.

```dart
this.isAtSameMonthAs(other);
this.isAtSameYearAs(other);
```

## Usage

```dart
// Local timezone is UTC+8

final DateTime otherBday = DateTime(2003, DateTime.june, 19);
final Moment spiritRoverOnMars = DateTime(2003, DateTime.june, 10).toMoment();

otherBday.isAtSameMonthAs(spiritRoverOnMars); // true
otherBday.isAtSameYearAs(spiritRoverOnMars); // true
```

## List of methods

All extension methods can be called on `DateTime` and `Moment` objects.

Setting `enforceUTC: true` converts both operands to UTC before
checking.

* `isAtSameYearAs()`
* `isAtSameMonthAs()`
* `isAtSameDayAs()`
* `isAtSameHourAs()`
* `isAtSameMinuteAs()`
* `isAtSameSecondAs()`
* `isAtSameMillisecondAs()`
* `isAtSameMicrosecondAs()`
* `isSameLocalWeekAs(DateTime other, [int weekStart = DateTime.monday])`

    When called on `DateTime` objects, weekStart defaults to `DateTime.monday`.

    Calling it on `Moment` will determine the start of the week from its
    localization, therefore omitting the optional argument.
