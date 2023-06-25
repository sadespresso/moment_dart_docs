# Precise Duration



<!-- // >>> In this example, local timezone is UTC+8 <<<

Moment yesterday = Moment.now() - Duration(days: 1, hours: 2);
Moment in2h47m =
    Moment.now() + Duration(hours: 2, minutes: 47, seconds: 15);
Moment fourWeeksAgo = Moment.now() - Duration(days: 28);

// You can omit prefix/suffix, or change forms
String s1 = yesterday.fromNowPrecise(
  dropPrefixOrSuffix: true,
  form: UnitStringForm.full,
); // a day
String s2 = in2h47m.fromNowPrecise(form: UnitStringForm.mid); // in 2 hr 47 min
String s3 = fourWeeksAgo.fromNowPrecise(
  form: UnitStringForm.short,
  includeWeeks: true,
); // 4w ago -->

## Using it on `Duration`

```dart
Duration(days: 67, hours: 3, minutes: 2).toDurationString(
  MomentLocalizations.de(),
  form: UnitStringForm.mid,
); // in 2 Mo. 7 Tg.
```