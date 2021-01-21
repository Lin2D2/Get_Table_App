import 'package:get_storage/get_storage.dart';
import 'package:get_table_app/services/apiManagerService.dart';
import 'package:get_table_app/types/subjects.dart';
import 'package:get_table_app/types/teachers.dart';
import 'package:flutter/material.dart';

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
  List _filteredTeachers2nd = [];
  Future<Teachers> _teachers;

  Map get selectedElement => _selectedElement;

  String get year => _year;

  bool get edit => _edit;

  Map get copyTimeTable => _copyTimeTable;

  Future<Subjects> get subjects => _subjects;

  List get filteredTeachers => _filteredTeachers;

  List get filteredTeachers2nd => _filteredTeachers2nd;

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

  set filteredTeachers2nd(List value) {
    _filteredTeachers2nd = value;
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

  void initalSet() {
    final box = GetStorage("Get_Table_App");
    _subjects = Future(() {
      // TODO check that the value is valid befor return
      return Subjects.fromJson(box.read("SubjectsRaw"));
    });
    _teachers = Future(() {
      return Teachers.fromJson(box.read("TeachersRaw"));
    });
    box.listenKey('SubjectsRaw', (value) {
      _subjects = Future(() {
        // TODO check that the value is valid befor return
        return Subjects.fromJson(box.read("SubjectsRaw"));
      });
    });
    box.listenKey('TeachersRaw', (value) {
      _teachers = Future(() {
        return Teachers.fromJson(box.read("TeachersRaw"));
      });
    });
  }

  void refresh() async {
    final box = GetStorage("Get_Table_App");
    box.write('SubjectsRaw', await ApiRoutes.fetchSubjectsRaw());
    box.write('TeachersRaw', await ApiRoutes.fetchTeachersRaw());
  }
}
