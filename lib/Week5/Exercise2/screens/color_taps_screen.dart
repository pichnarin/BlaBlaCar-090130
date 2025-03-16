import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/color_counters.dart';
import '../widgets/color_tap.dart';

class ColorTapsScreen extends StatelessWidget {
  const ColorTapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Color Taps')),
      body: Column(
        children: [
          Consumer<ColorCounters>(
            builder: (context, counters, child) => ColorTap(
              type: CardType.red,
              tapCount: counters.redTapCount,
              onTap: counters.incrementRed,
            ),
          ),
          Consumer<ColorCounters>(
            builder: (context, counters, child) => ColorTap(
              type: CardType.blue,
              tapCount: counters.blueTapCount,
              onTap: counters.incrementBlue,
            ),
          ),
        ],
      ),
    );
  }
}
