---
slug: /duration
id: relative
---

# Relative Duration

:::warning

Relative durations are rather inaccurate for countdown/timer applications. Use
[precise duration](precise.md) for more accuracy and flexibility.

:::

## Usage

```dart
final yesterday = Moment.now() - const Duration(days: 1);
yesterday.fromNow(); // a day ago

final add5sec = Moment.now().add(const Duration(seconds: 5));
add5sec.fromNow(dropPrefixOrSuffix: true); // a few seconds
```

See [abbreviation options](short-forms.md)

## Threshold

Relative durations' output will follow the table below.

| Threshold (up to) | Text to be displayed |
| ----------------- | -------------------- |
| 45 seconds        | a few seconds        |
| 90 seconds        | a minute             |
| 45 minutes        | `n` minutes          |
| 90 minutes        | an hour              |
| 22 hours          | `n` hours            |
| 36 hours          | a day                |
| 26 days           | `n` days             |
| 45 days           | a month              |
| 320 days          | `n` months           |
| 548 days          | a year               |
| -                 | `n` year             |

Thus,

```dart
final x = Moment.now() - const Duration(days: 547)
 + fromNow(); // a year ago
```
