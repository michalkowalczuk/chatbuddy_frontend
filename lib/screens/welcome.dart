import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:chat_buddy/cubits/client_cubit.dart';
import 'package:chat_buddy/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback navOnboarding;
  final VoidCallback navMain;

  const WelcomeScreen({super.key, required this.navMain, required this.navOnboarding});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Future.wait([
        Preloader.preloadImages(context),
        Preloader.preloadFonts(),
        context.read<ClientCubit>().init(),
      ]).then((results) => results[2] as bool),
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
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome to',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.museoModerno(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'ChatBuddy',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.museoModerno(
                            fontSize: 48.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            if (snapshot.data!) {
                              // client loaded
                              context
                                  .read<ChatCubit>()
                                  .clientUpdate(context.read<ClientCubit>().currentClient());
                              navMain();
                            } else {
                              // client not loaded
                              navOnboarding();
                            }
                          },
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: OtherStyles.mainBlue,
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.network(
                      'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/shiba_main.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
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
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/f9.png',
    'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/hooman.jpg'
  ];

  static Future<void> preloadFonts() async {
    await GoogleFonts.pendingFonts([
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
