---
sidebar_position: 20
id: common-mishaps
---

# Common mishaps

Mishaps mentioned below is not `moment_dart` specific, and are quite common
when working with `DateTime` objects.

## Using methods on object with UTC

`DateTime` that come from APIs, parsed from [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)
strings, processed through libraries (i.e., OpenAPI, and other code generation
tools) are very likely to be anchored in **UTC** timezone. But most of the time,
you would want to display date time in the user's local timezone. Here are some
examples and fixes:

### Example: displaying wrong date

In this example, local timezone is ET (UTC-7)

Because `DateTime` came from the API was in UTC, we are 7 hours ahead.

```dart
final User user = Api().getUserById("3838dda1-6956-4754-a5c6-a29634e9fa54");
// user.createdDate -> 2023 Jun 2, 11AM (Eastern Time)

print(user.createdDate.LT); // 6:00 PM
```

Fix:

Convert to local timezone first.

```dart
print(user.createdDate.toLocal().LT); // 11:00 AM
```

### Example: messing up calculation

In this example, local timezone is ULAT (UTC+8)

Our days calculation is off by single day, because startDate was at `7 AM` (UTC+8),
which is `1AM` at the **day before** in UTC timezone. For important calculations
(i.e. banking), these kind of miscalucations have huge penalty.

```dart
final raw = await SharedPreferences.getString("startDate"); // [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) string
assert(raw != null);

final startDate = Moment.parse(raw!);

// We're off by -1 days
final days = startDate.differenceInDays(Moment.now()).abs(); // 48
```

Fix:

Convert to local timezone first.

```dart
final days = startDate.toLocal().differenceInDays(Moment.now()).abs(); // 49
```
