import 'package:material_ui/material_ui.dart';
import 'package:moment_dart/moment_dart.dart';

import '../docs/state.dart';
import '../docs/model.dart';
import '../theme.dart';
import '../widgets/code_view.dart';
import 'common.dart';

const List<(String, List<String>)> _tokenGroups = [
  ("Year", ["YYYY", "YY", "gggg", "y", "NN"]),
  ("Month", ["MMMM", "MMM", "MM", "M", "Mo", "Q"]),
  ("Day", ["DD", "D", "Do", "DDD", "dddd", "ddd", "dd", "d"]),
  ("Week", ["w", "wo", "ww"]),
  ("Time", ["HH", "H", "hh", "h", "mm", "ss", "SSS", "A", "a", "Z"]),
  ("Localized", ["LT", "LTS", "L", "l", "LL", "ll", "LLL", "LLLL", "llll"]),
  ("Timestamp", ["X", "x"]),
];

class FormatPlayground extends StatefulWidget {
  const FormatPlayground({super.key});

  @override
  State<FormatPlayground> createState() => _FormatPlaygroundState();
}

class _FormatPlaygroundState extends State<FormatPlayground> {
  final TextEditingController _format = TextEditingController(
    text: "dddd, MMMM Do YYYY [at] h:mm:ss A",
  );
  final FocusNode _focus = FocusNode();
  DateTime? _fixed;
  bool _utc = false;
  bool _everyLanguage = false;

  @override
  void initState() {
    super.initState();
    _format.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _format.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _insert(String token) {
    final TextSelection sel = _format.selection;
    final String text = _format.text;
    final int start = sel.isValid ? sel.start : text.length;
    final int end = sel.isValid ? sel.end : text.length;
    final String next = text.replaceRange(start, end, token);
    _format.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: start + token.length),
    );
    _focus.requestFocus();
  }

  Future<void> _pickDate() async {
    final DateTime base = _fixed ?? DateTime.now();
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: base,
      firstDate: DateTime(1),
      lastDate: DateTime(9999, 12, 31),
    );
    if (date == null || !mounted) return;
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(base),
    );
    if (!mounted) return;
    setState(() {
      _fixed = DateTime(
        date.year,
        date.month,
        date.day,
        time?.hour ?? base.hour,
        time?.minute ?? base.minute,
      );
    });
  }

  DateTime _subject() {
    final DateTime d = _fixed ?? DateTime.now();
    return _utc ? d.toUtc() : d;
  }

  String _render(MomentLocalization? localization) {
    try {
      return _subject()
          .toMoment(localization: localization)
          .format(_format.text);
    } catch (e) {
      return "throws ${describeError(e)}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return Panel(
      children: [
        const FieldLabel("Format"),
        TextField(
          controller: _format,
          focusNode: _focus,
          style: Txt.mono(p, size: 16).copyWith(color: p.string),
          cursorColor: p.hand,
          decoration: fieldDecoration(p, hint: "Type a format, e.g. LLLL"),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Choice<bool>(
              options: const [(false, "Now"), (true, "A date I pick")],
              value: _fixed != null,
              onChanged: (fixed) {
                if (fixed) {
                  _pickDate();
                } else {
                  setState(() => _fixed = null);
                }
              },
            ),
            if (_fixed != null)
              TextButton(
                onPressed: _pickDate,
                child: Text(
                  _fixed!.format(payload: "LLL"),
                  style: Txt.mono(p, size: 13.5).copyWith(color: p.link),
                ),
              ),
            Toggle(
              label: "toUtc()",
              value: _utc,
              onChanged: (v) => setState(() => _utc = v),
            ),
          ],
        ),
        const SizedBox(height: 22),
        LiveBuilder(
          tick: _fixed == null,
          builder: (context) {
            final String out = _render(null);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (containsMongolian(out))
                  MongolianOutput(
                    out,
                    style: Txt.mono(p).copyWith(color: p.output),
                  )
                else
                  Text(
                    out.isEmpty ? " " : out,
                    style: TextStyle(
                      fontFamily: displayFont,
                      fontFamilyFallback: const [monoFont],
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      height: 1.2,
                      color: p.ink,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                const SizedBox(height: 4),
                Text(
                  "in ${localeState.value}",
                  style: Txt.small(p).copyWith(color: p.faint),
                ),
                if (_everyLanguage) ...[
                  const SizedBox(height: 16),
                  for (final l in supportedLocales)
                    _LocaleRow(
                      code: l.code,
                      value: _render(
                        MomentLocalizations.byLocale(l.code, strict: true),
                      ),
                    ),
                ],
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        Toggle(
          label: "Show every language",
          value: _everyLanguage,
          onChanged: (v) => setState(() => _everyLanguage = v),
        ),
        const SizedBox(height: 22),
        const FieldLabel("Insert a token"),
        for (final (String group, List<String> tokens) in _tokenGroups)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 92,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(group, style: Txt.small(p)),
                  ),
                ),
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final token in tokens)
                        _TokenChip(
                          token: token,
                          example: () => _subject().format(payload: token),
                          onTap: () => _insert(token),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 6),
        Text(
          "Wrap text in [square brackets] to keep it as it is.",
          style: Txt.small(p),
        ),
      ],
    );
  }
}

class _LocaleRow extends StatelessWidget {
  final String code;
  final String value;
  const _LocaleRow({required this.code, required this.value});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final TextStyle out = Txt.mono(
      p,
      size: 14.5,
    ).copyWith(color: p.output, fontWeight: FontWeight.w600);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: p.line)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              code,
              style: Txt.mono(p, size: 13).copyWith(color: p.faint),
            ),
          ),
          Expanded(
            child: containsMongolian(value)
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Text(
                        value,
                        style: out.copyWith(
                          fontFamily: mongolFont,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                : Text(value, style: out),
          ),
        ],
      ),
    );
  }
}

class _TokenChip extends StatelessWidget {
  final String token;
  final String Function() example;
  final VoidCallback onTap;

  const _TokenChip({
    required this.token,
    required this.example,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    String tip;
    try {
      tip = example();
    } catch (_) {
      tip = "";
    }
    return Tooltip(
      message: tip,
      waitDuration: const Duration(milliseconds: 250),
      child: Material(
        color: p.sunken,
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            child: Text(token, style: Txt.mono(p, size: 13.5)),
          ),
        ),
      ),
    );
  }
}
