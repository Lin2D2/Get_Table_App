import 'package:flutter/material.dart';

class DropdownMenuBloc extends ChangeNotifier {
  String _value = "A/B";

  String get value => _value;

  set index(String val) {
    _value = val;
    notifyListeners();
  }

  void set(String val) {
    index = val;
  }
}
