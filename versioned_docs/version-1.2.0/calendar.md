---
sidebar_position: 3
id: calendar
---

# Calendar

## Usage

```dart
final Moment now = Moment.now();

print(now.calendar()); // Today at 03:00 PM
```

If the date is further than 7 days, result will be a date time formatted with
`MomentLocalization.localizationDefaultDateFormat`, and hours omitted.

```dart
final epoch = Moment.fromMillisecondsSinceEpoch(0);

epoch.calendar(); // 1/1/1970
```

## Options

### Changing reference

By default, calendar date is calculated from the current date time. You can
change that by providing a custom reference date.

```dart
var now = DateTime(2023, DateTime.july, 14); // Current time
var ref = DateTime(2023, DateTime.july, 15);

now.calendar(omitHours: true); // Today
now.calendar(reference: ref, omitHours: true); // Yesterday
```

Today is Tomorrow's Yesterday... I know, it can be confusing.

### Omitting hours

Example:

```dart
var yesterday = Moment.now() - const Duration(days: 1);

yesterday.calendar(); // Yesterday at 01:17 AM
yesterday.calendar(omitHours: true); // Yesterday
```

:::info

Hours are omitted if the date is further than 7 days.

:::
