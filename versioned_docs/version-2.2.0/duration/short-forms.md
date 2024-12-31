---
id: short-forms
---

# Short forms

You can use `Abbreviation` for both relative and precise durations.

```dart
final yesterday = Moment.now() - const Duration(days: 1);
yesterday.fromNow(form: Abbreviation.full); // 1d ago

final add37min = Moment.now() + const Duration(minutes: 37);
add37min.fromNow(form: Abbreviation.semi); // 37 min ago

final add46min = Moment.now() + const Duration(minutes: 46);
add46min.fromNow(form: Abbreviation.full); // in 1h
```

:::note

The implementation of this feature for languages may be suboptimal.

If you think mid/short words for your langauge could use some improvement,
please make a pull request. See [contribution guidelines](https://github.com/sadespresso/moment_dart/blob/master/CONTRIBUTE.md)

:::
