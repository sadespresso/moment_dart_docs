# Precise Duration

## Usage

Auto-format usually chooses most suitable two units.

See [abbreviation options](short-forms.md)

```dart
final epoch = Moment.fromMillisecondsSinceEpoch(0);
final now = DateTime(2023, DateTime.july, 14).toMoment();

print(epoch.fromPrecise(now)); // 53 years 7 months ago
```

A little crazy example

```dart
final nextYear = now.add(const Duration(days: 365));

print(nextYear.fromPrecise(
  now,
  format: DurationFormat.all,
  omitZeros: false, // default true
  form: UnitStringForm.mid,
  delimiter: ", ", // default " "
));
// in 1 yr, 0 mo, 0 day, 0 hr, 0 min, 0 sec
```

### Discarding smaller units

When a duration is formatted, any units that are smaller than the
smallest unit given in `DurationFormat` are discarded. Demonstration:

```dart
const duration1d1h = Duration(days: 1, hours: 1);

duration1d1h.toDurationString(format: DurationFormat([DurationUnit.day]), dropPrefixOrSuffix: true); // a day (here we lose precision of 1 hour)
duration1d1h.toDurationString(format: DurationFormat([DurationUnit.hour]), dropPrefixOrSuffix: true); // 25 hours
```

## Using on `Duration`

```dart
Duration(days: 67, hours: 3, minutes: 2).toDurationString(
  MomentLocalizations.de(),
  form: UnitStringForm.mid,
); // in 2 Mo. 7 Tg.
```

## Formatting

By default, the most suitable format is chosen from [default formats](#default-formats).

You can create a `DurationFormat` with `DurationUnit` list, in order. This is
useful if you need to display specific units. For example, "x days left"
countdown.

```dart
final DurationFormat d = DurationFormat([DurationUnit.day]);

const Duration(days: 13).toDurationString(format: d); // in 13 days
```

### Default formats

| Format            | units                                     |
| ----------------- | ----------------------------------------- |
| DurationFormat.ym | year, month                               |
| DurationFormat.md | month, day                                |
| DurationFormat.dh | day, hour                                 |
| DurationFormat.hm | hour, minute                              |
| DurationFormat.ms | minute, second                            |
| DurationFormat.s  | second                                    |
| DurationFormat.wd | week , day (only if `includeWeeks: true`) |
