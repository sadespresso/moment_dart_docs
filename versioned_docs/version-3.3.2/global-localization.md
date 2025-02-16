---
sidebar_position: 7
id: global-localization
---

# Global Localization

By default, global localization is set to `en_US`. You can set the global
localization by calling `Moment.setGlobalLocalization`.

```dart
Moment.setGlobalLocalization(MomentLocalizations.fr());
```

After setting the global localization, every new instance, and any existing
instance with no explicit localization set will use the new global localization.

:::warning

This instance wouldn't be affected by the global localization because it has
localization set on instance-level.

```dart
final instanceKoKr = Moment.now(localization: MomentLocalizations.koKr());
```

You can check whether an instance is using global localization with `.hasExplicitLocalization`

```dart
// Not using explicit localization
assert(instanceKoKr.hasExplicitLocalization); // true

// Using global localization
assert(Moment.now().hasExplicitLocalization); // false
```

:::
