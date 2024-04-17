import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/client_cubit.dart';

class NicknameSelectScreen extends StatefulWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const NicknameSelectScreen({super.key, required this.onNavigate, required this.onBack});

  @override
  NicknameSelectScreenState createState() => NicknameSelectScreenState();
}

class NicknameSelectScreenState extends State<NicknameSelectScreen> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

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
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: widget.onBack,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    "What's your nickname?",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<ClientCubit, Client>(
                    builder: (context, client) {
                      textEditingController.text = client.name;
                      textEditingController.selection = TextSelection.fromPosition(
                        TextPosition(offset: textEditingController.text.length),
                      );
                      return TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                          labelText: 'What is your name?',
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.left,
                      );
                    },
                  ),
                  const Text(
                    "You can change it any time",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final newName = textEditingController.text;
                      final chatCubit = context.read<ChatCubit>();
                      final clientCubit = context.read<ClientCubit>();

                      clientCubit.setName(newName).then((client) {
                        chatCubit.clientUpdate(client);
                        widget.onNavigate();
                      });
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}