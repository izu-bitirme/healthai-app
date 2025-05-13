import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healthai/models/chat.dart';
import 'package:healthai/services/token.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as ws_status;

class ChatProvider with ChangeNotifier {
  final int userId;
  final int receiverId;
  final String roomName;
  WebSocketChannel? _channel;
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  bool _isInitialized = false;
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
    if (_isInitialized) return;

    try {
      final token = await TokenService.getAccessToken();
      if (token.isEmpty) {
        throw Exception("Authentication token not found");
      }

      final uri = Uri.parse('ws://127.0.0.1:8000/ws/chat/?token=$token');
      _channel = WebSocketChannel.connect(uri);

      _channel!.stream.listen(
        (data) {
          _handleIncomingMessage(data);
        },
        onError: (error) {
          _handleError(error.toString());
        },
        onDone: () {
          _handleDisconnection();
        },
      );

      _isInitialized = true;
      _isConnected = true;
      _error = null;
      notifyListeners();
    } catch (e) {
      _handleError(e.toString());
    }
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      final Map<String, dynamic> jsonData = jsonDecode(data);
      final message = ChatMessage.fromJson(jsonData);
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
    if (!_isConnected || _channel == null) {
      await init(); // Try to reconnect
      if (!_isConnected) {
        throw Exception("Not connected to WebSocket");
      }
    }

    try {
      _isTyping = true;
      notifyListeners();

      final messageJson = {
        'receiver_id': receiverId,
        'message': content,
        'type': 'text',
      };

      _channel!.sink.add(jsonEncode(messageJson));
      
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
    disposeWebSocket();
    await init();
  }

  void disposeWebSocket() {
    _channel?.sink.close(ws_status.goingAway);
    _channel = null;
    _isInitialized = false;
    _isConnected = false;
  }

  @override
  void dispose() {
    disposeWebSocket();
    super.dispose();
  }
}