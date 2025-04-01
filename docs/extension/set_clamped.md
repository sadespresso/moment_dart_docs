---
id: set-clamped
---

# Set clamped

:::info

Available since 4.1.0

:::

Clamped setters set the unit of DateTime objects without overflowing, and
changing the next bigger unit.

These helpers use [`DateTime.copyWith`](https://api.flutter.dev/flutter/dart-core/DateTimeCopyWith/copyWith.html)
under the hood.

`setClampedMonth` also clamps the day for the new month. This is the only
function that does it. e.g., `DateTime(2003, 1, 31).setClampedMonth(DateTime.february)`
-> `DateTime(2003, 2, 28)`

## Example

* Setting clamped day

```dart
/// Setting `day` greater than the month allows results in it overflowing to the next month.
final e1 = DateTime(2024, 2, 1).copyWith(day: 30); // Results in DateTime(2024, 3, 1)

/// Clamped methods prevent Dart's DateTime object's behaviour by recreating the object with clamped
/// values
final e1m = DateTime(2024, 2, 1).setClampedDay(30); // Results in DateTime(2024, 2, 29)
```

* Setting clamped month (this also clamps the day if necessary)

```dart
final e2 = DateTime(2003, 6, 30).setClampedMonth(DateTime.february); // Results in DateTime(2003, 2, 28)
```

## Available extensions

* `setClampedSecond`
* `setClampedMinute`
* `setClampedHour`
* `setClampedDay`
* `setClampedMonth`
