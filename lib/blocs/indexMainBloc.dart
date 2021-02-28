import 'package:flutter/material.dart';


class IndexMainBloc extends ChangeNotifier {
  int _index = 0;
  int previousIndex;

  // TODO get current root not auto set to the first
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
