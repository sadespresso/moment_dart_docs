import 'package:material_ui/material_ui.dart';

import '../theme.dart';

/// The bordered panel each playground sits in.
class Panel extends StatelessWidget {
  final List<Widget> children;
  const Panel({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final bool narrow = MediaQuery.sizeOf(context).width < 600;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(narrow ? 16 : 24),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String text;
  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Txt.small(
          p,
        ).copyWith(fontWeight: FontWeight.w600, color: p.muted, fontSize: 13.5),
      ),
    );
  }
}

/// A row of mutually exclusive options.
class Choice<T> extends StatelessWidget {
  final List<(T, String)> options;
  final T value;
  final ValueChanged<T> onChanged;
  final bool mono;

  const Choice({
    super.key,
    required this.options,
    required this.value,
    required this.onChanged,
    this.mono = false,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final (T v, String label) in options)
          Material(
            color: v == value ? p.ink : p.sunken,
            borderRadius: BorderRadius.circular(8),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => onChanged(v),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 6,
                ),
                child: Text(
                  label,
                  style: (mono ? Txt.mono(p, size: 13) : Txt.ui(p)).copyWith(
                    fontSize: mono ? 13 : 14,
                    height: 1.3,
                    color: v == value ? p.background : p.ink,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class Toggle extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const Toggle({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 34,
              height: 20,
              child: FittedBox(
                child: Switch(
                  value: value,
                  onChanged: onChanged,
                  activeThumbColor: p.background,
                  activeTrackColor: p.hand,
                  inactiveThumbColor: p.faint,
                  inactiveTrackColor: p.sunken,
                  trackOutlineColor: WidgetStatePropertyAll(p.line),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(label, style: Txt.mono(p, size: 13.5)),
          ],
        ),
      ),
    );
  }
}

class OutputLine extends StatelessWidget {
  final String label;
  final String value;
  const OutputLine(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 14,
        runSpacing: 2,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 150),
            child: Text(
              label,
              style: Txt.mono(p, size: 13.5).copyWith(color: p.faint),
            ),
          ),
          Text(
            value,
            style: Txt.mono(
              p,
              size: 15,
            ).copyWith(color: p.output, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

InputDecoration fieldDecoration(Palette p, {String? hint}) => InputDecoration(
  isDense: true,
  hintText: hint,
  hintStyle: Txt.mono(p, size: 14).copyWith(color: p.faint),
  filled: true,
  fillColor: p.background,
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(9),
    borderSide: BorderSide(color: p.line),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(9),
    borderSide: BorderSide(color: p.hand, width: 1.6),
  ),
);
