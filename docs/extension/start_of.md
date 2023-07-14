---
sidebar_position: 2
id: startOf
---

# Start of year/month/.../second

:::warning

`.startOf*()` extension methods **do not check** timezones. Make sure your
`DateTime` or `Moment` object is of the desired timezone.

:::

## Usage

```dart
// >>> In this example, local timezone is UTC+8 <<<
final Moment tada =
      DateTime(2022, 6, 19, 21, 9, 33).toMoment(); // June 19 2022 09:09 PM

tada.startOf(DurationUnit.day); // June 19 2022 12:00 AM
// OR
tada.startOfDay(); // June 19 2022 12:00 AM
```

## List of methods

All extension methods can be called on `DateTime` and `Moment` objects.

* `startOf(DurationUnit unit)`

    Methods below are abbreviations for this method.

    Special cases:

  * Returns clone of the object when passed `DurationUnit.microseconds`
  * Throws [`MomentException`](https://pub.dev/documentation/moment_dart/0.17.5/moment_dart/MomentException-class.html)
    when passed `DurationUnit.week` as it doesn't have any way to determine the
    start of the week.

* `startOfMillisecond()`
* `startOfSecond()`
* `startOfMinute()`
* `startOfHour()`
* `startOfDay()`
* `startOfLocalWeek([int? weekStart])`

    Returns start of the week based on [weekStart]. If it's null, it uses `Moment.defaultLocalization.weekStart`.
    When called on `Moment` instance, uses the instance's localization week start

* `startOfMonth()`
* `startOfYear()`
