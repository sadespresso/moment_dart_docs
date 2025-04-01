---
sidebar_position: 2
id: upgrading
---

# Upgrading

## From 4.0.0 -> 5.0.1

TL;DR -> If you don't use TimeRange, no change is necessary

In version 5, all time ranges except `CustomTimeRange` and week time ranges'
`to` has been changed to be inclusive. This means it behaves same as
CustomTimeRange.

### To property example

```dart
// In 4.x.x
assert(YearTimeRange(2020).to == DateTime(2021), true)

// In 5.x.x
assert(YearTimeRange(2020).to == DateTime(2021), false)
assert(YearTimeRange(2020).to == DateTime(2020,12,31,23,59,59,999,999), true)
```

### Contains function example

```dart
// In 4.x.x
assert(YearTimeRange(2025).contains(DateTime(2026,1,1)), true)

// In 5.x.x
assert(YearTimeRange(2025).contains(DateTime(2026,1,1)) => false)
assert(YearTimeRange(2025).contains(DateTime(2026,1,1) - Duration(microsecond: 1)) => true)
```

## From 3.0.0 -> 4.0.0

If you use `MonthTimeRange`, the format of the output range has been changed.

Before:

```dart
MonthTimeRange(2023, 2).format() // February
```

After:

```dart
MonthTimeRange(2023, 2).format() // February 2023
```
