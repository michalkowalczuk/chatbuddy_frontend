import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'buddy_cubit.dart';
import 'client_cubit.dart';

class ChatCubit extends Cubit<List<Message>> {
  static const String webSocketsUrl = "wss://0bjou6wxe1.execute-api.us-west-1.amazonaws.com/main/";
  static const String chatRetrieveUrl =
      "https://5gvuwjhdfz5clkb7dgminpqyyu0hqtqn.lambda-url.us-west-1.on.aws";

  final Dio dio;
  late WebSocketChannel webSocketChannel;

  Client client = Client.empty();
  Buddy buddy = Buddy.empty();

  ChatCubit({required this.dio}) : super([]) {
    connect();
    fetchMessages();
  }

  void clientUpdate(Client client) {
    this.client = client;
    fetchMessages();
  }

  void buddyUpdate(Buddy buddy) {
    this.buddy = buddy;
    emit([]);
    fetchMessages();
  }

  String _getFormattedDateTime() => DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now());

  void _sendWebSocketMessage(String message, String eventDescription) {
    webSocketChannel.sink.add(jsonEncode({
      "action": "client_message",
      "client_id": client.id,
      "buddy_id": buddy.id,
      "client_message": message,
      "client_event": eventDescription,
      "client_date_time": _getFormattedDateTime()
    }));
  }

  void chatOpenEvent() {
    emit([...state, Message(text: "...", isBuddy: true, imageUrl: buddy.imageUrl)]);
    final under18 = client.adult ? "" : "User is a minor under 18 years of age";
    final eventDescription =
        "User opened the chat window; User sending this message is called ${client.name}; $under18";
    _sendWebSocketMessage("", eventDescription);
  }

  void sendMessage(String message, {String? event}) {
    emit([
      ...state,
      Message(
        text: message,
        isBuddy: false,
        imageUrl: client.imageUrl,
      ),
    ]);
    final under18 = client.adult ? "" : "User is a minor under 18 years of age;";
    final eventDescription = "$under18 User sending this message is called ${client.name}; $under18";
    _sendWebSocketMessage(message, eventDescription);
  }

  void connect() {
    webSocketChannel = WebSocketChannel.connect(Uri.parse(webSocketsUrl));
    connectionUpdate();
    webSocketChannel.stream.listen(
      (message) {
        debugPrint(message);
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
    webSocketChannel.sink.add(jsonEncode({"action": "client_message", "update_connection": true}));
  }

  void reconnect() => Future.delayed(const Duration(seconds: 1), connect);

  Future<void> fetchMessages() async {
    try {
      final response = await dio.post(
        chatRetrieveUrl,
        data: {
          "client_id": client.id,
          "buddy_id": buddy.id,
        },
      );

      final messages = (response.data['messages'] as List)
          .where((message) => message['text'] != null && message['text'].toString().isNotEmpty)
          .map(
            (message) => Message(
              text: message['text'],
              isBuddy: message['role'] == 'model',
              imageUrl: message['role'] == 'model' ? buddy.imageUrl : client.imageUrl,
            ),
          )
          .toList();

      final rowList = response.data['messages'] as List;
      if (rowList.isNotEmpty && rowList.last['role'] == 'user') {
        messages.add(Message(text: "...", isBuddy: true, imageUrl: buddy.imageUrl));
      }

      emit(messages);
    } catch (e) {
      debugPrint("Error fetching messages $e");
    }
  }
}

class Message {
  final String text;
  final bool isBuddy;
  final String imageUrl;

  Message({required this.text, required this.isBuddy, required this.imageUrl});
}
