---
sidebar_position: 5
---

# Localizations

MomentLocalization is responsible for the logic required to convert DateTime to
human-readable format. Localizations are lazy-loaded **singletons**. Meaning, they're
instantiated only once, and only if you use the localization.

See [MomentLocalization class definition](https://pub.dev/documentation/moment_dart/latest/moment_dart/MomentLocalization-class.html)

In order to keep the library with no dependencies, all localizations of
`moment_dart` is implemented in the package.

## Get localization

There are number of ways to retreive a localization.

### By language code examples

Retreiving `MomentLocalization` by language code returns the first locale that
meets the criteria. You can make the criteria narrower by providing optional
`countryCode` and `scriptCode` arguments. By default, it will return the closest
possible option, even if `countryCode` and/or `scriptCode` doesn't match.
You can alter this behavior by setting `strict` to `true`.

```dart
MomentLocalizations.byLanguage("mn"); // Returns an instan25004200ce of LocalizationMnMn
MomentLocalizations.byLanguage("01"); // Returns null
```

### By locale

:::tip
`MomentLocalization.locale` is a valid [Unicode Language Identifier](https://www.unicode.org/reports/tr35/#Unicode_language_identifier)
:::

## Available localizations

| Language                                       | Country            | Code       | Class name                                                                                                           |
| ---------------------------------------------- | ------------------ | ---------- | -------------------------------------------------------------------------------------------------------------------- |
| German                                         | Germany            | de_DE      | [LocalizationDeDe](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationDeDe-class.html)         |
| English                                        | United States      | en_US      | [LocalizationEnUs](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationEnUs-class.html)         |
| Spanish                                        | Spain              | es_ES      | [LocalizationEsEs](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationEsEs-class.html)         |
| French                                         | France             | fr_FR      | [LocalizationFrFr](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationFrFr-class.html)         |
| Italian                                        | Italy              | it_IT      | [LocalizationItIt](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationItIt-class.html)         |
| Korean                                         | Korea, Republic of | ko_KR      | [LocalizationKo](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationKo-class.html)             |
| Mongolian                                      | Mongolia           | mn_MN      | [LocalizationMnMn](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationMnMn-class.html)         |
| Traditional Mongolian with Arabic numbers      | Mongolia           | mn_Mong_MN | [LocalizationMnMongMn](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationMnMongMn-class.html) |
| Traditional Mongolian with Traditional Numbers | Mongolia           | mn_Qaaq_MN | [LocalizationMnQaaqMn](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationMnQaaqMn-class.html) |
| Simplified Chinese                             | China              | zh_CN      | [LocalizationZhCn](https://pub.dev/documentation/moment_dart/0.17.4/moment_dart/LocalizationZhCn-class.html)         |
