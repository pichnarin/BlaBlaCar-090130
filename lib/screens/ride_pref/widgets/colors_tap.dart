import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Home()),
    ),
  );
}

enum CardType { red, blue }

///
/// Handle the number of taps per color
///
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int redTapCount = 0;
  int blueTapCount = 0;

  void _incrementRedTapCount() {
    setState(() {
      redTapCount++;
    });
  }

  void _incrementBlueTapCount() {
    setState(() {
      blueTapCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StatisticsScreen(blueTaps: blueTapCount, redTaps: redTapCount),
        ColorTap(
          type: CardType.red,
          onTap: _incrementRedTapCount,
          tapCount: redTapCount,
        ),
        ColorTap(
          type: CardType.blue,
          onTap: _incrementBlueTapCount,
          tapCount: blueTapCount,
        ),
      ],
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;
  final int tapCount;
  final VoidCallback onTap;

  const ColorTap({
    super.key,
    required this.type,
    required this.tapCount,
    required this.onTap,
  });

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: $tapCount',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  final int redTaps;
  final int blueTaps;

  const StatisticsScreen({
    super.key,
    required this.redTaps,
    required this.blueTaps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Red Taps: $redTaps', style: TextStyle(fontSize: 24)),
        Text('Blue Taps: $blueTaps', style: TextStyle(fontSize: 24)),
      ],
    );
  }
}