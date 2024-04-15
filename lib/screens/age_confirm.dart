import 'package:flutter/material.dart';

class AgeConfirmScreen extends StatelessWidget {
  final VoidCallback onYesNavigate;
  final VoidCallback onNoNavigate;
  final VoidCallback onBack;

  const AgeConfirmScreen({
    super.key,
    required this.onYesNavigate,
    required this.onNoNavigate, required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: onBack,
                  ),
                  const Spacer(),
                ],
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  'Are you over 18 years old?',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: onYesNavigate,
                    child: const Text('Yes, I am'),
                  ),
                  const SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: onNoNavigate,
                    child: const Text("No, I'm not"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
