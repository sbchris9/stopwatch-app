import 'package:flutter/material.dart';
import 'package:stopwatch/utils/layout_helpers.dart';

class StopwatchAppLandscapeLayout extends StatelessWidget {
  const StopwatchAppLandscapeLayout({
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
    bool isSmallScreen = isScreenSmallerThan(300, context);

    const borderSide = BorderSide(
      width: 1,
      color: Colors.black12,
    );

    return Container(
      constraints: const BoxConstraints(maxHeight: 300),
      padding: EdgeInsets.all(isSmallScreen ? 4 : 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isSmallScreen)
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 4 : 16,
                ),
                child: analogStopwatch,
              ),
            ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border(
                  right: borderSide,
                  left: isSmallScreen ? BorderSide.none : borderSide,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isSmallScreen) const Spacer(),
                  Expanded(child: Center(child: digitalStopwatch)),
                  Expanded(child: controlButtons),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: lapsDisplay,
            ),
          ),
        ],
      ),
    );
  }
}
