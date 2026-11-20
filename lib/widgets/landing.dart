import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';
import '../docs/state.dart';
import '../theme.dart';
import 'code_view.dart';
import 'footer.dart';
import 'inline.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final double width = MediaQuery.sizeOf(context).width;
    final double gutter = width < 600 ? 18 : (width < 1100 ? 40 : 64);

    Widget section(Widget child, {double top = 0}) => Align(
      alignment: Alignment.topLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1180),
        child: Padding(
          padding: EdgeInsets.fromLTRB(gutter, top, gutter, 0),
          child: child,
        ),
      ),
    );

    return Title(
      title: "moment_dart: dates people can read",
      color: p.ink,
      child: SingleChildScrollView(
        child: SelectionArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              section(const _Hero(), top: width < 600 ? 32 : 72),
              section(const _Languages(), top: 96),
              section(const _Features(), top: 96),
              section(const _Install(), top: 96),
              const SizedBox(height: 96),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}

const List<({String label, String format})> _presets = [
  (label: "Weekday and time", format: "dddd, h:mm:ss A"),
  (label: "Long date", format: "LLLL"),
  (label: "Ordinal", format: "[the] Do [of] MMMM"),
  (label: "ISO week", format: "[week] w [of] gggg"),
  (label: "Timestamp", format: "X"),
];

class _Hero extends StatefulWidget {
  const _Hero();

  @override
  State<_Hero> createState() => _HeroState();
}

class _HeroState extends State<_Hero> {
  final TextEditingController _format = TextEditingController(
    text: _presets.first.format,
  );

  @override
  void initState() {
    super.initState();
    _format.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _format.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final double width = MediaQuery.sizeOf(context).width;
    final bool narrow = width < 700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Text(
            "Turn DateTime into text people can read.",
            style: Txt.h1(p).copyWith(
              fontSize: narrow ? 38 : 62,
              letterSpacing: narrow ? -0.8 : -1.6,
              height: 1.04,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Inline(
            "moment_dart formats, compares and describes dates in 16 "
            "languages. It's inspired by [moment.js](https://momentjs.com), "
            "extends Dart's `DateTime`, and has no dependencies.",
            style: Txt.lead(p),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: p.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: p.line),
          ),
          padding: EdgeInsets.fromLTRB(
            narrow ? 18 : 32,
            narrow ? 18 : 26,
            narrow ? 18 : 32,
            narrow ? 20 : 28,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FormatField(controller: _format),
              SizedBox(height: narrow ? 18 : 26),
              LiveBuilder(
                builder: (context) {
                  String output;
                  try {
                    output = Moment.now().format(_format.text);
                  } catch (e) {
                    output = "That format can't be read: ${describeError(e)}";
                  }
                  return _BigOutput(output.isEmpty ? " " : output);
                },
              ),
              SizedBox(height: narrow ? 18 : 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final preset in _presets)
                    _Chip(
                      label: preset.label,
                      selected: _format.text == preset.format,
                      onTap: () => _format.text = preset.format,
                    ),
                ],
              ),
              const SizedBox(height: 18),
              ValueListenableBuilder(
                valueListenable: localeState,
                builder: (context, code, _) => Inline(
                  "Edit the format above. It's rendered in `$code`; "
                  "change the language from the menu at the top. "
                  "[See every token](/formatting#formatter-tokens).",
                  style: Txt.small(p),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _Button(
              label: "Get started",
              primary: true,
              onTap: () => context.go("/getting-started"),
            ),
            _Button(
              label: "Open the playground",
              onTap: () => context.go("/playground"),
            ),
            _Button(
              label: "What's new in 6.0",
              onTap: () => context.go("/upgrading"),
            ),
          ],
        ),
      ],
    );
  }
}

class _FormatField extends StatelessWidget {
  final TextEditingController controller;
  const _FormatField({required this.controller});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final TextStyle mono = Txt.mono(p, size: 16);

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text.rich(TextSpan(style: mono, children: highlightPrefix(p))),
        IntrinsicWidth(
          child: TextField(
            controller: controller,
            style: mono.copyWith(color: p.string),
            cursorColor: p.hand,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 6,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: p.line, width: 1.5),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: p.hand, width: 2),
              ),
              constraints: const BoxConstraints(minWidth: 60),
            ),
          ),
        ),
        Text('");', style: mono.copyWith(color: p.string)),
      ],
    );
  }

  List<TextSpan> highlightPrefix(Palette p) => [
    TextSpan(
      text: "Moment",
      style: TextStyle(color: p.typeColor),
    ),
    const TextSpan(text: ".now().format("),
    TextSpan(
      text: '"',
      style: TextStyle(color: p.string),
    ),
  ];
}

class _BigOutput extends StatelessWidget {
  final String text;
  const _BigOutput(this.text);

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final double width = MediaQuery.sizeOf(context).width;
    final double size = (width * 0.062).clamp(30.0, 84.0);

    final TextStyle style = TextStyle(
      fontFamily: displayFont,
      fontFamilyFallback: const [monoFont, mongolFont],
      fontWeight: FontWeight.w800,
      fontSize: size,
      height: 1.08,
      letterSpacing: -size * 0.012,
      color: p.ink,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    if (containsMongolian(text)) {
      return SizedBox(
        height: 260,
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(
            text,
            style: style.copyWith(
              fontFamily: mongolFont,
              fontWeight: FontWeight.w400,
              fontSize: size * 0.6,
            ),
          ),
        ),
      );
    }

    return Text(text, style: style);
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Material(
      color: selected ? p.ink : p.sunken,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          child: Text(
            label,
            style: Txt.ui(p)
                .copyWith(fontSize: 14, color: selected ? p.background : p.ink),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String label;
  final bool primary;
  final VoidCallback onTap;

  const _Button({
    required this.label,
    required this.onTap,
    this.primary = false,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Material(
      color: primary ? p.hand : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
          decoration: primary
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: p.line, width: 1.5),
                ),
          child: Text(
            label,
            style: Txt.ui(p).copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primary ? const Color(0xFF1A1300) : p.ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String body;
  const _SectionTitle(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 680),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Txt.h2(p).copyWith(fontSize: 34)),
          const SizedBox(height: 10),
          Inline(body, style: Txt.lead(p).copyWith(fontSize: 17.5)),
        ],
      ),
    );
  }
}

/// The same instant described in every bundled localization.
class _Languages extends StatelessWidget {
  const _Languages();

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final bool narrow = MediaQuery.sizeOf(context).width < 760;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "One moment, sixteen languages",
          "Below is the start of the current hour, as each bundled "
              "localization describes it. Grammar comes with the language: "
              "Russian and Polish plurals, Mongolian suffixes, Arabic dual "
              "forms.",
        ),
        const SizedBox(height: 28),
        LiveBuilder(
          builder: (context) {
            final DateTime hour = DateTime.now().startOfHour();
            final TextStyle code = Txt.mono(
              p,
              size: 13,
            ).copyWith(color: p.faint);
            final TextStyle value = Txt.mono(p, size: 14.5).copyWith(
              color: p.output,
              fontWeight: FontWeight.w600,
              height: 1.4,
            );

            Widget cell(String text, {double size = 14.5}) {
              if (containsMongolian(text)) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(
                      text,
                      style: value.copyWith(
                        fontFamily: mongolFont,
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                );
              }
              return Text(text, style: value.copyWith(fontSize: size));
            }

            final List<Widget> rows = [];
            for (final l in supportedLocales) {
              final MomentLocalization loc = MomentLocalizations.byLocale(
                l.code,
                strict: true,
              )!;
              final Moment m = hour.toMoment(localization: loc);
              // Set sideways in a horizontal label, bichig would read wrong
              final String name = containsMongolian(loc.endonym)
                  ? l.name
                  : loc.endonym;
              final List<Widget> values = [
                cell(m.fromNow()),
                cell(m.calendar()),
                cell(m.format("LL")),
              ];

              rows.add(
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: p.line)),
                  ),
                  child: narrow
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${l.code}  $name", style: code),
                            const SizedBox(height: 4),
                            Wrap(spacing: 18, runSpacing: 4, children: values),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: Txt.ui(p).copyWith(
                                      fontFamilyFallback: const [
                                        monoFont,
                                        mongolFont,
                                      ],
                                    ),
                                  ),
                                  Text(l.code, style: code),
                                ],
                              ),
                            ),
                            for (final v in values)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: v,
                                ),
                              ),
                          ],
                        ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!narrow)
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: p.line, width: 1.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 200),
                        for (final h in [
                          "fromNow()",
                          "calendar()",
                          'format("LL")',
                        ])
                          Expanded(child: Text(h, style: code)),
                      ],
                    ),
                  ),
                ...rows,
              ],
            );
          },
        ),
      ],
    );
  }
}

class _Features extends StatelessWidget {
  const _Features();

  @override
  Widget build(BuildContext context) {
    final bool wide = MediaQuery.sizeOf(context).width >= 1000;

    final List<({String title, String body, Live code})> items = [
      (
        title: "Relative time",
        body:
            "Say how long ago something happened, the way a person "
            "would. [Relative durations](/duration)",
        code: Live([
          c("final posted = Moment.now() - Duration(minutes: 42);"),
          l("posted.fromNow()", () {
            final posted = Moment.now() - const Duration(minutes: 42);
            return posted.fromNow();
          }),
          l("posted.fromNow(form: Abbreviation.semi)", () {
            final posted = Moment.now() - const Duration(minutes: 42);
            return posted.fromNow(form: Abbreviation.semi);
          }),
        ]),
      ),
      (
        title: "Exact durations",
        body:
            "Countdowns and timers, with the units you choose. "
            "[Precise durations](/duration/precise)",
        code: Live(tick: false, [
          c("const left = Duration(days: 3, hours: 4, minutes: 5);"),
          l("left.toDurationString()", () {
            const left = Duration(days: 3, hours: 4, minutes: 5);
            return left.toDurationString();
          }),
          l("left.toDurationString(format: DurationFormat.all)", () {
            const left = Duration(days: 3, hours: 4, minutes: 5);
            return left.toDurationString(format: DurationFormat.all);
          }),
        ]),
      ),
      (
        title: "Calendar days",
        body:
            "Today, yesterday, last Friday: named by distance from now. "
            "[Calendar](/calendar)",
        code: Live([
          l("Moment.now().calendar()", () => Moment.now().calendar()),
          l(
            "Moment.now().subtract(Duration(days: 1)).calendar()",
            () => Moment.now().subtract(const Duration(days: 1)).calendar(),
          ),
          l(
            "Moment.now().lastFriday().toMoment().calendar()",
            () => Moment.now().lastFriday().toMoment().calendar(),
          ),
        ]),
      ),
      (
        title: "Time ranges",
        body:
            "This month, last week, a custom span: page through them and "
            "save them as strings. [Time ranges](/time-range)",
        code: Live([
          c("final month = TimeRange.thisMonth();"),
          l("month.format()", () => TimeRange.thisMonth().format()),
          l("month.last.format()", () => TimeRange.thisMonth().last.format()),
          l(
            "month.contains(DateTime.now())",
            () => TimeRange.thisMonth().contains(DateTime.now()),
          ),
        ]),
      ),
      (
        title: "DateTime helpers",
        body:
            "Start and end of any unit, the next Monday, same-day checks. "
            "They work on plain `DateTime` too. "
            "[Extensions](/extension)",
        code: Live([
          c("final now = DateTime.now();"),
          l("now.startOfIsoWeek()", () => DateTime.now().startOfIsoWeek()),
          l("now.nextMonday()", () => DateTime.now().nextMonday()),
          l(
            "now.isAtSameDayAs(now.toUtc())",
            () => DateTime.now().isAtSameDayAs(DateTime.now().toUtc()),
          ),
        ]),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "What it does",
          "Every example on this site is real Dart, running in your browser "
              "right now. Copy it as it is.",
        ),
        const SizedBox(height: 20),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: wide
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 330,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18, right: 40),
                          child: _FeatureText(item.title, item.body),
                        ),
                      ),
                      Expanded(child: LiveView(item.code)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _FeatureText(item.title, item.body),
                      LiveView(item.code),
                    ],
                  ),
          ),
      ],
    );
  }
}

class _FeatureText extends StatelessWidget {
  final String title;
  final String body;
  const _FeatureText(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Txt.h3(p).copyWith(fontSize: 21)),
        const SizedBox(height: 6),
        Inline(body, style: Txt.body(p).copyWith(color: p.muted)),
      ],
    );
  }
}

class _Install extends StatelessWidget {
  const _Install();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle(
          "Install",
          "Works in Dart and Flutter, on every platform. "
              "[Read the getting started guide](/getting-started).",
        ),
        const SizedBox(height: 14),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680),
          child: const CodeView(
            Code(
              "dart pub add moment_dart\n\n# in a Flutter app\nflutter pub add moment_dart",
              lang: "sh",
            ),
          ),
        ),
      ],
    );
  }
}
