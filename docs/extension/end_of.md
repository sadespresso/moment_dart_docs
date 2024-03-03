---
sidebar_position: 3
id: endOf
---

# End of year/month/.../second

## Usage

```dart
// >>> In this example, local timezone is UTC+8 <<<
final Moment tada =
      DateTime(2022, 6, 19, 21, 9, 33).toMoment(); // June 19 2022 09:09 PM

tada.endOf(DurationUnit.day); // June 19 2022 11:59 PM
// OR
tada.endOfDay(); // June 19 2022 11:59PM
```

## List of methods

Extension methods can be called on `DateTime` and `Moment` objects.

* `endOf(DurationUnit unit)`

    Methods below are abbreviations for this method.

    **Special cases**:

  * Returns clone of the object when passed `DurationUnit.microseconds`
  * Throws [`MomentException`](https://pub.dev/documentation/moment_dart/1.0.0-rc.1/moment_dart/MomentException-class.html)
    when passed `DurationUnit.week` as it doesn't have any way to determine the
    End of the week.

* `endOfMillisecond()`
* `endOfSecond()`
* `endOfMinute()`
* `endOfHour()`
* `endOfDay()`

* `endOfLocalWeek([int? weekStart])`

    Returns End of the week based on [weekStart]. If it's null, it uses `Moment.defaultLocalization.weekStart`.
    When called on `Moment` instance, uses the instance's localization week start

* `endOfIsoWeek()`
* `endOfMonth()`
* `endOfYear()`
