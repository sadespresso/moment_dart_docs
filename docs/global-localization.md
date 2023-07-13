---
sidebar_position: 6
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
Moment.now(localization: MomentLocalizations.ko());
```

:::
