import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:chat_buddy/cubits/client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles.dart';

class AvatarSelectScreen extends StatelessWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const AvatarSelectScreen({super.key, required this.onNavigate, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0).copyWith(bottom: 40),
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select your avatar',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: OtherStyles.mainBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<ClientCubit, Client>(builder: (context, client) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_left,
                                color: OtherStyles.mainBlue,
                              ),
                              onPressed: () => context.read<ClientCubit>().previousAvatar(),
                              iconSize: 40,
                            ),
                            Expanded(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(client.imageUrl),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_right, color: OtherStyles.mainBlue),
                              onPressed: () => context.read<ClientCubit>().nextAvatar(),
                              iconSize: 40,
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyles.elevatedFilled,
                  onPressed: () {
                    Client currentClient = context.read<ClientCubit>().currentClient();
                    context.read<ChatCubit>().clientUpdate(currentClient);
                    onNavigate();
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
