import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  int currentIndex = 0;

  int get index => currentIndex;

  set index(int value) {
    currentIndex = value;

    notifyListeners();
  }

  // reviews
  int _current = 0;
  int get tab => _current;

  set tab(int value) {
    _current = value;

    notifyListeners();
  }
}
