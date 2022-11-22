import 'package:flutter/foundation.dart';

class LoginProvider extends ChangeNotifier {
  String errorMessage = '';

  void setErrorMessage(String message) {
    errorMessage = message;
    notifyListeners();
  }
}