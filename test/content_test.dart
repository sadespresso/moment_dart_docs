import 'package:flutter_test/flutter_test.dart';
import 'package:moment_dart_docs/docs/model.dart';
import 'package:moment_dart_docs/docs/registry.dart';

void main() {
  test("every page is in a sidebar group and has a unique path", () {
    final Set<String> paths = {};
    for (final page in docPages) {
      expect(docGroups, contains(page.group), reason: page.path);
      expect(paths.add(page.path), true, reason: "duplicate ${page.path}");
      expect(page.summary, isNot("TODO"), reason: page.path);
    }
  });

  for (final page in docPages) {
    test("live examples on ${page.path} evaluate", () {
      final List<String> problems = [];

      void check(List<Block> blocks) {
        for (final b in blocks) {
          switch (b) {
            case Live live:
              for (final line in live.lines) {
                if (line.eval == null) continue;
                try {
                  line.eval!();
                  if (line.throws) {
                    problems.add("expected a throw: ${line.code}");
                  }
                } catch (e) {
                  if (!line.throws) problems.add("${line.code}\n  threw $e");
                }
              }
            case TableBlock table:
              for (final row in table.rows) {
                for (final cell in row) {
                  if (cell is Object? Function()) {
                    try {
                      cell();
                    } catch (e) {
                      problems.add("table cell threw $e");
                    }
                  }
                }
              }
            case Note note:
              check(note.children);
            default:
              break;
          }
        }
      }

      check(page.blocks());
      expect(problems, isEmpty, reason: problems.join("\n"));
    });
  }
}
