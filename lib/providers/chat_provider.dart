import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  String _uid = '';
  String _username = '';

  String get uid => _uid;
  String get username => _username;

  set uid(String value) {
    _uid = value;

    notifyListeners();
  }

  set username(String value) {
    _username = value;

    notifyListeners();
  }
}
