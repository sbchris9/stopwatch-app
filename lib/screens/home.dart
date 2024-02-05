import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/config.dart';
import 'package:stopwatch/layouts/layout.dart';
import 'package:stopwatch/widgets/control_buttons.dart';
import 'package:stopwatch/widgets/analog_stopwatch.dart';
import 'package:stopwatch/widgets/digital_stopwatch.dart';
import 'package:stopwatch/widgets/laps_display.dart';

class StopwatchAppHome extends StatefulWidget {
  const StopwatchAppHome({super.key});

  @override
  State<StopwatchAppHome> createState() => _StopwatchAppState();
}

class _StopwatchAppState extends State<StopwatchAppHome> {
  late Stopwatch _stopwatch;
  late List<Duration> _laps;

  @override
  void initState() {
    _stopwatch = clock.stopwatch();
    _laps = [];

    super.initState();
  }

  void _handleStart() {
    setState(() {
      _stopwatch.start();
    });
  }

  void _handlePause() {
    setState(() {
      _stopwatch.stop();
    });
  }

  void _handleAddLap() {
    setState(() {
      _laps.insert(0, _stopwatch.elapsed);
      if (_laps.length > AppConfig.maxLaps) return;
    });
  }

  void _handleClearLaps() {
    setState(() {
      _laps.clear();
    });
  }

  void _handleReset() {
    setState(() {
      _laps.clear();
      _stopwatch
        ..stop()
        ..reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool lapsFilled = _laps.length >= AppConfig.maxLaps;

    return Scaffold(
      body: Center(
        child: StopwatchAppLayout(
          analogStopwatch: AnalogStopwatch(
            stopwatch: _stopwatch,
          ),
          digitalStopwatch: DigitalStopwatch(
            stopwatch: _stopwatch,
          ),
          controlButtons: StopwatchControlButtons(
            isRunning: _stopwatch.isRunning,
            handleStart: _handleStart,
            handlePause: _handlePause,
            handleAddLap: _handleAddLap,
            handleReset: _handleReset,
            lapsFilled: lapsFilled,
          ),
          lapsDisplay: LapsDisplay(
            laps: _laps,
            clearLaps: _handleClearLaps,
          ),
        ),
      ),
    );
  }
}
