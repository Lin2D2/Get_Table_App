import 'package:flutter/material.dart';

class TimeTableItemsBlock extends ChangeNotifier {
  // for example {"day": "monday", "lesson": "1/2", "week": "not implemented"}
  Map _selectedElement;
  bool _edit = false;
  Map _copyTimeTable;
  List _subjects = ["---"];
  List _rooms = ["---"];
  List _teacher = ["?"];

  Map get selectedElement => _selectedElement;
  bool get edit => _edit;
  Map get copyTimeTable => _copyTimeTable;
  List get subjects => _subjects;
  List get rooms => _rooms;
  List get teacher => _teacher;

  set selectedElement(Map value) {
    _selectedElement = value;
    notifyListeners();
  }
  set edit(bool value) {
    _edit = value;
    notifyListeners();
  }
  set copyTimeTable(Map value) {
    _copyTimeTable = value;
    notifyListeners();
  }void subjectsAdd(var value) {
    _subjects.add(value);
    notifyListeners();
  }void roomsAdd(var value) {
    _rooms.add(value);
    notifyListeners();
  }void teacherAdd(var value) {
    _teacher.add(value);
    notifyListeners();
  }
}
