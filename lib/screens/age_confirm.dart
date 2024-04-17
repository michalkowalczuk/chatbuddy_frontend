import 'package:flutter/material.dart';

class AgeConfirmScreen extends StatelessWidget {
  final VoidCallback onYesNavigate;
  final VoidCallback onNoNavigate;
  final VoidCallback onBack;

  const AgeConfirmScreen({
    super.key,
    required this.onYesNavigate,
    required this.onNoNavigate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_2.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: onBack,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'Are you over 18 years old?',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: onYesNavigate,
                    child: const Text('Yes, I am'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: onNoNavigate,
                    child: const Text("No, I'm not"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}