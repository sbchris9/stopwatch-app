import 'dart:math';
import 'package:flutter/material.dart';

class AnalogStopwatch extends StatelessWidget {
  const AnalogStopwatch({super.key, required this.stopwatch});

  final Stopwatch stopwatch;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AnalogStopwatchPainter(stopwatch: stopwatch, context: context),
      child: const SizedBox(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class _AnalogStopwatchPainter extends CustomPainter {
  _AnalogStopwatchPainter({required this.stopwatch, required this.context});

  final Stopwatch stopwatch;
  final BuildContext context;

  static const padding = 20.0;

  static const hourHandColor = Colors.black;
  static const baseColor = Color.fromRGBO(113, 113, 113, 1);
  static const mutedColor = Color.fromRGBO(172, 172, 172, 1);

  Color get primaryColor => Theme.of(context).colorScheme.primary;
  Color get backgroundColor => Theme.of(context).colorScheme.background;

  static const baseRadius = 800.0;
  static const baseTickLength = 30.0;
  static const baseTickLengthModifier = 80.0;
  static const baseTickStrokeWidth = 12.0;
  static const baseHandStrokeWidth = 15.0;
  static const baseHandLength = baseRadius - 180.0;
  static const basePinHoleRadius = 42.0;

  @override
  paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final ratio = (size.shortestSide / 2 - padding) / baseRadius;
    final radius = baseRadius * ratio;

    _paintTickMarks(canvas, center, radius, ratio);
    _paintHands(canvas, center, radius, ratio);
    _paintPinHole(canvas, center, ratio);
  }

  void _paintTickMarks(
    Canvas canvas,
    Offset center,
    double radius,
    double ratio,
  ) {
    for (int i = 0; i < 60; ++i) {
      double lengthModifier = 0;

      if (i % 15 == 0) {
        lengthModifier = baseTickLengthModifier * ratio;
      } else if (i % 5 == 0) {
        lengthModifier = (baseTickLengthModifier / 2) * ratio;
      }

      var (start, end) = _calculateLineFromCenter(
        center: center,
        distance: radius - (lengthModifier / 2),
        length: baseTickLength * ratio + lengthModifier,
        angle: i * 6,
      );

      canvas.drawLine(
        start,
        end,
        Paint()
          ..color = lengthModifier == 0 ? mutedColor : baseColor
          ..strokeWidth = baseTickStrokeWidth * ratio,
      );
    }
  }

  void _paintHands(
    Canvas canvas,
    Offset center,
    double radius,
    double ratio,
  ) {
    double seconds = stopwatch.elapsedMilliseconds / 1000;
    double secHandAngle = seconds.remainder(60) * 6 - 90;

    var (secondHandStart, secondHandEnd) = _calculateLineFromCenter(
      center: center,
      length: baseHandLength * 1.1 * ratio,
      angle: secHandAngle,
    );

    double minutes = seconds / 60;
    double minHandAngle = minutes.remainder(60) * 6 - 90;

    var (minuteHandStart, minuteHandEnd) = _calculateLineFromCenter(
      center: center,
      length: baseHandLength * ratio,
      angle: minHandAngle,
    );

    double hours = minutes / 60;
    double hourHandAngle = hours.remainder(60) * 6 - 90;

    var (hourHandStart, hourHandEnd) = _calculateLineFromCenter(
      center: center,
      length: (baseHandLength * .9) * ratio,
      angle: hourHandAngle,
    );

    canvas.drawLine(
      hourHandStart,
      hourHandEnd,
      Paint()
        ..color = hourHandColor
        ..strokeWidth = baseHandStrokeWidth * ratio,
    );

    canvas.drawLine(
      minuteHandStart,
      minuteHandEnd,
      Paint()
        ..color = baseColor
        ..strokeWidth = baseHandStrokeWidth * ratio,
    );

    canvas.drawLine(
      secondHandStart,
      secondHandEnd,
      Paint()
        ..color = primaryColor
        ..strokeWidth = baseHandStrokeWidth * .6 * ratio,
    );
  }

  void _paintPinHole(Canvas canvas, Offset center, double ratio) {
    canvas.drawCircle(
      center,
      basePinHoleRadius * ratio,
      Paint()..color = primaryColor,
    );
    canvas.drawCircle(
      center,
      (basePinHoleRadius - baseHandStrokeWidth) * ratio,
      Paint()..color = backgroundColor,
    );
  }

  (Offset, Offset) _calculateLineFromCenter({
    required Offset center,
    required double angle,
    required double length,
    double distance = 0,
  }) {
    double radians = angle * pi / 180;

    double startX = center.dx + distance * cos(radians);
    double startY = center.dy + distance * sin(radians);

    double endX = startX + length * cos(radians);
    double endY = startY + length * sin(radians);

    return (Offset(startX, startY), Offset(endX, endY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return stopwatch.isRunning;
  }
}
