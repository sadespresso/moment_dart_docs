import 'package:material_ui/material_ui.dart';
import 'package:moment_dart/moment_dart.dart';

import '../docs/model.dart';
import '../docs/state.dart';
import '../theme.dart';
import 'common.dart';

enum _Kind { year, month, isoWeek, localWeek, day, hour }

const Map<_Kind, (String label, String code)> _kinds = {
  _Kind.year: ("Year", "TimeRange.thisYear()"),
  _Kind.month: ("Month", "TimeRange.thisMonth()"),
  _Kind.isoWeek: ("ISO week", "TimeRange.thisIsoWeek()"),
  _Kind.localWeek: ("Local week", "TimeRange.thisLocalWeek()"),
  _Kind.day: ("Day", "TimeRange.today()"),
  _Kind.hour: ("Hour", "TimeRange.thisHour()"),
};

TimeRange _current(_Kind kind) => switch (kind) {
  _Kind.year => TimeRange.thisYear(),
  _Kind.month => TimeRange.thisMonth(),
  _Kind.isoWeek => TimeRange.thisIsoWeek(),
  _Kind.localWeek => TimeRange.thisLocalWeek(),
  _Kind.day => TimeRange.today(),
  _Kind.hour => TimeRange.thisHour(),
};

class RangePlayground extends StatefulWidget {
  const RangePlayground({super.key});

  @override
  State<RangePlayground> createState() => _RangePlaygroundState();
}

class _RangePlaygroundState extends State<RangePlayground> {
  _Kind _kind = _Kind.month;
  int _offset = 0;

  TimeRange _range() {
    TimeRange range = _current(_kind);
    for (int i = 0; i < _offset.abs(); i++) {
      final PageableRange pageable = range as PageableRange;
      range = _offset > 0 ? pageable.next : pageable.last;
    }
    return range;
  }

  String _code() {
    final String base = _kinds[_kind]!.$2;
    if (_offset == 0) return base;
    final String step = _offset > 0 ? ".next" : ".last";
    return "$base${step * _offset.abs()}";
  }

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return Panel(
      children: [
        const FieldLabel("Range"),
        Choice<_Kind>(
          options: [for (final e in _kinds.entries) (e.key, e.value.$1)],
          value: _kind,
          onChanged: (k) => setState(() {
            _kind = k;
            _offset = 0;
          }),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            OutlinedButton.icon(
              onPressed: () => setState(() => _offset--),
              icon: const Icon(Icons.chevron_left_rounded, size: 18),
              label: const Text("last"),
            ),
            const SizedBox(width: 8),
            OutlinedButton(
              onPressed: _offset == 0
                  ? null
                  : () => setState(() => _offset = 0),
              child: const Text("Current"),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              onPressed: () => setState(() => _offset++),
              icon: const Icon(Icons.chevron_right_rounded, size: 18),
              iconAlignment: IconAlignment.end,
              label: const Text("next"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        LiveBuilder(
          tick: false,
          builder: (context) {
            final TimeRange range = _range();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  _code(),
                  style: Txt.mono(p, size: 14).copyWith(color: p.muted),
                ),
                const SizedBox(height: 6),
                Text(
                  range.format(),
                  style: TextStyle(
                    fontFamily: displayFont,
                    fontFamilyFallback: const [monoFont, mongolFont],
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    height: 1.25,
                    color: p.ink,
                  ),
                ),
                const SizedBox(height: 12),
                OutputLine(".from", describe(range.from)),
                OutputLine(".to", describe(range.to)),
                OutputLine(".duration", describe(range.duration)),
                OutputLine(
                  ".contains(DateTime.now())",
                  describe(range.contains(DateTime.now())),
                ),
                OutputLine(".encode()", range.encode()),
                OutputLine(".encodeShort()", range.encodeShort()),
              ],
            );
          },
        ),
      ],
    );
  }
}
