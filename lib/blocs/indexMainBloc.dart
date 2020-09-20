import 'package:flutter/material.dart';


class IndexMainBloc extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  set index(int val) {
    _index = val;
    notifyListeners();
  }

  void increment() {
    index++;
  }
  void decrement() {
    index--;
  }
  void set(int val) {
    index = val;
  }
}
