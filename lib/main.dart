import 'package:flutter/material.dart';
import 'package:stopwatch/screens/home.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stopwatch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const StopwatchAppHome(),
      scrollBehavior:
          ScrollConfiguration.of(context).copyWith(scrollbars: false),
    );
  }
}
