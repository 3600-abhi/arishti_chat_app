class MessageModel {
  final String message;
  final String senderName;
  final DateTime sentAt;

  MessageModel({
    required this.message,
    required this.senderName,
    required this.sentAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> message) {
    return MessageModel(
      message: message['message'],
      senderName: message['senderName'],
      sentAt: DateTime.fromMillisecondsSinceEpoch(message['sentAt']),
    );
  }
}