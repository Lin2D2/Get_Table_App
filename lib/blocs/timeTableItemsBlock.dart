import 'dart:convert';
import 'package:get_table_app/services/apiManagerService.dart';
import 'package:get_table_app/types/subjects.dart';
import 'package:get_table_app/types/teachers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeTableItemsBlock extends ChangeNotifier {
  // for example {"day": "monday", "lesson": "1/2", "week": "not implemented"}
  bool isSet = false;
  Map _selectedElement;
  bool _edit = false;
  String _year = "";
  Map _copyTimeTable;
  List _rooms = ["---"];
  TextEditingController yearController = TextEditingController();
  Future<Subjects> _subjects;
  List _filteredTeachers = [];
  Future<Teachers> _teachers;

  Map get selectedElement => _selectedElement;

  String get year => _year;

  bool get edit => _edit;

  Map get copyTimeTable => _copyTimeTable;

  Future<Subjects> get subjects => _subjects;

  List get filteredTeachers => _filteredTeachers;

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

  set filteredTeachers(List value) {
    _filteredTeachers = value;
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

  void refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _subjects = Future(() {
      // TODO check that the value is valid befor return
      return Subjects.fromJson(jsonDecode(prefs.getString("SubjectsRaw")));
    });
    _teachers = Future(() {
      return Teachers.fromJson(jsonDecode(prefs.getString("TeachersRaw")));
    });
    notifyListeners();
  }
}
