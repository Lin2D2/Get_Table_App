import 'package:flutter/material.dart';

class TimeTableItemsBlock extends ChangeNotifier {
  // for example {"day": "monday", "lesson": "1/2", "week": "not implemented"}
  Map _selectedElement;
  bool _edit = false;
  Map copyTimeTable;
  List subjects = ["---"];
  List rooms = ["---"];
  List teacher = ["?"];

  Map get selectedElement => _selectedElement;

  bool get edit => _edit;

  set selectedElement(Map value) {
    _selectedElement = value;
    notifyListeners();
  }

  set edit(bool value) {
    _edit = value;
    notifyListeners();
  }
}
