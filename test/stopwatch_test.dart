import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/keys.dart';
import 'package:stopwatch/main.dart';

void main() {
  testWidgets('Elapsed time increases over time', (WidgetTester tester) async {
    await tester.pumpWidget(const StopwatchApp());

    expect(find.text('00:00.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));

    await tester.pump(const Duration(seconds: 5));

    expect(find.text('00:05.000'), findsOneWidget);

    await tester.pump(const Duration(seconds: 4, milliseconds: 800));

    expect(find.text('00:09.800'), findsOneWidget);
  });

  testWidgets('Pressing the pause button pauses the stopwatch',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StopwatchApp());

    expect(find.text('00:00.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));

    await tester.pump(const Duration(seconds: 3));

    expect(find.text('00:03.000'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));

    expect(find.text('00:05.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));

    await tester.pump(const Duration(seconds: 10));

    expect(find.text('00:05.000'), findsOneWidget);
  });

  testWidgets('Pressing the reset button resets the stopwatch',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StopwatchApp());

    expect(find.text('00:00.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));

    await tester.pump(const Duration(seconds: 5));

    expect(find.text('00:05.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.resetButtonKey));

    await tester.pump();

    expect(find.text('00:00.000'), findsOneWidget);
  });

  testWidgets('Behaves correctly on expected user behavior',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StopwatchApp());

    expect(find.text('00:00.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));

    await tester.pump(const Duration(seconds: 1, milliseconds: 500));

    expect(find.text('00:01.500'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));
    await tester.pump();

    await tester.pump(const Duration(seconds: 10));

    expect(find.text('00:01.500'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));

    await tester.pump(const Duration(seconds: 3, milliseconds: 500));

    expect(find.text('00:05.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.resetButtonKey));

    await tester.pump();

    expect(find.text('00:00.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));

    await tester.pump(
      const Duration(minutes: 01, seconds: 7, milliseconds: 130),
    );

    expect(find.text('01:07.130'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));
    await tester.pump();

    await tester.pump(const Duration(days: 1));

    expect(find.text('01:07.130'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.resetButtonKey));
    await tester.pump();

    expect(find.text('00:00.000'), findsOneWidget);

    await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));

    await tester.pump(const Duration(minutes: 1, milliseconds: 59));

    expect(find.text('01:00.059'), findsOneWidget);
  });

  testWidgets('Behaves correctly on unexpected user behavior',
      (WidgetTester tester) async {
    await tester.pumpWidget(const StopwatchApp());

    expect(find.text('00:00.000'), findsOneWidget);

    for (var i = 0; i < 100; i++) {
      await tester.tap(find.byKey(AppWidgetKeys.startPauseButtonKey));
      await tester.pump(const Duration(milliseconds: 1));
    }

    expect(find.text('00:00.050'), findsOneWidget);
  });
}
