import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:moment_dart_demo/components/header.dart';
import 'package:moment_dart_demo/components/section.dart';
import 'package:moment_dart_demo/components/snippet.dart';
import 'package:moment_dart_demo/logic/syntax_highlight.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Timer timer;
  int secondsElapsed = -1;

  String activeLocale = "en_US";

  final Map<String, MomentLocalization> locales =
      MomentLocalizations.locales.map((key, value) => MapEntry(key, value()));

  void updateLocale(String code) {
    setState(() {
      activeLocale = code;
    });
  }

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsElapsed++;
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SyntaxHighlighter().updateTheme(
        WidgetsBinding.instance.platformDispatcher.platformBrightness);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: _build(context),
        ),
      ),
    );
  }

  Widget _build(context) {
    const Widget divider = SizedBox(height: 12.0);

    Moment.setGlobalLocalization(MomentLocalizations.byLocale(activeLocale)!);

    final Moment now = Moment.now();

    final List<SnippetEntry?> formats = [
      SnippetEntry(
        "Moment.setGlobalLocalization(MomentLocalizations.byLocale(\"$activeLocale\")!);",
        now.localization.endonym,
      ),
      SnippetEntry(
        "final now = Moment.now();",
        "$now",
      ),
      SnippetEntry(
        r'now.format();',
        now.format(),
      ),
      SnippetEntry(
        r'now.format("YYYY MMMM Do - hh:mm:ssa");',
        now.format("YYYY MMMM Do - hh:mm:ssa"),
      ),
      SnippetEntry(
        r'now.format("LTS");',
        now.format("LTS"),
      ),
      SnippetEntry(
        r'now.format("dddd");',
        now.format("dddd"),
      ),
      SnippetEntry(
        r'now.format("MMM Do YY");',
        now.format("MMM Do YY"),
      ),
    ];

    final List<SnippetEntry?> relatives = [
      SnippetEntry(
        r"Moment(DateTime(2003,6,1)).fromNow(dropPrefixOrSuffix: true);",
        Moment(
          DateTime(2003, 6, 1),
        ).fromNow(dropPrefixOrSuffix: true),
      ),
      SnippetEntry(
        r"now.lastMonday().fromNow(form: Abbreviation.full);",
        now.lastMonday().fromNow(form: Abbreviation.full),
      ),
      SnippetEntry(
        r"Moment(DateTime(now.year,11,26)).fromNow(form: Abbreviation.full);",
        Moment(DateTime(now.year, 11, 26)).fromNow(form: Abbreviation.full),
      ),
    ];

    final List<SnippetEntry?> preciseDurations = [
      SnippetEntry(
        r"now.subtract(const Duration(minutes: 2, seconds: 47)).fromNowPrecise();",
        now.subtract(const Duration(minutes: 2, seconds: 47)).fromNowPrecise(),
      ),
      SnippetEntry(
        r"now.add(const Duration(days: 23)).fromNowPrecise(includeWeeks: true, form: Abbreviation.semi);",
        now
            .add(const Duration(days: 23))
            .fromNowPrecise(includeWeeks: true, form: Abbreviation.semi),
      ),
      SnippetEntry(
        r"Duration(microseconds: now.microsecondsSinceEpoch)"
        "\n"
        ".toDurationString(format: DurationFormat.all);",
        Duration(microseconds: now.microsecondsSinceEpoch)
            .toDurationString(format: DurationFormat.all),
      ),
      SnippetEntry(
        r"Duration(microseconds: now.microsecondsSinceEpoch)"
        "\n"
        ".toDurationString(format: DurationFormat.all, form: Abbreviation.semi);",
        Duration(microseconds: now.microsecondsSinceEpoch).toDurationString(
          format: DurationFormat.all,
          form: Abbreviation.semi,
        ),
      ),
      SnippetEntry(
        r"Duration(microseconds: now.microsecondsSinceEpoch)"
        "\n"
        ".toDurationString(format: DurationFormat.all, form: Abbreviation.full);",
        Duration(microseconds: now.microsecondsSinceEpoch).toDurationString(
          format: DurationFormat.all,
          form: Abbreviation.full,
        ),
      ),
    ];

    final List<SnippetEntry?> calendar = [
      SnippetEntry(
        r"now.subtract(const Duration(days: 10)).calendar();",
        now.subtract(const Duration(days: 10)).calendar(),
      ),
      SnippetEntry(
        r"now.subtract(const Duration(days: 6)).calendar();",
        now.subtract(const Duration(days: 6)).calendar(),
      ),
      SnippetEntry(
        r"now.subtract(const Duration(days: 3)).calendar();",
        now.subtract(const Duration(days: 3)).calendar(),
      ),
      SnippetEntry(
        r"now.subtract(const Duration(days: 1)).calendar();",
        now.subtract(const Duration(days: 1)).calendar(),
      ),
      SnippetEntry(
        r"now.calendar();",
        now.calendar(),
      ),
      SnippetEntry(
        r"now.add(const Duration(days: 1)).calendar();",
        now.add(const Duration(days: 1)).calendar(),
      ),
      SnippetEntry(
        r"now.add(const Duration(days: 3)).calendar();",
        now.add(const Duration(days: 3)).calendar(),
      ),
      SnippetEntry(
        r"now.add(const Duration(days: 10)).calendar();",
        now.add(const Duration(days: 10)).calendar(),
      ),
    ];

    final List<String> sorted = [...locales.keys]..sort();

    return Column(
      children: [
        const SizedBox(height: 16.0),
        Text(
          "Total of ${locales.length} localizations, sorted by language code",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontFamily: 'Cascadia Code',
              ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: sorted.map((e) {
            return ChoiceChip(
              avatar: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Text(
                    locales[e]!.languageCode,
                    style: Theme.of(context).textTheme.labelMedium,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
              label: Text(locales[e]!.languageNameInEnglish),
              selected: e == activeLocale,
              onSelected: (selected) => selected ? updateLocale(e) : null,
            );
          }).toList(),
        ),

        const SizedBox(height: 16.0),
        // Formats
        const Header(text: "Formats"),
        Section(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in formats)
                entry == null ? divider : Snippet(entry: entry),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Relative Time

        const Header(text: "Relative Time"),
        Section(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in relatives)
                entry == null ? divider : Snippet(entry: entry),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Precise duration
        const Header(text: "Precise duration"),
        Section(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in preciseDurations)
                entry == null ? divider : Snippet(entry: entry),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Calendar

        const Header(text: "Calendar"),
        Section(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final entry in calendar)
                entry == null ? divider : Snippet(entry: entry),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
