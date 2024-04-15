import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onNavigate;

  const WelcomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to \nchatBuddy',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onNavigate,
              child: const Text('Begin'),
            ),
          ],
        ),
      ),
    );
  }
}
