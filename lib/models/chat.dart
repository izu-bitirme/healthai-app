import 'package:intl/intl.dart';

class ChatMessage {
  late String type;
  late String content;
  String? imageUrl;
  String? senderName;
  late DateTime timestamp;
  bool isSender = false;

  ChatMessage({
    required this.type,
    required this.content,
    this.imageUrl,
    this.senderName,
    required this.timestamp,
    required this.isSender,
  });

  ChatMessage.fromJson(Map<String, dynamic> json) {
    type = json['message_type'];
    content = json['text'];
    imageUrl = json['image_url'];
    senderName = json['sender_name'];
    timestamp = DateFormat("dd-MM-yyyy HH:mm:ss").parse(json['date']);
    isSender = json['is_sender'];
  }
}
