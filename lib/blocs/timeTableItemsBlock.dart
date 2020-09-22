import 'package:Get_Table_App/blocs/dropdownMenuBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTableItemsBlock extends ChangeNotifier {
  int _mondayCounter = 1;
  int _tuesdayCounter = 1;
  int _wednesdayCounter = 1;
  int _thursdayCounter = 1;
  int _fridayCounter = 1;
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

  void add(int i, bool doubleLesson) {
    switch (i) {
      case 0:
        {
          monday.add(elementsToADD(_mondayCounter, doubleLesson));
          doubleLesson ? _mondayCounter += 2 : _mondayCounter++;
          notifyListeners();
          break;
        }
      case 1:
        {
          tuesday.add(elementsToADD(_tuesdayCounter, doubleLesson));
          doubleLesson ? _tuesdayCounter += 2 : _tuesdayCounter++;
          notifyListeners();
          break;
        }
      case 2:
        {
          wednesday.add(elementsToADD(_wednesdayCounter, doubleLesson));
          doubleLesson ? _wednesdayCounter += 2 : _wednesdayCounter++;
          notifyListeners();
          break;
        }
      case 3:
        {
          thursday.add(elementsToADD(_thursdayCounter, doubleLesson));
          doubleLesson ? _thursdayCounter += 2 : _thursdayCounter++;
          notifyListeners();
          break;
        }
      case 4:
        {
          friday.add(elementsToADD(_fridayCounter, doubleLesson));
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
          if (monday.last.children.first.child.data.contains('/')) {
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
          if (tuesday.last.children.first.child.data.contains('/')) {
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
          if (wednesday.last.children.first.child.data.contains('/')) {
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
          if (thursday.last.children.first.child.data.contains('/')) {
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
          if (friday.last.children.first.child.data.contains('/')) {
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

TableRow headerRow() {
  return TableRow(
    decoration: BoxDecoration(
      color: Colors.grey[900],
    ),
    children: [
      Text(
        "week",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      ),
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

TableRow elementsToADD(int lessonCounter, bool doubleLesson) {
  return TableRow(
    children: [
      ChangeNotifierProvider(
        create: (_) => DropdownMenuBloc(),
        child: Container(
          height: 30,
          child: WeekDropdownButton(),
        ),
      ),
      Container(
        height: 30,
        child: lessonCounter.isEven
            ? Text(
                lessonCounter.toString(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
              )
            : Text(
                doubleLesson
                    ? lessonCounter.toString() +
                        "/" +
                        (lessonCounter + 1).toString()
                    : lessonCounter.toString(),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
              ),
      ),
      Container(
        height: 30,
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
        ),
      ),
      Container(
        height: 30,
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
        ),
      ),
    ],
  );
}

class WeekDropdownButton extends StatelessWidget {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.0,
        child: DropdownButton<String>(
          icon: Icon(Icons.assignment),
          iconSize: 24,
          elevation: 16,
          value: context.watch<DropdownMenuBloc>().value,
          onChanged: (String newValue) {
            context.read<DropdownMenuBloc>().set(newValue);
          },
          items: <String>["A/B", 'A', 'B'] // TODO add new line for A or B below for same lesson to set differnet week
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}
