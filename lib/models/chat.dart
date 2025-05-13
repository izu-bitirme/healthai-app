class ChatMessage {
  final int messageId;
  final int senderId;
  final int receiverId;
  final String content;
  final String? imageUrl;
  final String messageType;
  final DateTime timestamp;
  final String status;

  ChatMessage({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    this.imageUrl,
    required this.messageType,
    required this.timestamp,
    required this.status,
  });

  // copyWith metodu ekleyin
  ChatMessage copyWith({
    int? messageId,
    int? senderId,
    int? receiverId,
    String? content,
    String? imageUrl,
    String? messageType,
    DateTime? timestamp,
    String? status,
  }) {
    return ChatMessage(
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      messageType: messageType ?? this.messageType,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
    );
  }

  // fromJson metodu (zaten varsa güncelleyin)
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['message_id'] ?? 0,
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
      content: json['content'],
      imageUrl: json['image_url'],
      messageType: json['message_type'] ?? 'text',
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'] ?? 'sent',
    );
  }

  // toJson metodu (isteğe bağlı)
  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'content': content,
      'image_url': imageUrl,
      'message_type': messageType,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }
}