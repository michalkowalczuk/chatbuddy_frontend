import 'package:chat_buddy/cubits/buddy_cubit.dart';
import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:chat_buddy/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuddySelectScreen extends StatelessWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const BuddySelectScreen({super.key, required this.onNavigate, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/on_3.png',
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
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
                  BlocBuilder<BuddyCubit, Buddy>(
                    builder: (context, buddy) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select a buddy to talk with',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: OtherStyles.mainBlue,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_left),
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
                                icon: const Icon(Icons.arrow_right),
                                onPressed: () => context.read<BuddyCubit>().nextBuddy(),
                                iconSize: 40,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            buddy.name,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: OtherStyles.mainBlue),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8,),
                          Container(
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
                        ],
                      );
                    },
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ButtonStyles.elevatedFilled,
                    onPressed: () {
                      final currentBuddy = context.read<BuddyCubit>().currentBuddy();
                      context.read<ChatCubit>()
                        ..buddyUpdate(currentBuddy)
                        ..chatOpenEvent();
                      onNavigate();
                    },
                    child: const Text('Choose', style: TextStyle(fontSize: 16),),
                  ),
                  const SizedBox(height: 60,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
