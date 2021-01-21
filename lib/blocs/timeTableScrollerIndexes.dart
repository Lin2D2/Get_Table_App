import 'package:flutter/material.dart';

class TimeTableScrollerIndexes extends ChangeNotifier {
  int _weekIndex = 0;
  int _subjectsIndex = 0;
  int _teachersIndex = 0;
  int _roomIndex = 0;
  int _weekIndex2nd = 0;
  int _subjectsIndex2nd = 0;
  int _teachersIndex2nd = 0;
  int _roomIndex2nd = 0;

  int get weekIndex => _weekIndex;

  int get subjectsIndex => _subjectsIndex;

  int get teachersIndex => _teachersIndex;

  int get roomIndex => _roomIndex;

  int get weekIndex2nd => _weekIndex2nd;

  int get subjectsIndex2nd => _subjectsIndex2nd;

  int get teachersIndex2nd => _teachersIndex2nd;

  int get roomIndex2nd => _roomIndex2nd;

  set weekIndex(int value) {
    _weekIndex = value;
    notifyListeners();
  }

  set subjectsIndex(int value) {
    _subjectsIndex = value;
    notifyListeners();
  }

  set teachersIndex(int value) {
    _teachersIndex = value;
    notifyListeners();
  }

  set roomIndex(int value) {
    _roomIndex = value;
    notifyListeners();
  }

  set weekIndex2nd(int value) {
    _weekIndex2nd = value;
    notifyListeners();
  }

  set subjectsIndex2nd(int value) {
    _subjectsIndex2nd = value;
    notifyListeners();
  }

  set teachersIndex2nd(int value) {
    _teachersIndex2nd = value;
    notifyListeners();
  }

  set roomIndex2nd(int value) {
    _roomIndex2nd = value;
    notifyListeners();
  }
}
