import 'package:flutter/material.dart';
import 'package:moment_dart_demo/home.dart';
import 'package:moment_dart_demo/logic/syntax_highlight.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SyntaxHighlighter()
      .init(WidgetsBinding.instance.platformDispatcher.platformBrightness);

  runApp(const DemoApp());
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
