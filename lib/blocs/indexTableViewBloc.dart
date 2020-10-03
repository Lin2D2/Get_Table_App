import 'package:flutter/material.dart';


class IndexTableViewBloc extends ChangeNotifier {
  int _index = 0;
  int get index => _index;

  set index(int val) {
    _index = val;
    notifyListeners();
  }

  void increment() {
    index++;
    notifyListeners();
  }
  void decrement() {
    index--;
    notifyListeners();
  }
  void set(int val) {
    index = val;
    notifyListeners();
  }
}