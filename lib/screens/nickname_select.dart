import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NicknameSelectScreen extends StatelessWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  final TextEditingController textEditingController = TextEditingController(text: "Michal");

  NicknameSelectScreen({super.key, required this.onNavigate, required this.onBack});

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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "What's your nickname?",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20), // Provides some spacing
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextField(
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        labelText: 'Enter your nickname',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "You can change it any time",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  String newName = textEditingController.text;
                  if(newName.isEmpty) {
                    newName = "client-0";
                  }
                  context.read<ChatCubit>().nameUpdate(newName);
                  onNavigate();
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
