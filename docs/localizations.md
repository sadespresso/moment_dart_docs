---
sidebar_position: 5
id: localizations
---

# Localizations

MomentLocalization is responsible for the logic required to convert DateTime to
human-readable format. Localizations are lazy-loaded **singletons**. Meaning, they're
instantiated only once, and only if you use the localization.

See also:

* [Implementing a localization](creating-localization.md)
* [MomentLocalization class definition](https://pub.dev/documentation/moment_dart/latest/moment_dart/MomentLocalization-class.html)

## Get localization

There are number of ways to retreive a localization.

### By language code examples

Retreiving `MomentLocalization` by language code returns the first locale that
meets the criteria. You can make the criteria narrower by providing optional
`countryCode` and `scriptCode` arguments. By default, it will return the closest
possible option, even if `countryCode` and/or `scriptCode` doesn't match.
You can alter this behavior by setting `strict` to `true`.

```dart
MomentLocalizations.byLanguage("mn"); // Returns the instance of LocalizationMnMn
MomentLocalizations.byLanguage("01"); // Returns null
```

### By locale

:::tip
`MomentLocalization.locale` is a valid [Unicode Language Identifier](https://www.unicode.org/reports/tr35/#Unicode_language_identifier)
:::

```dart
MomentLocalizations.byLocale("en"); // Returns null
MomentLocalizations.byLanguage("es"); // Returns the instance of LocalizationEsEs
```

When given language-only locale, and fails, `.byLocale` tries locales with same
country code. For example, when given "fr", it will try "fr_FR" in case there
is no localization for "fr". This is why "en" returned null in the code block
above.

## Available localizations

| Code       | Language                                       | Country             | Class name                                                                                                          |
| ---------- | ---------------------------------------------- | ------------------- | ------------------------------------------------------------------------------------------------------------------- |
| de_DE      | German                                         | Germany             | [LocalizationDeDe](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationDeDe-class.html)         |
| en_US      | English                                        | United States       | [LocalizationEnUs](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationEnUs-class.html)         |
| es_ES      | Spanish                                        | Spain               | [LocalizationEsEs](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationEsEs-class.html)         |
| fr_FR      | French                                         | France              | [LocalizationFrFr](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationFrFr-class.html)         |
| pt_PT      | Portuguese                                     | Portuguese Republic | [LocalizationPtPT](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationFrFr-class.html)         |
| it_IT      | Italian                                        | Italy               | [LocalizationItIt](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationItIt-class.html)         |
| ko_KR      | Korean                                         | Korea, Republic of  | [LocalizationKoKr](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationKoKr-class.html)         |
| ja_JP      | Japanese                                       | Japan               | [LocalizationJaJp](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationJaJp-class.html)         |
| mn_MN      | Mongolian                                      | Mongolia            | [LocalizationMnMn](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationMnMn-class.html)         |
| mn_Mong_MN | Traditional Mongolian with Arabic numbers      | Mongolia            | [LocalizationMnMongMn](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationMnMongMn-class.html) |
| mn_Qaaq_MN | Traditional Mongolian with Traditional Numbers | Mongolia            | [LocalizationMnQaaqMn](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationMnQaaqMn-class.html) |
| zh_CN      | Simplified Chinese                             | China               | [LocalizationZhCn](https://pub.dev/documentation/moment_dart/1.1.1/moment_dart/LocalizationZhCn-class.html)         |
