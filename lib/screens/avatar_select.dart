import 'package:flutter/material.dart';

class AvatarSelectScreen extends StatelessWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const AvatarSelectScreen({super.key, required this.onNavigate, required this.onBack});

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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Select your avatar',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20), // Provides some spacing
                  // Avatar selection area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_left),
                        onPressed: () {}, // Placeholder function
                        iconSize: 40,
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10), // Add some horizontal margin for better spacing
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/face.jpg'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_right),
                        onPressed: () {}, // Placeholder function
                        iconSize: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: onNavigate,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
