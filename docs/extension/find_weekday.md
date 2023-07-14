---
sidebar_position: 4
id: findWeekday
---

# Find weekdays

:::warning

Weekday extension methods **do not check** timezones. Make sure both
of your objects are of same [timezone type](extension.md#timezone-types).

:::

## Usage

```dart
// Local timezone is UTC+8

final Moment tada =
    DateTime(2022, DateTime.june, 19).toMoment(); // June 19 2022 12:00 AM

print(tada.nextMonday()); // June 20 2022 12:00 AM

print(tada.lastMonday()); // June 13 2022 12:00 AM
```

:::warning

This Sunday is neither last nor next Sunday.

```dart
DateTime sunday = DateTime(2022, DateTime.june, 19);
sunday.weekday == DateTime.sunday; // true

sunday.lastSunday(); // June 12 2022 09:09 PM
```

> As this can get controversial, might change in the future.

:::

## Generic method

* nextWeekday(int n)
* lastWeekday(int n)

Example:

```dart
epoch.nextWeekday(DateTime.sunday);
```
