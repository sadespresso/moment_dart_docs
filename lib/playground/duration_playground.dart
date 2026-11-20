import 'package:material_ui/material_ui.dart';
import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';
import '../docs/state.dart';
import '../theme.dart';
import '../widgets/code_view.dart';
import 'common.dart';

const List<(String, DurationFormat)> _formats = [
  ("auto", DurationFormat.auto),
  ("all", DurationFormat.all),
  ("ym", DurationFormat.ym),
  ("md", DurationFormat.md),
  ("wd", DurationFormat.wd),
  ("dh", DurationFormat.dh),
  ("hm", DurationFormat.hm),
  ("ms", DurationFormat.ms),
  ("s", DurationFormat.s),
];

class DurationPlayground extends StatefulWidget {
  const DurationPlayground({super.key});

  @override
  State<DurationPlayground> createState() => _DurationPlaygroundState();
}

class _DurationPlaygroundState extends State<DurationPlayground> {
  final Map<String, int> _parts = {
    "days": 1,
    "hours": 2,
    "minutes": 1,
    "seconds": 0,
  };
  bool _past = false;
  String _format = "auto";
  Abbreviation _form = Abbreviation.none;
  bool _omitZeros = true;
  bool _includeWeeks = false;
  bool _dropPrefixOrSuffix = false;
  bool _round = true;

  Duration get _duration => Duration(
    days: _parts["days"]!,
    hours: _parts["hours"]!,
    minutes: _parts["minutes"]!,
    seconds: _parts["seconds"]!,
  );

  Duration get _signed => _past ? -_duration : _duration;

  String _precise() => _signed.toDurationString(
    format: _formats.firstWhere((f) => f.$1 == _format).$2,
    form: _form,
    omitZeros: _omitZeros,
    includeWeeks: _includeWeeks,
    dropPrefixOrSuffix: _dropPrefixOrSuffix,
    round: _round,
  );

  String _relative() => Moment.now()
      .add(_signed)
      .fromNow(form: _form, dropPrefixOrSuffix: _dropPrefixOrSuffix);

  String _code() {
    final List<String> args = [
      if (_format != "auto") "format: DurationFormat.$_format",
      if (_form != Abbreviation.none) "form: Abbreviation.${_form.name}",
      if (!_omitZeros) "omitZeros: false",
      if (_includeWeeks) "includeWeeks: true",
      if (_dropPrefixOrSuffix) "dropPrefixOrSuffix: true",
      if (!_round) "round: false",
    ];
    final String parts = _parts.entries
        .where((e) => e.value != 0)
        .map((e) => "${e.key}: ${e.value}")
        .join(", ");
    final String duration = "${_past ? "-" : ""}const Duration($parts)";
    final String call = args.isEmpty
        ? ".toDurationString()"
        : ".toDurationString(\n  ${args.join(",\n  ")},\n)";
    return "($duration)$call";
  }

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return Panel(
      children: [
        const FieldLabel("Duration"),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final unit in _parts.keys)
              _Stepper(
                label: unit,
                value: _parts[unit]!,
                onChanged: (v) => setState(() => _parts[unit] = v),
              ),
          ],
        ),
        const SizedBox(height: 14),
        Choice<bool>(
          options: const [(false, "In the future"), (true, "In the past")],
          value: _past,
          onChanged: (v) => setState(() => _past = v),
        ),
        const SizedBox(height: 22),
        const FieldLabel("format"),
        Choice<String>(
          mono: true,
          options: [for (final f in _formats) (f.$1, f.$1)],
          value: _format,
          onChanged: (v) => setState(() => _format = v),
        ),
        const SizedBox(height: 16),
        const FieldLabel("form"),
        Choice<Abbreviation>(
          mono: true,
          options: [for (final a in Abbreviation.values) (a, a.name)],
          value: _form,
          onChanged: (v) => setState(() => _form = v),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 18,
          runSpacing: 4,
          children: [
            Toggle(
              label: "omitZeros",
              value: _omitZeros,
              onChanged: (v) => setState(() => _omitZeros = v),
            ),
            Toggle(
              label: "includeWeeks",
              value: _includeWeeks,
              onChanged: (v) => setState(() => _includeWeeks = v),
            ),
            Toggle(
              label: "dropPrefixOrSuffix",
              value: _dropPrefixOrSuffix,
              onChanged: (v) => setState(() => _dropPrefixOrSuffix = v),
            ),
            Toggle(
              label: "round",
              value: _round,
              onChanged: (v) => setState(() => _round = v),
            ),
          ],
        ),
        const SizedBox(height: 22),
        LiveBuilder(
          builder: (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _result(p, "toDurationString()", _precise()),
              _result(p, "fromNow()", _relative()),
            ],
          ),
        ),
        const SizedBox(height: 10),
        CodeView(Code(_code(), title: "The code for this")),
      ],
    );
  }

  Widget _result(Palette p, String label, String value) {
    final TextStyle out = Txt.mono(
      p,
      size: 17,
    ).copyWith(color: p.output, fontWeight: FontWeight.w600);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Txt.mono(p, size: 13).copyWith(color: p.faint)),
          if (containsMongolian(value))
            MongolianOutput(value, style: out)
          else
            Text(value.isEmpty ? "(empty)" : value, style: out),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const _Stepper({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    Widget button(IconData icon, int delta, String tip) => IconButton(
      tooltip: tip,
      visualDensity: VisualDensity.compact,
      iconSize: 18,
      color: p.muted,
      onPressed: value + delta < 0 ? null : () => onChanged(value + delta),
      icon: Icon(icon),
    );

    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: p.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: p.line),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 92,
            child: Text("$label: $value", style: Txt.mono(p, size: 14)),
          ),
          button(Icons.remove_rounded, -1, "One less"),
          button(Icons.add_rounded, 1, "One more"),
        ],
      ),
    );
  }
}
