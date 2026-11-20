import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:moment_dart_docs/docs/registry.dart';
import 'package:moment_dart_docs/main.dart';

Future<void> _loadFont(String family, List<String> files) async {
  final FontLoader loader = FontLoader(family);
  for (final f in files) {
    final bytes = File("assets/fonts/$f").readAsBytesSync();
    loader.addFont(Future.value(ByteData.view(bytes.buffer)));
  }
  await loader.load();
}

void main() {
  setUpAll(() async {
    await _loadFont("Bricolage Text", [
      "BricolageText-Regular.ttf",
      "BricolageText-Medium.ttf",
      "BricolageText-SemiBold.ttf",
    ]);
    await _loadFont("Bricolage Display", [
      "BricolageDisplay-Bold.ttf",
      "BricolageDisplay-ExtraBold.ttf",
    ]);
    await _loadFont("Cascadia Code", [
      "CascadiaCode-Regular.ttf",
      "CascadiaCode-SemiBold.ttf",
    ]);
    await _loadFont("Noto Sans Mongolian", ["NotoSansMongolian-Regular.ttf"]);
  });

  final List<String> paths = ["/", ...docPages.map((p) => p.path)];
  const List<Size> sizes = [Size(1440, 900), Size(1024, 768), Size(390, 844)];

  for (final size in sizes) {
    for (final path in paths) {
      testWidgets("$path renders at ${size.width.toInt()}px", (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        router.go(path);
        await tester.pumpWidget(const DocsApp());
        await tester.pump(const Duration(milliseconds: 50));
        await tester.pump(const Duration(seconds: 1));

        expect(tester.takeException(), isNull);

        await tester.pumpWidget(const SizedBox());
        await tester.pump(const Duration(seconds: 2));
      });
    }
  }
}
