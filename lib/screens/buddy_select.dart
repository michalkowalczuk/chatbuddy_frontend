import 'package:flutter/material.dart';

class BuddySelectScreen extends StatelessWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const BuddySelectScreen({super.key, required this.onNavigate, required this.onBack});

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
                  const Spacer(), // This pushes the back button to the left and other content to the right
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Select a buddy to talk to',
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
                              margin: const EdgeInsets.symmetric(horizontal: 10), // Horizontal margin for better spacing
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage('https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/rabbit.jpg'),
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
                    const SizedBox(height: 10), // Provides some spacing
                    const Text(
                      'Rabbit Grandma',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'The rabbit grandma, embodies comfort and wisdom. As a listener, she offers gentle advice and a warm, nurturing presence.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: onNavigate,
                child: const Text('Choose'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
