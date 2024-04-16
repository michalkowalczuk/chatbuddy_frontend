import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatCubit extends Cubit<List<Message>> {
  final Dio dio;
  late WebSocketChannel webSocketChannel;

  String clientId = "client-0";
  final String buddyId = "buddy-0";

  ChatCubit({required this.dio}) : super([]) {
    connect();
    fetchMessages();
  }

  void nameUpdate(String clientId) {
    this.clientId = clientId;
    fetchMessages();
  }

  String _getFormattedDateTime() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
  }

  void _sendWebSocketMessage(String message, String eventDescription) {
    webSocketChannel.sink.add(jsonEncode({
      "action": "client_message",
      "client_id": clientId,
      "buddy_id": buddyId,
      "client_message": message,
      "client_event": eventDescription,
      "client_date_time": _getFormattedDateTime()
    }));
  }

  void chatOpenEvent() {
    String eventDescription = "User just opened the chat window; "
        "User sending this message is called $clientId";
    _sendWebSocketMessage("", eventDescription);
  }

  void sendMessage(String message, {String? event}) {
    emit([Message(text: message, isBuddy: false), ...state]);
    String eventDescription = "User sending this message is called $clientId";
    _sendWebSocketMessage(message, eventDescription);
  }

  void connect() {
    webSocketChannel = WebSocketChannel.connect(
        Uri.parse("wss://0bjou6wxe1.execute-api.us-west-1.amazonaws.com/main/"));

    connectionUpdate();

    webSocketChannel.stream.listen(
      (message) {
        if (kDebugMode) {
          print(message);
        }
        final decodedMessage = jsonDecode(message);
        if (decodedMessage['action'] == 'tickle') {
          fetchMessages();
        }
      },
      onDone: reconnect,
      onError: (error) => reconnect(),
      cancelOnError: true,
    );
  }

  void connectionUpdate() {
    webSocketChannel.sink
        .add(jsonEncode({"action": "client_message", "update_connection": true}));
  }

  void reconnect() {
    Future.delayed(const Duration(seconds: 1), connect);
  }

  Future<void> fetchMessages() async {
    try {
      final response = await dio.post(
        'https://5gvuwjhdfz5clkb7dgminpqyyu0hqtqn.lambda-url.us-west-1.on.aws/',
        data: {
          "client_id": clientId,
          "buddy_id": buddyId,
        },
      );

      List<Message> messages = (response.data['messages'] as List)
          .where((message) => message['text'] != null && message['text'].toString().isNotEmpty)
          .map((message) {
            return Message(
              text: message['text'],
              isBuddy: message['role'] == 'model',
            );
          })
          .toList()
          .reversed
          .toList();

      emit(messages);
    } catch (e) {
      emit([]);
    }
  }
}

class Message {
  final String text;
  final bool isBuddy;
  final String imageUrl;

  Message({required this.text, required this.isBuddy})
      : imageUrl = isBuddy
            ? "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/rab.png"
            : "https://chatbuddy-public-img.s3.us-east-2.amazonaws.com/face.jpg";
}
