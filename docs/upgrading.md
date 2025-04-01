---
sidebar_position: 2
id: upgrading
---

# Upgrading

## From 4.0.0 -> 5.0.0

Only major change is that `TimeRange.contains`'s `to` is now exclusive.

Meaning,

```dart
// In 4.x.x
assert(YearTimeRange(2025).contains(DateTime(2026,1,1)), true)

// In 5.x.x
assert(YearTimeRange(2025).contains(DateTime(2026,1,1)) => false)
assert(YearTimeRange(2025).contains(DateTime(2026,1,1) - Duration(microsecond: 1)) => true)
```

Everything else is same as 4.1.0

## From 3.0.0 -> 4.0.0

There's no major change in version 4.0.0, but it has an user-facing breaking
change.

If you use `MonthTimeRange`, the format of the output range has been changed.

Before:

```dart
MonthTimeRange(2023, 2).format() // February
```

After:

```dart
MonthTimeRange(2023, 2).format() // February 2023
```
