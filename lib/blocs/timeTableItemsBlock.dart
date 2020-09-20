import 'package:flutter/material.dart';

class TimeTableItemsBlock extends ChangeNotifier {
  List<TableRow> _monday = [
    headerRow(),
  ];
  List<TableRow> _tuesday = [
    headerRow(),
  ];
  List<TableRow> _wednesday = [
    headerRow(),
  ];
  List<TableRow> _thursday = [
    headerRow(),
  ];
  List<TableRow> _friday = [
    headerRow(),
  ];
  List _daysString = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  List get daysString => _daysString;

  List get monday => _monday;

  List get tuesday => _tuesday;

  List get wednesday => _wednesday;

  List get thursday => _thursday;

  List get friday => _friday;

  set monday(List val) {
    _monday = val;
    notifyListeners();
  }

  set tuesday(List val) {
    _tuesday = val;
    notifyListeners();
  }

  set wednesday(List val) {
    _wednesday = val;
    notifyListeners();
  }

  set thursday(List val) {
    _thursday = val;
    notifyListeners();
  }

  set friday(List val) {
    _friday = val;
    notifyListeners();
  }
  List days(int i) {
    switch (i) {
      case 0:
        {
          return monday;
        }
      case 1:
        {
          return tuesday;
        }
      case 2:
        {
          return wednesday;
        }
      case 3:
        {
          return thursday;
        }
      case 4:
        {
          return friday;
        }
    }
  }

  void add(int i, element) {
    switch (i) {
      case 0:
        {
          monday.add(element);
          notifyListeners();
          break;
        }
      case 1:
        {
          tuesday.add(element);
          notifyListeners();
          break;
        }
      case 2:
        {
          wednesday.add(element);
          notifyListeners();
          break;
        }
      case 3:
        {
          thursday.add(element);
          notifyListeners();
          break;
        }
      case 4:
        {
          friday.add(element);
          notifyListeners();
          break;
        }
    }
  }
  void removeLast(int i) {
    switch (i) {
      case 0:
        {
          monday.removeLast();
          notifyListeners();
          break;
        }
      case 1:
        {
          tuesday.removeLast();
          notifyListeners();
          break;
        }
      case 2:
        {
          wednesday.removeLast();
          notifyListeners();
          break;
        }
      case 3:
        {
          thursday.removeLast();
          notifyListeners();
          break;
        }
      case 4:
        {
          friday.removeLast();
          notifyListeners();
          break;
        }
    }
  }
}

TableRow headerRow() {
  return TableRow(
    decoration: BoxDecoration(
      color: Colors.grey[900],
    ),
    children: [
      Text(
        "lesson",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      Text(
        "subject",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      Text(
        "room",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ],
  );
}
