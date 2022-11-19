import 'package:arishti_chat_app/models/Message.dart';
import 'package:flutter/cupertino.dart';

class MessageProvider extends ChangeNotifier{
    List<Message> messageList = [];

    void addNewMessage(Message msg) {
    messageList.add(msg);
    notifyListeners();
  }
}
