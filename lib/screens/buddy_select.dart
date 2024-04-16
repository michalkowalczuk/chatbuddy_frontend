import 'package:chat_buddy/cubits/buddy_cubit.dart';
import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuddySelectScreen extends StatelessWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const BuddySelectScreen({super.key, required this.onNavigate, required this.onBack});

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
          child: Column(
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
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<BuddyCubit, Buddy>(builder: (context, buddy) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Select a buddy to talk to',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
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
                                      image: NetworkImage(buddy.buddyImage),
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
                        const SizedBox(height: 10),
                        Text(
                          buddy.buddyName,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          buddy.buddyDesc,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Buddy currentBuddy = context.read<BuddyCubit>().currentBuddy();
                    context.read<ChatCubit>().buddyUpdate(currentBuddy);
                    context.read<ChatCubit>().chatOpenEvent();
                    onNavigate();
                  },
                  child: const Text('Choose'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
