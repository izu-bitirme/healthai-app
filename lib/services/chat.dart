import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthai/screens/call_screen.dart';
import 'package:healthai/services/token.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatChannel {
  static late WebSocketChannel channel;
  static List<Map<String, Function>> listeners = [];

  static init() async {
    String token = await TokenService.getAccessToken();
    channel = WebSocketChannel.connect(
      Uri.parse('ws://127.0.0.1:8000/ws/chat/?token=$token'),
    );
    channel.stream.listen((data) {
      for (var element in listeners) {
        Function func = element.values.first;
        func(data);
      }
    });
  }

  static addListener(String name, Function listener) {
    listeners.add({name: listener});
  }

  static removeListener(String name) {
    listeners.remove(
      listeners.firstWhere((element) => element.keys.first == name),
    );
  }

  static sendTextMessage({required String message, required int receiverId}) {
    channel.sink.add(
      jsonEncode({
        'receiver_id': receiverId,
        'message': message,
        'type': 'text',
      }),
    );
  }

  static call({
    required int receiverId,
    required String doctorName,
    required BuildContext context,
  }) {
    channel.sink.add(jsonEncode({'receiver_id': receiverId, 'type': 'call'}));

    addListener('call_listener', (data) {
      final jsonData = json.decode(data);
      print(jsonData);
      if (jsonData['type'] == 'call') {
        removeListener('call_listener');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return CallPage(
                doctorId: receiverId.toString(),
                doctorName: doctorName,
                callID: jsonData['call_id'],
              );
            },
          ),
        );
      }
    });
  }
}
