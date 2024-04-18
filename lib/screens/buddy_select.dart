import 'package:chat_buddy/cubits/buddy_cubit.dart';
import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:chat_buddy/cubits/client_cubit.dart';
import 'package:chat_buddy/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BuddySelectScreen extends StatelessWidget {
  final VoidCallback onEditUser;
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const BuddySelectScreen(
      {super.key, required this.onNavigate, required this.onBack, required this.onEditUser});

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
                BlocBuilder<ClientCubit, Client>(builder: (context, client) {
                  return Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: onEditUser,
                        child: Container(
                          padding: const EdgeInsets.all(8.0).copyWith(left: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            border: Border.all(
                              color: OtherStyles.mainBlue,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                client.name,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: OtherStyles.mainBlue,
                                ),
                              ),
                              const SizedBox(width: 8),
                              CircleAvatar(
                                radius: 14,
                                backgroundImage: NetworkImage(
                                  client.imageUrl,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                BlocBuilder<BuddyCubit, Buddy>(
                  builder: (context, buddy) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select a buddy to talk with',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: OtherStyles.mainBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Flexible(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_left, color: OtherStyles.mainBlue),
                                  onPressed: () => context.read<BuddyCubit>().previousBuddy(),
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
                                          image: NetworkImage(buddy.imageUrl),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_right, color: OtherStyles.mainBlue),
                                  onPressed: () => context.read<BuddyCubit>().nextBuddy(),
                                  iconSize: 40,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            buddy.name,
                            style: GoogleFonts.museoModerno(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                              color: OtherStyles.mainBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Flexible(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              constraints: const BoxConstraints.expand(),
                              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                              decoration: BoxDecoration(
                                color: OtherStyles.bubbleBg,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                buddy.description,
                                style: TextStyle(fontSize: 16, color: OtherStyles.mainBlue),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ElevatedButton(
                  style: ButtonStyles.elevatedFilled,
                  onPressed: () {
                    final currentBuddy = context.read<BuddyCubit>().currentBuddy();
                    context.read<ChatCubit>()
                      ..buddyUpdate(currentBuddy)
                      ..chatOpenEvent();
                    onNavigate();
                  },
                  child: const Text(
                    'Choose',
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
