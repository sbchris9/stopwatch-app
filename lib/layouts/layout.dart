import 'package:flutter/material.dart';
import 'package:stopwatch/utils/layout_helpers.dart';

import 'landscape_layout.dart';

class StopwatchAppLayout extends StatelessWidget {
  const StopwatchAppLayout({
    super.key,
    required this.analogStopwatch,
    required this.digitalStopwatch,
    required this.controlButtons,
    required this.lapsDisplay,
  });

  final Widget analogStopwatch;
  final Widget digitalStopwatch;
  final Widget controlButtons;
  final Widget lapsDisplay;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape) {
          return StopwatchAppLandscapeLayout(
            analogStopwatch: analogStopwatch,
            digitalStopwatch: digitalStopwatch,
            controlButtons: controlButtons,
            lapsDisplay: lapsDisplay,
          );
        }

        // Default Portrait layout

        bool isSmallScreen = isScreenSmallerThan(300, context);
        bool hideAnalog = isScreenHeightSmallerThan(500, context);

        return Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: EdgeInsets.all(isSmallScreen ? 8 : 32),
          child: Column(children: [
            if (hideAnalog)
              Expanded(child: Center(child: digitalStopwatch))
            else ...[
              Expanded(flex: 4, child: analogStopwatch),
              digitalStopwatch,
            ],
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 280),
                padding: const EdgeInsets.all(8),
                child: lapsDisplay,
              ),
            ),
            controlButtons,
          ]),
        );
      },
    );
  }
}
