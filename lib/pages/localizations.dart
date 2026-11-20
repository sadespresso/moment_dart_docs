import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';

final List<(String, MomentLocalization Function())> _bundled = [
  ("MomentLocalizations.arPs()", MomentLocalizations.arPs),
  ("MomentLocalizations.de()", MomentLocalizations.de),
  ("MomentLocalizations.enUS()", MomentLocalizations.enUS),
  ("MomentLocalizations.es()", MomentLocalizations.es),
  ("MomentLocalizations.fr()", MomentLocalizations.fr),
  ("MomentLocalizations.it()", MomentLocalizations.it),
  ("MomentLocalizations.jaJp()", MomentLocalizations.jaJp),
  ("MomentLocalizations.koKr()", MomentLocalizations.koKr),
  ("MomentLocalizations.mn()", MomentLocalizations.mn),
  ("MomentLocalizations.mnMong()", MomentLocalizations.mnMong),
  ("MomentLocalizations.mnMongtn()", MomentLocalizations.mnMongtn),
  ("MomentLocalizations.pl()", MomentLocalizations.pl),
  ("MomentLocalizations.pt()", MomentLocalizations.pt),
  ("MomentLocalizations.ru()", MomentLocalizations.ru),
  ("MomentLocalizations.tr()", MomentLocalizations.tr),
  ("MomentLocalizations.zhCn()", MomentLocalizations.zhCn),
];

String _weekdayInEnglish(int weekday) =>
    MomentLocalizations.enUS().weekdayName[weekday]!;

final DocPage localizationsPage = DocPage(
  path: "/localizations",
  title: "Localizations",
  group: "Languages",
  summary:
      "A `MomentLocalization` turns dates and durations into words for "
      "one language. moment_dart bundles 16 of them. Get one by its factory, "
      "by locale code, or by language code.",
  blocks: () => [
    const H2("Get a localization"),
    const P(
      "When you know the language at compile time, call its factory on "
      "`MomentLocalizations`. Each localization is created once, the first "
      "time you ask for it, and the same instance is returned after that.",
    ),
    Live(tick: false, [
      l(
        "MomentLocalizations.fr().locale",
        () => MomentLocalizations.fr().locale,
      ),
      l(
        "identical(MomentLocalizations.fr(), MomentLocalizations.fr())",
        () => identical(MomentLocalizations.fr(), MomentLocalizations.fr()),
      ),
      l(
        "Moment(DateTime(2024, 3, 15), localization: MomentLocalizations.fr()).LL",
        () => Moment(
          DateTime(2024, 3, 15),
          localization: MomentLocalizations.fr(),
        ).LL,
      ),
    ]),
    const P(
      "Pass it to a single moment as above, or make it the default for every "
      "moment with [global localization](/global-localization).",
    ),
    const H2("By locale"),
    const P(
      "`MomentLocalizations.byLocale` takes a locale code such as a user "
      "setting or a device locale. Dashes and underscores both work, and "
      "matching ignores case. A bare language code like `\"es\"` first tries "
      "`es_ES`.",
    ),
    const P(
      "Since 6.0, when there's no exact match it falls back to the closest "
      "localization of the same language, so `\"en_GB\"` gives English "
      "(United States). It returns `null` only when no bundled localization "
      "speaks that language. Pass `strict: true` to get `null` for anything "
      "that isn't an exact match.",
    ),
    Live(tick: false, [
      l(
        "MomentLocalizations.byLocale(\"de_DE\")?.locale",
        () => MomentLocalizations.byLocale("de_DE")?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"es\")?.locale",
        () => MomentLocalizations.byLocale("es")?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"EN-us\")?.locale",
        () => MomentLocalizations.byLocale("EN-us")?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"en_GB\")?.locale",
        () => MomentLocalizations.byLocale("en_GB")?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"pt-BR\")?.locale",
        () => MomentLocalizations.byLocale("pt-BR")?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"mn-Mong-CN\")?.locale",
        () => MomentLocalizations.byLocale("mn-Mong-CN")?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"sv_SE\")?.locale",
        () => MomentLocalizations.byLocale("sv_SE")?.locale,
      ),
      c(""),
      l(
        "MomentLocalizations.byLocale(\"en_GB\", strict: true)?.locale",
        () => MomentLocalizations.byLocale("en_GB", strict: true)?.locale,
      ),
      l(
        "MomentLocalizations.byLocale(\"es\", strict: true)?.locale",
        () => MomentLocalizations.byLocale("es", strict: true)?.locale,
      ),
    ]),
    const Note(NoteKind.warning, [
      P(
        "The fallback only looks at the language. `\"zh_TW\"` gives "
        "Simplified Chinese and `\"pt_BR\"` gives European Portuguese. If a "
        "near match is wrong for your users, use `strict: true` and pick the "
        "fallback yourself.",
      ),
    ]),
    const H2("By language"),
    const P(
      "`MomentLocalizations.byLanguage` takes a language code and optional "
      "`countryCode` and `scriptCode`, and returns the first localization that "
      "matches. If nothing matches, it drops the country code, then the "
      "script code, and tries again. `strict: true` turns that off.",
    ),
    Live(tick: false, [
      l(
        "MomentLocalizations.byLanguage(\"mn\")?.locale",
        () => MomentLocalizations.byLanguage("mn")?.locale,
      ),
      l(
        "MomentLocalizations.byLanguage(\"mn\", scriptCode: \"Mong\")?.locale",
        () => MomentLocalizations.byLanguage("mn", scriptCode: "Mong")?.locale,
      ),
      l(
        "MomentLocalizations.byLanguage(\"en\", countryCode: \"GB\")?.locale",
        () => MomentLocalizations.byLanguage("en", countryCode: "GB")?.locale,
      ),
      l(
        "MomentLocalizations.byLanguage(\"en\", countryCode: \"GB\", strict: true)?.locale",
        () => MomentLocalizations.byLanguage(
          "en",
          countryCode: "GB",
          strict: true,
        )?.locale,
      ),
      l(
        "MomentLocalizations.byLanguage(\"e\")?.locale",
        () => MomentLocalizations.byLanguage("e")?.locale,
      ),
    ]),
    const H2("Bundled localizations"),
    const P(
      "The English name, endonym and week start below are read from each "
      "localization as the page renders. The class names follow the locale: "
      "`LocalizationDeDe`, `LocalizationMnMongMn` and so on.",
    ),
    TableBlock(
      ["Locale", "Factory", "Language", "Endonym", "Week starts"],
      [
        for (final (String factory, MomentLocalization Function() make)
            in _bundled)
          [
            () => make().locale,
            factory,
            () => make().languageNameInEnglish,
            () => make().endonym,
            () => _weekdayInEnglish(make().weekStart),
          ],
      ],
      monoColumns: const {1},
    ),
    const P(
      "The two traditional Mongolian script localizations differ only in "
      "digits: `mn_Mong_MN` uses Western digits and `mn_Qaaq_MN` uses "
      "traditional Mongolian digits.",
    ),
    const H2("What a localization knows about itself"),
    const P(
      "Each localization describes itself, which is handy for a language "
      "picker. `endonym` is the language's name in that language, "
      "`languageNameInEnglish` is its English name, and `weekStart` is the "
      "first day of the week as a `DateTime` weekday constant. `weekStart` "
      "decides where local weeks begin in "
      "[startOfLocalWeek](/extension/startOf) and "
      "[LocalWeekTimeRange](/time-range).",
    ),
    Live(tick: false, [
      c("final de = MomentLocalizations.de();"),
      c(""),
      l("de.locale", () => MomentLocalizations.de().locale),
      l("de.languageCode", () => MomentLocalizations.de().languageCode),
      l("de.countryCode", () => MomentLocalizations.de().countryCode),
      l("de.endonym", () => MomentLocalizations.de().endonym),
      l(
        "de.languageNameInEnglish",
        () => MomentLocalizations.de().languageNameInEnglish,
      ),
      l(
        "de.weekStart == DateTime.monday",
        () => MomentLocalizations.de().weekStart == DateTime.monday,
      ),
    ]),
    const P(
      "To build that picker, go through `MomentLocalizations.locales`. Its "
      "keys are locale codes and each value returns the localization.",
    ),
    Live(tick: false, [
      l(
        "MomentLocalizations.locales.values.map((make) => make().endonym).join(\", \")",
        () => MomentLocalizations.locales.values
            .map((make) => make().endonym)
            .join(", "),
      ),
    ]),
    const P(
      "Many localized strings changed in 6.0. If your tests compare output "
      "text, see [Upgrading to 6.0](/upgrading). To add a language, see "
      "[Writing a localization](/creating-localization).",
    ),
  ],
);
