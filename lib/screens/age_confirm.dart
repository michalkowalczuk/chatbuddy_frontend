import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:chat_buddy/cubits/client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles.dart';

class AgeConfirmScreen extends StatelessWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const AgeConfirmScreen({
    super.key,
    required this.onNavigate,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_2.png',
            ),
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
                  child: Center(
                    child: Text(
                      'Are you over 18 years old?',
                      style: TextStyle(
                        color: OtherStyles.mainBlue,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: onNavigate,
                  style: ButtonStyles.elevatedFilled,
                  child: const Text(
                    'Yes, I am',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<ClientCubit>().setUnder18().then((client) {
                      context.read<ChatCubit>().clientUpdate(client);
                      onNavigate();
                    });
                  },
                  style: ButtonStyles.elevatedOutline,
                  child: const Text(
                    "No, I'm not",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
