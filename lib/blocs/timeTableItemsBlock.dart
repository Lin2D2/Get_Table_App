import 'package:Get_Table_App/services/apiManagerService.dart';
import 'package:Get_Table_App/types/subjects.dart';
import 'package:Get_Table_App/types/teachers.dart';
import 'package:flutter/material.dart';

class TimeTableItemsBlock extends ChangeNotifier {
  // for example {"day": "monday", "lesson": "1/2", "week": "not implemented"}
  Map _selectedElement;
  bool _edit = false;
  String _year = "";
  Map _copyTimeTable;
  List _rooms = ["---"];
  TextEditingController yearController = TextEditingController();
  Future<Subjects> _subjects = ApiRoutes.fetchSubjects();
  Future<Teachers> _teachers = ApiRoutes.fetchTeachers();

  Map get selectedElement => _selectedElement;

  String get year => _year;

  bool get edit => _edit;

  Map get copyTimeTable => _copyTimeTable;

  Future<Subjects> get subjects => _subjects;

  List get rooms => _rooms;

  Future<Teachers> get teachers => _teachers;

  set selectedElement(Map value) {
    _selectedElement = value;
    notifyListeners();
  }

  set year(String value) {
    _year = value;
    notifyListeners();
  }

  set edit(bool value) {
    _edit = value;
    notifyListeners();
  }

  set copyTimeTable(Map value) {
    _copyTimeTable = value;
    notifyListeners();
  }

  // void subjectsAdd(var value) {
  //   _subjects.add(value);
  //   notifyListeners();
  // }

  void roomsAdd(var value) {
    _rooms.add(value);
    notifyListeners();
  }

// void teacherAdd(var value) {
//   _teacher.add(value);
//   notifyListeners();
// }
}
