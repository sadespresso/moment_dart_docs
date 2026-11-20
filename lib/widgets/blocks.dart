import 'package:material_ui/material_ui.dart';

import '../docs/model.dart';
import '../docs/state.dart';
import '../theme.dart';
import 'code_view.dart';
import 'inline.dart';

class BlockView extends StatelessWidget {
  final Block block;

  /// Keys of H2/H3 blocks, so the outline and search can scroll to them.
  final Map<Block, GlobalKey> anchors;

  const BlockView(this.block, {super.key, this.anchors = const {}});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return switch (block) {
      H2 b => Padding(
        key: anchors[b],
        padding: const EdgeInsets.only(top: 40, bottom: 10),
        child: Inline(b.text, style: Txt.h2(p)),
      ),
      H3 b => Padding(
        key: anchors[b],
        padding: const EdgeInsets.only(top: 26, bottom: 6),
        child: Inline(b.text, style: Txt.h3(p)),
      ),
      P b => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Inline(b.text),
      ),
      Bullets b => _Bullets(b),
      Code b => CodeView(b),
      Live b => LiveView(b),
      Note b => _NoteView(b),
      TableBlock b => _TableView(b),
      Embed b => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Builder(builder: b.builder),
      ),
    };
  }
}

class _Bullets extends StatelessWidget {
  final Bullets block;
  const _Bullets(this.block);

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (int i, String item) in block.items.indexed)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 26,
                    child: block.ordered
                        ? Text(
                            "${i + 1}.",
                            style: Txt.body(p).copyWith(color: p.muted),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 11, left: 4),
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: p.hand,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                  ),
                  Expanded(child: Inline(item)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NoteView extends StatelessWidget {
  final Note block;
  const _NoteView(this.block);

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final (Color color, IconData icon) = switch (block.kind) {
      NoteKind.tip => (p.tip, Icons.lightbulb_outline_rounded),
      NoteKind.info => (p.link, Icons.info_outline_rounded),
      NoteKind.warning => (p.warning, Icons.warning_amber_rounded),
    };

    // A one-sided border can't take a border radius, so the clip rounds it.
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 5, 18, 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.07),
            border: Border(left: BorderSide(color: color, width: 3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, right: 12),
                child: Icon(icon, size: 19, color: color),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [for (final b in block.children) BlockView(b)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TableView extends StatelessWidget {
  final TableBlock block;
  const _TableView(this.block);

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final bool live = block.rows.any((r) => r.any((c) => c is Function));

    Widget table(BuildContext context) {
      final TextStyle cell = Txt.body(p).copyWith(fontSize: 15, height: 1.45);
      final TextStyle mono = Txt.mono(p, size: 13.5).copyWith(height: 1.45);

      Widget cellView(int column, Object value) {
        if (value is Object? Function()) {
          String text;
          bool failed = false;
          try {
            text = describe(value());
          } catch (e) {
            text = "throws ${describeError(e)}";
            failed = true;
          }
          final TextStyle out = mono.copyWith(
            color: failed ? p.warning : p.output,
            fontWeight: FontWeight.w600,
          );
          if (containsMongolian(text)) {
            return Align(
              alignment: Alignment.topLeft,
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  text,
                  style: out.copyWith(fontFamily: mongolFont, fontSize: 16),
                ),
              ),
            );
          }
          return Text(text, style: out);
        }
        final String text = value as String;
        if (block.monoColumns.contains(column)) {
          return Text(text, style: mono);
        }
        return Inline(text, style: cell);
      }

      return Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        defaultVerticalAlignment: TableCellVerticalAlignment.top,
        border: TableBorder(horizontalInside: BorderSide(color: p.line)),
        children: [
          TableRow(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: p.line, width: 1.5)),
            ),
            children: [
              for (final h in block.header)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 28, 8),
                  child: Text(
                    h,
                    style: Txt.ui(p)
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
            ],
          ),
          for (final row in block.rows)
            TableRow(
              children: [
                for (final (int i, Object v) in row.indexed)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 9, 28, 9),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 380),
                      child: cellView(i, v),
                    ),
                  ),
              ],
            ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: live ? LiveBuilder(builder: table) : table(context),
      ),
    );
  }
}
