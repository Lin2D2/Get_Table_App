import 'package:flutter/material.dart';
import 'package:Get_Table_App/widgets/timeTableEditHeaderRow.dart';
import 'package:Get_Table_App/widgets/timeTableEditTableRows.dart';
import 'package:provider/provider.dart';
import 'formDataRawBloc.dart';

class TimeTableItemsBlock extends ChangeNotifier {
  List _IdList = [];
  int _IdCounter = 0;
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

  void add(int i, bool doubleLesson, BuildContext context) {
    switch (i) {
      case 0:
        {
          Key id = Key(_IdCounter.toString());
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_mondayCounter, doubleLesson, id);
          _IdList.add(id);
          context.read<FormDataRawBloc>().formDataRaw.add({
            "day": "monday",
            "id": id,
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
          _IdCounter++;
          monday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _mondayCounter += 2 : _mondayCounter++;
          notifyListeners();
          break;
        }
      case 1:
        {
          Key id = Key(_IdCounter.toString());
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_tuesdayCounter, doubleLesson, id);
          _IdList.add(id);
          context.read<FormDataRawBloc>().formDataRaw.add({
            "day": "tuesday",
            "id": id,
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
          _IdCounter++;
          tuesday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _tuesdayCounter += 2 : _tuesdayCounter++;
          notifyListeners();
          break;
        }
      case 2:
        {
          Key id = Key(_IdCounter.toString());
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_wednesdayCounter, doubleLesson, id);
          _IdList.add(id);
          context.read<FormDataRawBloc>().formDataRaw.add({
            "day": "wednesday",
            "id": id,
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
          _IdCounter++;
          wednesday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _wednesdayCounter += 2 : _wednesdayCounter++;
          notifyListeners();
          break;
        }
      case 3:
        {
          Key id = Key(_IdCounter.toString());
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_thursdayCounter, doubleLesson, id);
          _IdList.add(id);
          context.read<FormDataRawBloc>().formDataRaw.add({
            "day": "thursday",
            "id": id,
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
          _IdCounter++;
          thursday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _thursdayCounter += 2 : _thursdayCounter++;
          notifyListeners();
          break;
        }
      case 4:
        {
          Key id = Key(_IdCounter.toString());
          TimeTableEditTableRows timeTableEditTableRows =
              TimeTableEditTableRows(_fridayCounter, doubleLesson, id);
          _IdList.add(id);
          context.read<FormDataRawBloc>().formDataRaw.add({
            "day": "friday",
            "id": id,
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
          _IdCounter++;
          friday.add(timeTableEditTableRows.elementsToADD());
          doubleLesson ? _fridayCounter += 2 : _fridayCounter++;
          notifyListeners();
          break;
        }
    }
  }

  void removeLast(int i, BuildContext context) {
    switch (i) {
      case 0:
        {
          final key = monday.last.key;
          // print(key.toString()+"=::"+context.read<FormDataRawBloc>().formDataRaw.length.toString());
          if (monday.last.children[1].child.data.contains('/')) {
            monday.removeLast();
            _mondayCounter -= 2;
          } else {
            monday.removeLast();
            _mondayCounter--;
          }
          for (final day in context.read<FormDataRawBloc>().formDataRaw) {
            // print(key.toString()+"=?="+day["id"].toString());
            if (day["id"] == key) {
              context.read<FormDataRawBloc>().formDataRaw.remove(day);
              notifyListeners();
              break;
            }
          }
          notifyListeners();
          break;
        }
      case 1:
        {
          final key = tuesday.last.key;
          // print(key.toString()+"=::"+context.read<FormDataRawBloc>().formDataRaw.length.toString());
          if (tuesday.last.children[1].child.data.contains('/')) {
            tuesday.removeLast();
            _tuesdayCounter -= 2;
          } else {
            tuesday.removeLast();
            _tuesdayCounter--;
          }
          for (final day in context.read<FormDataRawBloc>().formDataRaw) {
            // print(key.toString()+"=?="+day["id"].toString());
            if (day["id"] == key) {
              context.read<FormDataRawBloc>().formDataRaw.remove(day);
              notifyListeners();
              break;
            }
          }
          notifyListeners();
          break;
        }
      case 2:
        {
          final key = wednesday.last.key;
          // print(key.toString()+"=::"+context.read<FormDataRawBloc>().formDataRaw.length.toString());
          if (wednesday.last.children[1].child.data.contains('/')) {
            wednesday.removeLast();
            _wednesdayCounter -= 2;
          } else {
            wednesday.removeLast();
            _wednesdayCounter--;
          }
          for (final day in context.read<FormDataRawBloc>().formDataRaw) {
            // print(key.toString()+"=?="+day["id"].toString());
            if (day["id"] == key) {
              context.read<FormDataRawBloc>().formDataRaw.remove(day);
              notifyListeners();
              break;
            }
          }
          notifyListeners();
          break;
        }
      case 3:
        {
          final key = thursday.last.key;
          // print(key.toString()+"=::"+context.read<FormDataRawBloc>().formDataRaw.length.toString());
          if (thursday.last.children[1].child.data.contains('/')) {
            thursday.removeLast();
            _thursdayCounter -= 2;
          } else {
            thursday.removeLast();
            _thursdayCounter--;
          }
          for (final day in context.read<FormDataRawBloc>().formDataRaw) {
            // print(key.toString()+"=?="+day["id"].toString());
            if (day["id"] == key) {
              context.read<FormDataRawBloc>().formDataRaw.remove(day);
              notifyListeners();
              break;
            }
          }
          notifyListeners();
          break;
        }
      case 4:
        {
          final key = friday.last.key;
          // print(key.toString()+"=::"+context.read<FormDataRawBloc>().formDataRaw.length.toString());
          if (friday.last.children[1].child.data.contains('/')) {
            friday.removeLast();
            _fridayCounter -= 2;
          } else {
            friday.removeLast();
            _fridayCounter--;
          }
          for (final day in context.read<FormDataRawBloc>().formDataRaw) {
            // print(key.toString()+"=?="+day["id"].toString());
            if (day["id"] == key) {
              context.read<FormDataRawBloc>().formDataRaw.remove(day);
              notifyListeners();
              break;
            }
          }
          notifyListeners();
          break;
        }
    }
  }
}
