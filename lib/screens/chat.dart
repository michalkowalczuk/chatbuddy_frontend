import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../cubits/chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  final VoidCallback onBack;
  final TextEditingController textMessageCtrl = TextEditingController();

  ChatScreen({super.key, required this.onBack});

  void sendMessage(BuildContext context) {
    if (textMessageCtrl.text.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(textMessageCtrl.text);
      textMessageCtrl.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
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
              child: BlocBuilder<ChatCubit, List<Message>>(
                builder: (context, messages) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ChatBubble(
                        text: message.text,
                        isBuddy: message.isBuddy,
                        imageUrl: message.imageUrl,
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onSubmitted: (_) => sendMessage(context),
                      controller: textMessageCtrl,
                      decoration: InputDecoration(
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => sendMessage(context)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isBuddy;
  final String imageUrl;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isBuddy,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isBuddy ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isBuddy) CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isBuddy ? Colors.grey[300] : Colors.blue[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: MarkdownBody(
              data: text,
              softLineBreak: true,
            ),
          ),
        ),
        if (!isBuddy) CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      ],
    );
  }
}
