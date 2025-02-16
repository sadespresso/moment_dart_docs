---
sidebar_position: 2
id: upgrading
---

# Upgrading from v3.0.0

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
