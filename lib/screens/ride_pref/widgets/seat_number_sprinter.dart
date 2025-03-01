import 'package:flutter/material.dart';

class SeatNumberSpinner extends StatefulWidget {
  final int initialSeatCount;

  const SeatNumberSpinner({super.key, required this.initialSeatCount});

  @override
  SeatNumberSpinnerState createState() => SeatNumberSpinnerState();
}

class SeatNumberSpinnerState extends State<SeatNumberSpinner> {
  late int _seatCount;

  @override
  void initState() {
    super.initState();
    _seatCount = widget.initialSeatCount; // Set initial seat count to the passed value
  }

  void _incrementSeatCount() {
    setState(() {
      _seatCount++;
    });
  }

  void _decrementSeatCount() {
    if (_seatCount > 1) {
      setState(() {
        _seatCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Number of Seats')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seats: $_seatCount',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove, size: 30),
                  onPressed: _decrementSeatCount,
                ),
                IconButton(
                  icon: Icon(Icons.add, size: 30),
                  onPressed: _incrementSeatCount,
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _seatCount); // Pass the selected seat count back
              },
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: SeatNumberSpinner(initialSeatCount: 3)));
}
