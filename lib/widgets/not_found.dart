import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../theme.dart';
import 'search.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final String path = GoRouterState.of(context).uri.path;

    return Title(
      title: "Page not found | moment_dart",
      color: p.ink,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(48, 64, 48, 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("No page at $path", style: Txt.h1(p).copyWith(fontSize: 36)),
            const SizedBox(height: 14),
            Text(
              "It may have moved in the 6.0 rewrite of these docs. "
              "Search for what you were looking for, or start from the top.",
              style: Txt.lead(p),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 12,
              children: [
                FilledButton(
                  onPressed: () => showSearchPalette(context),
                  child: const Text("Search the docs"),
                ),
                OutlinedButton(
                  onPressed: () => context.go("/getting-started"),
                  child: const Text("Go to getting started"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
