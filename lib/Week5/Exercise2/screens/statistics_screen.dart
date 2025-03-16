import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/color_counters.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics')),
      body: Center(
        child: Consumer<ColorCounters>(
          builder: (context, counters, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Red Taps: ${counters.redTapCount}',
                  style: const TextStyle(fontSize: 24)),
              Text('Blue Taps: ${counters.blueTapCount}',
                  style: const TextStyle(fontSize: 24)),
            ],
          ),
        ),
      ),
    );
  }
}
