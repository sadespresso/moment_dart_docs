import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import 'docs/registry.dart';
import 'docs/state.dart';
import 'theme.dart';
import 'widgets/doc_page_view.dart';
import 'widgets/landing.dart';
import 'widgets/not_found.dart';
import 'widgets/shell.dart';

void main() {
  final String fragment = Uri.base.fragment;
  _initialFragment = fragment.isEmpty ? null : fragment;
  usePathUrlStrategy();
  runApp(const DocsApp());
}

// The path URL strategy drops the #fragment of the URL the site was opened
// with, so it's read once here and handed to the first page.
String? _initialFragment;

String? _takeFragment(GoRouterState state) {
  if (state.uri.fragment.isNotEmpty) return state.uri.fragment;
  final String? f = _initialFragment;
  _initialFragment = null;
  final String opened = Uri.base.path.replaceFirst(RegExp(r"(?<=.)/$"), "");
  return state.uri.path == opened ? f : null;
}

final RegExp _versionPrefix = RegExp(r"^/\d+\.\d+\.\d+(/|$)");

Page<void> _page(GoRouterState state, Widget child) =>
    NoTransitionPage(key: state.pageKey, child: child);

final GoRouter router = GoRouter(
  redirect: (context, state) {
    final String path = state.uri.path;
    if (path == "/demo" || path.startsWith("/demo/")) return "/playground";
    // Old Docusaurus links to versioned docs, e.g. /4.1.0/formatting
    if (_versionPrefix.hasMatch(path)) {
      final String rest = path.replaceFirst(_versionPrefix, "/");
      return rest == "/" ? "/getting-started" : rest;
    }
    if (path.length > 1 && path.endsWith("/")) {
      return path.substring(0, path.length - 1);
    }
    return null;
  },
  errorPageBuilder: (context, state) => _page(
    state,
    AppShell(currentPath: state.uri.path, child: const NotFound()),
  ),
  routes: [
    GoRoute(
      path: "/",
      pageBuilder: (context, state) => _page(
        state,
        const AppShell(currentPath: "/", sidebar: false, child: Landing()),
      ),
    ),
    for (final page in docPages)
      GoRoute(
        path: page.path,
        pageBuilder: (context, state) => _page(
          state,
          AppShell(
            currentPath: page.path,
            child: DocPageView(page: page, fragment: _takeFragment(state)),
          ),
        ),
      ),
  ],
);

class DocsApp extends StatelessWidget {
  const DocsApp({super.key});

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: themeMode,
    builder: (context, mode, _) => MaterialApp.router(
      title: "moment_dart",
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: mode,
      routerConfig: router,
    ),
  );
}
