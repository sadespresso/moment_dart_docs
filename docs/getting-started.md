---
sidebar_position: 2
---

# Getting Started ✨

> Moment is a **immutable** subclass for DateTime.

1. Import the package

    ```dart
    import 'package:moment_dart/moment_dart.dart';
    ```

    You may want to set [**global localization**](./global-localization.md) at the startup of your application.

2. Create a moment instance. See [list of constructors](https://pub.dev/documentation/moment_dart/latest/moment_dart/Moment-class.html#constructors)

    ```dart
    Moment moment = DateTime.now().toMoment();
    ```

Please note that `Moment` is subclass of `DateTime`. Like its superclass, it's **immutable**.

```dart
final now = Moment.now();

assert(now is DateTime); // true
assert(now is Moment); // true
```