---
sidebar_position: 1
id: generic
---

# Generic extension methods

## Usage

```dart
DateTime(1900).isLeapYear; // false

DateTime(2023, DateTime.july, 14).week; // 
```

Operators

```dart
// Moon landing happened before present time
DateTime(1969, DateTime.july, 20) < now; // true

DateTime.utc(1970) == DateTime.fromMillisecondsSinceEpoch(0, isUtc: true); // true
```

## List of extensions

### Getters

* date

  Returns new object with hours, minutes, ..., microseconds omitted
* isLeapYear
* hour12
* isAm
* isPm
* quarter
* week

  [ISO Week](https://en.wikipedia.org/wiki/ISO_week_date) number
* weekYear

  Year according to [ISO Week](https://en.wikipedia.org/wiki/ISO_week_date)
* dayOfYear

    Ordinal day of the year

  * January 1st => 1
  * December 31st => 365 (or 366 if `isLeapYear`)

### Methods

* differenceInDays
* timeZoneFormatted
* clone()

  Returns object of same type as the original.

  ```dart
  Moment().clone(); // A new Moment instance
  DateTime().clone(); // A new DateTime instance
  ```

* `toMoment({MomentLocalization? localization})`
* format

  ```dart
  String format({
    String payload = MomentLocalization.localizationDefaultDateFormat,
    bool forceLocal = false,
    MomentLocalization? localization,
  })
  ```

  Format `DateTime` objects without need of creating `Moment`. (Not really
  recommended, no point in avoiding Moment)

### Operators

Now you can use operators on `DateTime` (and `Moment`) objects

* `+(other)`
  
  is equivalent to `add(other)`
* `-(other)`
  
  is equivalent to `subtract(other)`
* `>(other)`
  
  is equivalent to `isAfter(other)`
* `<(other)`
  
  is equivalent to `isBefore(other)`
* `>=(other)`
  
  is equivalent to `isAfter(other) || isAtSameMomentAs(other)`
* `<=(other)`
  
  is equivalent to `isBefore(other) || isAtSameMomentAs(other)`
