import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:moment_dart/moment_dart.dart';

/// The locale every live example is formatted in, unless the example sets
/// its own.
class LocaleState extends ValueNotifier<String> {
  LocaleState() : super("en_US") {
    _apply();
  }

  set locale(String code) {
    if (code == value) return;
    value = code;
    _apply();
  }

  MomentLocalization get localization =>
      MomentLocalizations.byLocale(value, strict: true)!;

  void _apply() => Moment.setGlobalLocalization(localization);
}

/// Ticks once a second, aligned to the wall clock.
class Clock extends ChangeNotifier {
  Timer? _timer;
  int _listeners = 0;

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);
    if (_listeners++ == 0) _start();
  }

  @override
  void removeListener(VoidCallback listener) {
    super.removeListener(listener);
    if (--_listeners == 0) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void _start() {
    final int ms = DateTime.now().millisecond;
    _timer = Timer(Duration(milliseconds: 1000 - ms + 5), () {
      notifyListeners();
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => notifyListeners(),
      );
    });
  }
}

final LocaleState localeState = LocaleState();
final Clock clock = Clock();
final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

/// Rebuilds on every tick and locale change.
class LiveBuilder extends StatelessWidget {
  final bool tick;
  final WidgetBuilder builder;

  const LiveBuilder({super.key, this.tick = true, required this.builder});

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: tick ? Listenable.merge([clock, localeState]) : localeState,
    builder: (context, _) => builder(context),
  );
}

const List<({String code, String name})> supportedLocales = [
  (code: "en_US", name: "English"),
  (code: "ar_PS", name: "العربية"),
  (code: "de_DE", name: "Deutsch"),
  (code: "es_ES", name: "Español"),
  (code: "fr_FR", name: "Français"),
  (code: "it_IT", name: "Italiano"),
  (code: "ja_JP", name: "日本語"),
  (code: "ko_KR", name: "한국어"),
  (code: "mn_MN", name: "Монгол"),
  (code: "mn_Mong_MN", name: "Mongol bichig"),
  (code: "mn_Qaaq_MN", name: "Mongol bichig, Mongolian digits"),
  (code: "pl_PL", name: "Polski"),
  (code: "pt_PT", name: "Português"),
  (code: "ru_RU", name: "Русский"),
  (code: "tr_TR", name: "Türkçe"),
  (code: "zh_CN", name: "简体中文"),
];

bool containsMongolian(String text) =>
    text.runes.any((r) => r >= 0x1800 && r <= 0x18AF);

/// The reader's UTC offset, e.g. "UTC+08:00".
String localOffset() {
  final Duration o = DateTime.now().timeZoneOffset;
  final String sign = o.isNegative ? "-" : "+";
  final Duration a = o.abs();
  final String hh = a.inHours.toString().padLeft(2, "0");
  final String mm = (a.inMinutes % 60).toString().padLeft(2, "0");
  return "UTC$sign$hh:$mm";
}
