import 'package:flutter/material.dart';
import 'package:chat_buddy/styles.dart';
import 'package:flutter_star/flutter_star.dart';

class FeedbackScreen extends StatefulWidget {
  final VoidCallback onNavigate;
  final VoidCallback onBack;

  const FeedbackScreen({super.key, required this.onNavigate, required this.onBack});

  @override
  FeedbackScreenState createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {
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
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "How did you like the chat?",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: OtherStyles.mainBlue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      CustomRating(
                          max: 5,
                          score: 0.0,
                          star: Star (
                              num: 5,
                              fillColor: Colors.orangeAccent,
                              fat: 0.6,
                              emptyColor: Colors.grey.withAlpha(88)),
                          onRating: (s) {}
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Please give us some suggestions:",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Container(
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
                          // controller: textEditingController,
                          style: TextStyle(color: OtherStyles.mainBlue),
                          decoration: InputDecoration(
                            hintText: 'Happy to have your suggestions',
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
                          maxLines: 5,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyles.elevatedFilled,
                  onPressed: () {
                    widget.onNavigate();
                  },
                  child: const Text(
                    'Submit',
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

