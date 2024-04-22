import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../cubits/chat_cubit.dart';
import '../styles.dart';

class ChatScreen extends StatefulWidget {
  final VoidCallback onBack;

  const ChatScreen({super.key, required this.onBack});

  @override
  State<ChatScreen> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFocusNone = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().stream.listen((_) {
      _scrollToBottom();
    });
    _textFocusNone.addListener(() {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _textFocusNone.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/chat_bg.png',
            ),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
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
                    const Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<ChatCubit, List<Message>>(
                  builder: (context, messages) {
                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        if(message.infoMessage) {
                          return Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            margin: const EdgeInsets.all(8).copyWith(left: 32, right: 32),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              message.text,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        } else {
                          return ChatBubble(
                            text: message.text,
                            isBuddy: message.isBuddy,
                            imageUrl: message.imageUrl,
                          );
                        }
                      },
                    );
                  },
                ),
              ),
              ChatInputField(focusNode: _textFocusNone),
            ],
          ),
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
        if (isBuddy)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isBuddy
                  ? OtherStyles.bubbleBg.withOpacity(0.8)
                  : OtherStyles.mainBlue.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topLeft: isBuddy ? const Radius.circular(0) : const Radius.circular(16),
                topRight: isBuddy ? const Radius.circular(16) : const Radius.circular(0),
                bottomLeft: const Radius.circular(16),
                bottomRight: const Radius.circular(16),
              ),
            ),
            child: MarkdownBody(
              data: text,
              softLineBreak: true,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(fontSize: 16, color: isBuddy ? Colors.black : Colors.white),
              ),
            ),
          ),
        ),
        if (!isBuddy) CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
      ],
    );
  }
}

class ChatInputField extends StatefulWidget {
  final FocusNode focusNode;

  const ChatInputField({super.key, required this.focusNode});

  @override
  ChatInputFieldState createState() => ChatInputFieldState();
}

class ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _textController = TextEditingController();

  void sendMessage(BuildContext context) {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(text);
      _textController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8).copyWith(left: 16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              focusNode: widget.focusNode,
              style: const TextStyle(fontSize: 16),
              onSubmitted: (_) => sendMessage(context),
              decoration: const InputDecoration(
                isDense: true,
                hintText: "Talk about anything here...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: OtherStyles.mainBlue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 16),
              onPressed: () => sendMessage(context),
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
