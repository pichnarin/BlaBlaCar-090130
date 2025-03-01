import 'package:flutter/material.dart';

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const BlaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.foregroundColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultForegroundColor = isPrimary ? Colors.white : Colors.blue;
    final Color defaultBackgroundColor = isPrimary ? Colors.blue : Colors.white;

    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon, color: foregroundColor ?? defaultForegroundColor) : Container(),
      label: Text(label, style: TextStyle(color: foregroundColor ?? defaultForegroundColor)),
      style: ElevatedButton.styleFrom(
        foregroundColor: foregroundColor ?? defaultForegroundColor,
        backgroundColor: backgroundColor ?? defaultBackgroundColor,
      ),
      onPressed: onPressed,
    );
  }
}


class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test BlaButton Variations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlaButton(
              label: 'Contact Vovodia',
              onPressed: () => print('Contact Vovodia Pressed'),
              isPrimary: true,
              icon: Icons.contact_mail,
            ),
            SizedBox(height: 16),
            BlaButton(
              label: 'Request to Book',
              onPressed: () => print('Request to Book Pressed'),
              isPrimary: false,
              icon: Icons.book_online,
            ),
            SizedBox(height: 16),
            BlaButton(
              label: 'Primary Button',
              onPressed: () => print('Primary Button Pressed'),
              isPrimary: true,
            ),
            SizedBox(height: 16),
            BlaButton(
              label: 'Secondary Button',
              onPressed: () => print('Secondary Button Pressed'),
              isPrimary: false,
            ),
            SizedBox(height: 16),
            BlaButton(
              label: 'Primary with Icon',
              onPressed: () => print('Primary with Icon Pressed'),
              isPrimary: true,
              icon: Icons.star,
            ),
            SizedBox(height: 16),
            BlaButton(
              label: 'Secondary with Icon',
              onPressed: () => print('Secondary with Icon Pressed'),
              isPrimary: false,
              icon: Icons.star_border,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TestScreen(),
  ));
}
