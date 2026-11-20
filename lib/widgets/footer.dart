import 'package:material_ui/material_ui.dart';

import '../docs/state.dart';
import '../theme.dart';
import 'inline.dart';
import 'shell.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final TextStyle style = Txt.small(p).copyWith(fontSize: 13.5);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: p.line)),
      ),
      child: Wrap(
        spacing: 28,
        runSpacing: 10,
        children: [
          Inline(
            "moment_dart $packageVersion is MIT licensed. "
            "[Source on GitHub]($githubUrl), [package on pub.dev]($pubUrl), "
            "[API reference]($apiUrl).",
            style: style,
          ),
          Inline(
            "Examples on this site run in your browser, in ${localOffset()}. "
            "Docs for 5.x and earlier are on the "
            "[archive-pre-v6](https://github.com/sadespresso/moment_dart_docs/tree/archive-pre-v6) "
            "branch.",
            style: style,
          ),
        ],
      ),
    );
  }
}
