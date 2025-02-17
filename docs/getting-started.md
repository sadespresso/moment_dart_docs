---
sidebar_position: 1
id: getting-started
slug: /
---

# Getting Started ✨

**moment_dart** is a [moment.js](https://momentjs.com/) inspired
[`DateTime`](https://api.dart.dev/dart-core/DateTime-class.html) query,
manipulation, and humanization library for Dart.

:::tip
`Moment` extends `DateTime`, and is **immutable**.

```dart
final now = Moment.now();

assert(now is DateTime); // true
assert(now is Moment); // true
```

:::

## Installation

In your project directory, run:

```sh
dart pub add moment_dart

# For flutter
flutter pub add moment_dart
```

or, manually add in `pubspec.yaml`

```yaml title="pubspec.yaml"
...
dependencies:
    moment_dart: 4.0.1
...
```

## Usage

1. Import the package

    ```dart
    import 'package:moment_dart/moment_dart.dart';
    ```

    You may want to set [**global localization**](global-localization.md) at
    the initialization of your application.

2. Create a moment instance. See [list of constructors](https://pub.dev/documentation/moment_dart/latest/moment_dart/Moment-class.html#constructors)

    ```dart
    Moment moment = DateTime.now().toMoment();
    ```

    You can also use static methods such as

    * `Moment.startOfToday()`
    * `Moment.endOfNextIsoWeek()`

    See [list of static methods](https://pub.dev/documentation/moment_dart/latest/moment_dart/Moment-class.html#static-methods)

## Common problems you might face

Like `DateTime`, most functionality in moment_dart does not check, enforce,
or alter the timezone of date times. Altough, Some methods like
`Moment.format()` do offer options to enforce certain timezone.

You might want to skim through [common mishaps](common-mishaps.md).
