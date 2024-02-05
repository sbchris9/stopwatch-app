import 'package:flutter/material.dart';
import 'package:stopwatch/utils/formatting_utils.dart';
import 'package:stopwatch/utils/layout_helpers.dart';

class LapsDisplay extends StatelessWidget {
  const LapsDisplay({
    super.key,
    required this.laps,
    required this.clearLaps,
  });

  final List<Duration> laps;
  final VoidCallback clearLaps;

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = isScreenSmallerThan(300, context);

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              itemCount: laps.length,
              itemBuilder: (context, index) {
                return _LapDisplayRow(
                  lap: laps[index],
                  position: laps.length - index,
                );
              },
            ),
          ),
        ),
        if (laps.isNotEmpty && !isSmallScreen)
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: clearLaps,
                icon: const Icon(
                  Icons.playlist_remove_outlined,
                ),
              ),
            ),
          )
      ],
    );
  }
}

class _LapDisplayRow extends StatelessWidget {
  const _LapDisplayRow({
    required this.lap,
    required this.position,
  });

  final Duration lap;
  final int position;

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = isScreenSmallerThan(300, context);

    return Row(
      children: [
        Expanded(
          child: Text(
            '$position',
            style: TextStyle(
              color: Colors.black54,
              fontSize: isSmallScreen ? 12 : 16,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              formatTime(lap),
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
