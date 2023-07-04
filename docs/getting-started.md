---
sidebar_position: 1
slug: /
---

# Getting Started ✨

**moment_dart** is a [moment.js](https://momentjs.com/) inspired
[`DateTime`](https://api.dart.dev/dart-core/DateTime-class.html) query,
manipulation, and humanization library for Dart. This library provides single
class that extends `DateTime`.

:::tip
`Moment` is **immutable**, like its superclass.

```dart
final now = Moment.now();

assert(now is DateTime); // true
assert(now is Moment); // true
```

:::

## Installation

In your project directory, run:

```sh
dart pub get moment_dart
```

or, add it as a dependency in `pubspec.yaml`

```yaml pubspec.yaml
...
dependencies:
    moment_dart: 0.17.4
...
```

## Usage

1. Import the package

    ```dart
    import 'package:moment_dart/moment_dart.dart';
    ```

    You may want to set [**global localization**](./global-localization.md) at
    the startup of your application.

2. Create a moment instance. See [list of constructors](https://pub.dev/documentation/moment_dart/latest/moment_dart/Moment-class.html#constructors)

    ```dart
    Moment moment = DateTime.now().toMoment();
    ```
