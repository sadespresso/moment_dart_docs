---
id: index
---

# Extension

Extensions are helper methods that are not part of the class. We use Dart's
[extension methods](https://dart.dev/language/extension-methods).

These methods can be called on `DateTime`, and `Moment` objects. (as Moment
is subclass of DateTime)

## Timezone types

Dart's [DateTime](https://api.dart.dev/stable/dart-core/DateTime-class.html) have
two timezone types. Local and UTC.

> A DateTime object is anchored either in the UTC time zone or in the local time
> zone of the current computer when the object is created.
>
> Source: Dart official API docs
