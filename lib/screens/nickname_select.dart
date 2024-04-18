import 'package:chat_buddy/cubits/chat_cubit.dart';
import 'package:chat_buddy/styles.dart';
import 'package:flutter/cupertino.dart';
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
                    InkWell(
                      onTap: widget.onBack,
                      child: Container(
                        padding: const EdgeInsets.all(8).copyWith(left: 0),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: OtherStyles.mainBlue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: 0.75,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(OtherStyles.mainBlue),
                          minHeight: 4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "What's your name?",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: OtherStyles.mainBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<ClientCubit, Client>(
                        builder: (context, client) {
                          textEditingController.text = client.name;
                          textEditingController.selection = TextSelection.fromPosition(
                            TextPosition(offset: textEditingController.text.length),
                          );
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: textEditingController,
                              style: TextStyle(color: OtherStyles.mainBlue),
                              decoration: InputDecoration(
                                hintText: 'Enter your name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 24,
                                ),
                                filled: true,
                                fillColor: OtherStyles.bubbleBg,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "You can change it any time",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyles.elevatedFilled,
                  onPressed: () {
                    final newName = textEditingController.text;
                    final chatCubit = context.read<ChatCubit>();
                    final clientCubit = context.read<ClientCubit>();

                    clientCubit.setName(newName).then((client) {
                      chatCubit.clientUpdate(client);
                      widget.onNavigate();
                    });
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
