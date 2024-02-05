import 'package:flutter/material.dart';
import 'package:stopwatch/config.dart';
import 'package:stopwatch/utils/formatting_utils.dart';
import 'package:stopwatch/utils/layout_helpers.dart';

class DigitalStopwatch extends StatelessWidget {
  const DigitalStopwatch({super.key, required this.stopwatch});

  final Stopwatch stopwatch;

  @override
  Widget build(BuildContext context) {
    if (!stopwatch.isRunning) {
      return _StopwatchText(elapsed: stopwatch.elapsed);
    }

    return StreamBuilder(
      stream: Stream.periodic(
        const Duration(milliseconds: AppConfig.updateRateMs),
      ),
      builder: (context, snapshot) {
        return _StopwatchText(elapsed: stopwatch.elapsed);
      },
    );
  }
}

class _StopwatchText extends StatelessWidget {
  final Duration _elapsed;

  const _StopwatchText({required Duration elapsed}) : _elapsed = elapsed;

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = isScreenSmallerThan(300, context);

    return Text(
      formatTime(_elapsed),
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontSize: isSmallScreen ? 16 : 32),
    );
  }
}
