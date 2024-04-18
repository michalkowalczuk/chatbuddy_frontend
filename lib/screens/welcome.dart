import 'package:chat_buddy/cubits/client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onNavigate;

  const WelcomeScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Preloader.preloadImages(context),
        Preloader.preloadFonts(),
        context.read<ClientCubit>().init(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            backgroundColor: Color.fromRGBO(84, 94, 120, 1.0),
          );
        }
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_1.jpg',
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.network(
                  'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/shiba_main.png',
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Welcome to \nchatBuddy',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.museoModerno(
                      fontSize: 50.0,
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
            ],
          ),
        );
      },
    );
  }
}

class Preloader {
  static const _imageUrls = [
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_1.jpg',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_2.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_3.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/face.jpg',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/rab.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/chat_bg.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/shiba_main.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/inu.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/owl.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f1.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f2.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f3.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f4.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f5.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f6.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f7.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f8.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f9.png'
  ];

  static Future<dynamic> preloadFonts() async {
    return await GoogleFonts.pendingFonts([
      GoogleFonts.mulishTextTheme(),
      GoogleFonts.mulish(),
      GoogleFonts.museoModernoTextTheme(),
      GoogleFonts.museoModerno()
    ]);
  }

  static Future<void> preloadImages(BuildContext context) async {
    await Future.wait(
      _imageUrls.map((url) => precacheImage(NetworkImage(url), context)),
    );
  }
}
