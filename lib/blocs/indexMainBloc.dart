import 'package:flutter/material.dart';


class IndexMainBloc extends ChangeNotifier {
  int _index = 0;
  int _previousIndex;

  // TODO get current root not auto set to the first
  int get index => _index;
  int get previousIndex => _previousIndex;

  set index(int val) {
    _index = val;
    notifyListeners();
  }

  set previousIndex(int val) {
    _previousIndex = val;
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
