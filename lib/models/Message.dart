class Message {
  String message;
  String senderSocketId;
  DateTime sentAt;
  Message(
      {required this.message,
      required this.senderSocketId,
      required this.sentAt});
}
