import 'package:arishti_chat_app/models/MessageModel.dart';
import 'package:flutter/foundation.dart';

class HomepageProvider extends ChangeNotifier {
  List<MessageModel> messageList = [];

  void addMessage(MessageModel message) {
    messageList.add(message);
    notifyListeners();
  }
}