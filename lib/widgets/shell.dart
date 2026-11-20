import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../docs/registry.dart';
import '../docs/state.dart';
import '../theme.dart';
import 'search.dart';

const String packageVersion = "6.0.0";
const String githubUrl = "https://github.com/sadespresso/moment_dart";
const String pubUrl = "https://pub.dev/packages/moment_dart";
const String apiUrl =
    "https://pub.dev/documentation/moment_dart/latest/moment_dart/";

class OpenSearchIntent extends Intent {
  const OpenSearchIntent();
}

/// Header, sidebar (or drawer on narrow screens) and the page body.
class AppShell extends StatelessWidget {
  final String currentPath;
  final Widget child;
  final bool sidebar;

  const AppShell({
    super.key,
    required this.currentPath,
    required this.child,
    this.sidebar = true,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final bool narrow = MediaQuery.sizeOf(context).width < Breakpoints.drawer;

    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.keyK, meta: true):
            OpenSearchIntent(),
        SingleActivator(LogicalKeyboardKey.keyK, control: true):
            OpenSearchIntent(),
        SingleActivator(LogicalKeyboardKey.slash): OpenSearchIntent(),
      },
      child: Actions(
        actions: {
          OpenSearchIntent: CallbackAction<OpenSearchIntent>(
            onInvoke: (_) => showSearchPalette(context),
          ),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
            backgroundColor: p.background,
            drawer: narrow
                ? Drawer(
                    backgroundColor: p.background,
                    shape: const RoundedRectangleBorder(),
                    child: SafeArea(
                      child: Sidebar(currentPath: currentPath, inDrawer: true),
                    ),
                  )
                : null,
            body: Column(
              children: [
                Header(narrow: narrow, showMenu: narrow),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (sidebar && !narrow)
                        SizedBox(
                          width: 270,
                          child: Sidebar(currentPath: currentPath),
                        ),
                      Expanded(child: child),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final bool narrow;
  final bool showMenu;

  const Header({super.key, required this.narrow, required this.showMenu});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return Container(
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: narrow ? 8 : 24),
      decoration: BoxDecoration(
        color: p.background,
        border: Border(bottom: BorderSide(color: p.line)),
      ),
      child: Row(
        children: [
          if (showMenu)
            IconButton(
              tooltip: "Menu",
              icon: Icon(Icons.menu_rounded, color: p.ink),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          const Brand(),
          SizedBox(width: narrow ? 4 : 20),
          if (!narrow)
            const Expanded(child: SearchButton())
          else
            const Spacer(),
          if (narrow)
            IconButton(
              tooltip: "Search",
              icon: Icon(Icons.search_rounded, color: p.ink),
              onPressed: () => showSearchPalette(context),
            ),
          const SizedBox(width: 8),
          LocalePicker(compact: narrow),
          const SizedBox(width: 4),
          const ThemeToggle(),
          if (!narrow) ...[
            _HeaderLink(label: "pub.dev", url: pubUrl),
            _HeaderLink(label: "GitHub", url: githubUrl),
          ],
        ],
      ),
    );
  }
}

class Brand extends StatelessWidget {
  const Brand({super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final bool compact = MediaQuery.sizeOf(context).width < 520;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go("/"),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(size: const Size(26, 26), painter: DialMark(p)),
            const SizedBox(width: 10),
            Text(
              "moment_dart",
              style: TextStyle(
                fontFamily: displayFont,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                letterSpacing: -0.3,
                color: p.ink,
              ),
            ),
            if (!compact) const SizedBox(width: 8),
            if (!compact)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: p.line),
                ),
                child: Text(
                  packageVersion,
                  style: Txt.mono(
                    p,
                    size: 12,
                  ).copyWith(color: p.muted, height: 1.3),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// The logo: a dial whose hands show the reader's current time.
class DialMark extends CustomPainter {
  final Palette p;
  final DateTime? time;
  DialMark(this.p, [this.time]);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = size.width / 2;
    canvas.drawCircle(c, r, Paint()..color = p.ink);
    final DateTime t = time ?? DateTime(2000, 1, 1, 10, 9);
    final Paint hand = Paint()
      ..strokeCap = StrokeCap.round
      ..color = p.hand;
    final double hourAngle =
        ((t.hour % 12) + t.minute / 60) / 12 * 2 * 3.141592653589793;
    final double minuteAngle = t.minute / 60 * 2 * 3.141592653589793;
    Offset at(double angle, double len) =>
        c + Offset.fromDirection(angle - 3.141592653589793 / 2, len);
    canvas.drawLine(c, at(hourAngle, r * 0.48), hand..strokeWidth = r * 0.2);
    canvas.drawLine(
      c,
      at(minuteAngle, r * 0.72),
      Paint()
        ..strokeCap = StrokeCap.round
        ..strokeWidth = r * 0.13
        ..color = p.background,
    );
  }

  @override
  bool shouldRepaint(DialMark old) => old.p != p || old.time != time;
}

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Material(
          color: p.surface,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => showSearchPalette(context),
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: p.line),
              ),
              child: Row(
                children: [
                  Icon(Icons.search_rounded, size: 18, color: p.faint),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Search the docs",
                      style: Txt.ui(
                        p,
                      ).copyWith(color: p.faint, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Text(
                    _isMac(context) ? "⌘ K" : "Ctrl K",
                    style: Txt.mono(p, size: 12).copyWith(color: p.faint),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool _isMac(BuildContext context) {
  final TargetPlatform platform = Theme.of(context).platform;
  return platform == TargetPlatform.macOS || platform == TargetPlatform.iOS;
}

class LocalePicker extends StatelessWidget {
  final bool compact;
  const LocalePicker({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return ValueListenableBuilder(
      valueListenable: localeState,
      builder: (context, code, _) => PopupMenuButton<String>(
        tooltip: "Language of the live examples",
        initialValue: code,
        color: p.surface,
        constraints: const BoxConstraints(minWidth: 260, maxHeight: 520),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: p.line),
        ),
        onSelected: (value) => localeState.locale = value,
        itemBuilder: (context) => [
          for (final l in supportedLocales)
            PopupMenuItem(
              value: l.code,
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: 104,
                    child: Text(
                      l.code,
                      style: Txt.mono(p, size: 13).copyWith(
                        color: l.code == code ? p.output : p.muted,
                        fontWeight: l.code == code ? FontWeight.w600 : null,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      l.name,
                      style: Txt.ui(p).copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
        ],
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: p.line),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!compact) ...[
                Icon(Icons.translate_rounded, size: 16, color: p.muted),
                const SizedBox(width: 7),
              ],
              Text(
                compact ? code.split("_").first : code,
                style: Txt.mono(p, size: 13).copyWith(height: 1.2),
              ),
              if (!compact)
                Icon(Icons.expand_more_rounded, size: 18, color: p.faint),
            ],
          ),
        ),
      ),
    );
  }
}

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    final bool dark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      tooltip: dark ? "Use light theme" : "Use dark theme",
      icon: Icon(
        dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
        size: 20,
        color: p.muted,
      ),
      onPressed: () =>
          themeMode.value = dark ? ThemeMode.light : ThemeMode.dark,
    );
  }
}

class _HeaderLink extends StatelessWidget {
  final String label;
  final String url;
  const _HeaderLink({required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;
    return TextButton(
      onPressed: () => launchUrl(Uri.parse(url)),
      style: TextButton.styleFrom(
        foregroundColor: p.muted,
        textStyle: Txt.ui(p),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child: Text(label),
    );
  }
}

class Sidebar extends StatelessWidget {
  final String currentPath;
  final bool inDrawer;

  const Sidebar({super.key, required this.currentPath, this.inDrawer = false});

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return Container(
      decoration: BoxDecoration(
        border: inDrawer ? null : Border(right: BorderSide(color: p.line)),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
        children: [
          if (inDrawer) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 0, 16),
              child: Align(alignment: Alignment.centerLeft, child: Brand()),
            ),
          ],
          for (final group in docGroups) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 6),
              child: Text(
                group,
                style: Txt.small(p).copyWith(
                  fontWeight: FontWeight.w600,
                  color: p.faint,
                  fontSize: 13,
                ),
              ),
            ),
            for (final page in docPages.where((page) => page.group == group))
              _SidebarItem(
                title: page.title,
                path: page.path,
                active: page.path == currentPath,
                inDrawer: inDrawer,
              ),
          ],
          if (inDrawer) ...[
            const SizedBox(height: 20),
            _SidebarItem(title: "pub.dev", path: pubUrl, inDrawer: true),
            _SidebarItem(title: "GitHub", path: githubUrl, inDrawer: true),
          ],
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final String path;
  final bool active;
  final bool inDrawer;

  const _SidebarItem({
    required this.title,
    required this.path,
    this.active = false,
    this.inDrawer = false,
  });

  @override
  Widget build(BuildContext context) {
    final Palette p = context.palette;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Material(
        color: active ? p.surface : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          hoverColor: p.sunken.withValues(alpha: 0.6),
          onTap: () {
            if (inDrawer) Navigator.of(context).pop();
            if (path.startsWith("/")) {
              context.go(path);
            } else {
              launchUrl(Uri.parse(path));
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: active
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: p.line),
                  )
                : null,
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  width: 3,
                  height: 16,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: active ? p.hand : Colors.transparent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: Txt.ui(p).copyWith(
                      color: active ? p.ink : p.muted,
                      fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
