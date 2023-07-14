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

## Full/mid/short forms

:::note
The implementation of this feature for languages may be suboptimal.

If you think mid/short words for your langauge could use some improvement,
please make a pull request. See [contribution guidelines](https://github.com/sadespresso/moment_dart/blob/master/CONTRIBUTE.md)
:::

```dart
final yesterday = Moment.now() - const Duration(days: 1);
yesterday.fromNow(form: UnitStringForm.short); // 1d ago

final add37min = Moment.now() + const Duration(minutes: 37);
add37min.fromNow(form: UnitStringForm.mid); // 37 min ago

final add46min = Moment.now() + const Duration(minutes: 46);
add46min.fromNow(form: UnitStringForm.short); // in 1h
```
