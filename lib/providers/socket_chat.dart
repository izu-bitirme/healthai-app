import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthai/models/chat.dart';
import 'package:healthai/services/chat.dart';
import 'package:healthai/services/token.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

class ChatProvider with ChangeNotifier {
  final int userId;
  final int receiverId;
  final String roomName;
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _isConnected = false;
  String? _error;

  ChatProvider({
    required this.userId,
    required this.receiverId,
    required this.roomName,
  });

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;
  bool get isConnected => _isConnected;
  String? get error => _error;

  Future<void> init() async {
    ChatChannel.addListener('chat_message', _handleIncomingMessage);
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      final jsonData = json.decode(data);
      final message = ChatMessage.fromJson(jsonData);
      if(message.type != 'text' || message.type != "chat_message") return;
      _messages.add(message);
      notifyListeners();
    } catch (e) {
      _handleError("Failed to parse message: ${e.toString()}");
    }
  }

  void _handleError(String error) {
    _error = error;
    _isConnected = false;
    print('WebSocket Error: $error');
    notifyListeners();
  }

  void _handleDisconnection() {
    _isConnected = false;
    print('WebSocket connection closed');
    notifyListeners();
  }

  Future<void> sendMessage({
    required String content,
    String messageType = 'text',
    String? imageUrl,
  }) async {

    try {
      _isTyping = true;
      notifyListeners();

      final messageJson = {
        'receiver_id': receiverId,
        'message': content,
        'type': 'text',
      };

      ChatChannel.channel.sink.add(jsonEncode(messageJson));
      
      final message = ChatMessage.fromJson({
        ...messageJson,
        'message_id': DateTime.now().millisecondsSinceEpoch, 
      });
      _messages.add(message);
      
      notifyListeners();
    } catch (e) {
      _handleError("Failed to send message: ${e.toString()}");
      rethrow;
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  Future<void> reconnect() async {
    await init();
  }

  @override
  void dispose() {
    super.dispose();
  }
}