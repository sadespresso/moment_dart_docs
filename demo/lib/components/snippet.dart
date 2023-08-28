import 'package:flutter/material.dart';
import 'package:moment_dart_demo/logic/syntax_highlight.dart';

class SnippetEntry {
  final String text;
  final String description;

  const SnippetEntry(this.text, this.description);
}

class Snippet extends StatelessWidget {
  final SnippetEntry entry;

  const Snippet({Key? key, required this.entry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Text.rich(SyntaxHighlighter().highlight(entry.text)),
          // Text(entry.text, style: Theme.of(context).textTheme.bodyText2),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            "// ${entry.description}",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color
                    ?.withAlpha(0x99)),
          ),
        ),
      ],
    );
  }
}
