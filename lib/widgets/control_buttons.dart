import 'package:flutter/material.dart';
import 'package:stopwatch/keys.dart';
import 'package:stopwatch/utils/layout_helpers.dart';

class StopwatchControlButtons extends StatelessWidget {
  const StopwatchControlButtons({
    super.key,
    required this.isRunning,
    required this.handleStart,
    required this.handlePause,
    required this.handleReset,
    required this.handleAddLap,
    required this.lapsFilled,
  });

  final bool isRunning;
  final bool lapsFilled;
  final VoidCallback handleStart;
  final VoidCallback handlePause;
  final VoidCallback handleReset;
  final VoidCallback handleAddLap;

  @override
  Widget build(BuildContext context) {
    bool lapDisabled = !isRunning || lapsFilled;
    bool isSmallScreen = isScreenSmallerThan(300, context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          key: AppWidgetKeys.resetButtonKey,
          onPressed: handleReset,
          icon: const Icon(Icons.refresh_outlined),
          iconSize: isSmallScreen ? 16 : null,
        ),
        IconButton.filled(
          key: AppWidgetKeys.startPauseButtonKey,
          onPressed: isRunning ? handlePause : handleStart,
          icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
          iconSize: isSmallScreen ? 20 : 40,
        ),
        IconButton(
          key: AppWidgetKeys.labButtonKey,
          onPressed: lapDisabled ? null : handleAddLap,
          icon: const Icon(Icons.flag_outlined),
          iconSize: isSmallScreen ? 16 : null,
        ),
      ],
    );
  }
}
