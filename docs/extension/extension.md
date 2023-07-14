---
id: index
---

# Extension

Extensions are helper methods that are not part of the class. We use Dart's
[extension methods](https://dart.dev/language/extension-methods).

These methods can be called on `DateTime`, and `Moment` objects. (as Moment
is subclass of DateTime)

As almost all extensions do not check operands' [timezone type](#timezone-types),
you are highly encouraged to check the objects' timezone type.

:::tip

`DateTime` come from APIs (i.e., RESTful), parsed from ISO string, processed
through 3rd party libraries (i.e., Dio, generated code from Open API) are very
likely to be anchored in UTC timezone.

:::

## Timezone types

Dart's [DateTime](https://api.dart.dev/stable/dart-core/DateTime-class.html) have
two timezone types. Local and UTC.

> A DateTime object is anchored either in the UTC time zone or in the local time
> zone of the current computer when the object is created.
>
> Source: Dart official API docs
