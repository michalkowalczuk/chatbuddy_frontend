import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onNavigate;

  const WelcomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ImagePreloader.preloadImages(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              backgroundColor: Color.fromRGBO(84, 94, 120, 1.0),
            );
          }
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Welcome to \nchatBuddy',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
                  ),
                  Image.network(
                    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/shiba_main.png',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ImagePreloader {
  static Future<void> preloadImages(BuildContext context) async {
    await Future.wait([
      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_1.jpg'),
          context),
      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_2.png'),
          context),
      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_3.png'),
          context),
      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/face.jpg'),
          context),
      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/rab.png'),
          context),
      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/chat_bg.png'),
          context),
      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/shiba_main.png'),
          context),

      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/inu.png'),
          context),

      precacheImage(
          const NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/owl.png'),
          context),
    ]);
  }
}
