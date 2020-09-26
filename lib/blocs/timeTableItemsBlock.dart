import 'package:flutter/material.dart';
import 'package:Get_Table_App/widgets/timeTableEditHeaderRow.dart';
import 'package:Get_Table_App/widgets/timeTableEditTableRows.dart';

class TimeTableItemsBlock extends ChangeNotifier {
  int _mondayCounter = 1;
  int _tuesdayCounter = 1;
  int _wednesdayCounter = 1;
  int _thursdayCounter = 1;
  int _fridayCounter = 1;
  List<TableRow> _monday = [
    timeTableEditHeaderRow(),
  ];
  List<TableRow> _tuesday = [
    timeTableEditHeaderRow(),
  ];
  List<TableRow> _wednesday = [
    timeTableEditHeaderRow(),
  ];
  List<TableRow> _thursday = [
    timeTableEditHeaderRow(),
  ];
  List<TableRow> _friday = [
    timeTableEditHeaderRow(),
  ];
  List _daysString = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  List _formDataRaw = [];

  List get daysString => _daysString;

  List get monday => _monday;

  List get tuesday => _tuesday;

  List get wednesday => _wednesday;

  List get thursday => _thursday;

  List get friday => _friday;

  List get formDataRaw => _formDataRaw;

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

  void add(int i, bool doubleLesson) {
    switch (i) {
      case 0:
        {
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_mondayCounter, doubleLesson);
          // TODO add other fields
          _formDataRaw.add({
            "day": "monday",
            "lesson": doubleLesson
                ? _mondayCounter.toString() +
                    "/" +
                    (_mondayCounter + 1).toString()
                : _mondayCounter.toString(),
            "controller": [
              timeTableEditTableRows.subjectController,
              timeTableEditTableRows.roomController
            ],
            "dropdown": timeTableEditTableRows.weekDropdownButton,
          });
          monday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _mondayCounter += 2 : _mondayCounter++;
          notifyListeners();
          break;
        }
      case 1:
        {
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_tuesdayCounter, doubleLesson);
          // TODO add other fields
          _formDataRaw.add({
            "day": "tuesday",
            "lesson": doubleLesson
                ? _tuesdayCounter.toString() +
                "/" +
                (_tuesdayCounter + 1).toString()
                : _tuesdayCounter.toString(),
            "controller": [
              timeTableEditTableRows.subjectController,
              timeTableEditTableRows.roomController
            ],
            "dropdown": timeTableEditTableRows.weekDropdownButton,
          });
          tuesday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _tuesdayCounter += 2 : _tuesdayCounter++;
          notifyListeners();
          break;
        }
      case 2:
        {
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_wednesdayCounter, doubleLesson);
          // TODO add other fields
          _formDataRaw.add({
            "day": "wednesday",
            "lesson": doubleLesson
                ? _wednesdayCounter.toString() +
                "/" +
                (_wednesdayCounter + 1).toString()
                : _wednesdayCounter.toString(),
            "controller": [
              timeTableEditTableRows.subjectController,
              timeTableEditTableRows.roomController
            ],
            "dropdown": timeTableEditTableRows.weekDropdownButton,
          });
          wednesday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _wednesdayCounter += 2 : _wednesdayCounter++;
          notifyListeners();
          break;
        }
      case 3:
        {
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_thursdayCounter, doubleLesson);
          // TODO add other fields
          _formDataRaw.add({
            "day": "thursday",
            "lesson": doubleLesson
                ? _thursdayCounter.toString() +
                "/" +
                (_thursdayCounter + 1).toString()
                : _thursdayCounter.toString(),
            "controller": [
              timeTableEditTableRows.subjectController,
              timeTableEditTableRows.roomController
            ],
            "dropdown": timeTableEditTableRows.weekDropdownButton,
          });
          thursday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _thursdayCounter += 2 : _thursdayCounter++;
          notifyListeners();
          break;
        }
      case 4:
        {
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_fridayCounter, doubleLesson);
          // TODO add other fields
          _formDataRaw.add({
            "day": "friday",
            "lesson": doubleLesson
                ? _fridayCounter.toString() +
                "/" +
                (_fridayCounter + 1).toString()
                : _fridayCounter.toString(),
            "controller": [
              timeTableEditTableRows.subjectController,
              timeTableEditTableRows.roomController
            ],
            "dropdown": timeTableEditTableRows.weekDropdownButton,
          });
          friday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _fridayCounter += 2 : _fridayCounter++;
          notifyListeners();
          break;
        }
    }
  }

  void removeLast(int i) {
    switch (i) {
      case 0:
        {
          if (monday.last.children[1].child.data.contains('/')) {
            monday.removeLast();
            _mondayCounter -= 2;
            notifyListeners();
          } else {
            monday.removeLast();
            _mondayCounter--;
            notifyListeners();
          }
          break;
        }
      case 1:
        {
          if (tuesday.last.children[1].child.data.contains('/')) {
            tuesday.removeLast();
            _tuesdayCounter -= 2;
            notifyListeners();
          } else {
            tuesday.removeLast();
            _tuesdayCounter--;
            notifyListeners();
          }
          break;
        }
      case 2:
        {
          if (wednesday.last.children[1].child.data.contains('/')) {
            wednesday.removeLast();
            _wednesdayCounter -= 2;
            notifyListeners();
          } else {
            wednesday.removeLast();
            _wednesdayCounter--;
            notifyListeners();
          }
          break;
        }
      case 3:
        {
          if (thursday.last.children[1].child.data.contains('/')) {
            thursday.removeLast();
            _thursdayCounter -= 2;
            notifyListeners();
          } else {
            thursday.removeLast();
            _thursdayCounter--;
            notifyListeners();
          }
          break;
        }
      case 4:
        {
          if (friday.last.children[1].child.data.contains('/')) {
            friday.removeLast();
            _fridayCounter -= 2;
            notifyListeners();
          } else {
            friday.removeLast();
            _fridayCounter--;
            notifyListeners();
          }
          break;
        }
    }
  }
}
