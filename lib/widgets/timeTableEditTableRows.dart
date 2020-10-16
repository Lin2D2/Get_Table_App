import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Get_Table_App/widgets/weekDropdownButton.dart';
import 'package:Get_Table_App/blocs/dropdownMenuBloc.dart';


class TimeTableEditTableRows {
  int lessonCounter;
  bool doubleLesson;
  Key id;
  TextEditingController subjectController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  WeekDropdownButton weekDropdownButton = WeekDropdownButton();

  TimeTableEditTableRows(int lessonCounter, bool doubleLesson, Key id) {
    this.lessonCounter = lessonCounter;
    this.doubleLesson  = doubleLesson;
    this.id = id;
  }

  TableRow elementsToADD() {
    return TableRow(
      key: this.id,
      children: [
        ChangeNotifierProvider(
          create: (_) => DropdownMenuBloc(),
          child: Container(
            height: 30,
            child: this.weekDropdownButton,
          ),
        ),
        Container(
          height: 30,
          child: this.lessonCounter.isEven
              ? Text(
            this.lessonCounter.toString(),
            textAlign: TextAlign.center,
            style:
            TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
          )
              : Text(
            this.doubleLesson
                ? this.lessonCounter.toString() +
                "/" +
                (this.lessonCounter + 1).toString()
                : this.lessonCounter.toString(),
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
            controller: subjectController,
          ),
        ),
        Container(
          height: 30,
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
            controller: roomController,
          ),
        ),
      ],
    );
  }
}