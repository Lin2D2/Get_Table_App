import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List doubleLessons = [
  "1/2",
  "3/4",
  "5/6",
  "7/8",
  "9/10",
];

List singleLessons = [
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
];

List<TableRow> generateTimeTable(BuildContext context,
    {int dayOfWeek, bool today, bool edit}) {
  TextStyle headerStyle =
      TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle bodyStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  double _screenWidth = MediaQuery.of(context).size.width;
  List _weekDays = [];
  if (_screenWidth < 365) {
    context.watch<UserBloc>().timetable.keys.toList().forEach((element) {
      _weekDays.add(element[0] + element[1] + element[2] + ".");
    });
  } else {
    _weekDays = context.watch<UserBloc>().timetable.keys.toList();
  }
  TableRow header = TableRow(
    decoration: BoxDecoration(
      color: Colors.grey[900],
    ),
    children: today == null
        ? ([
              TableCell(
                child: Text(
                  _screenWidth < 385 ? "class" : "lesson",
                  textAlign: TextAlign.center,
                  style: headerStyle,
                ),
              )
            ] +
            List.generate(
              _weekDays.length,
              (index) => TableCell(
                child: Text(
                  _weekDays.elementAt(index),
                  textAlign: TextAlign.center,
                  style: headerStyle,
                ),
              ),
            ))
        : List.generate(
            doubleLessons.length,
            (index) => TableCell(
              child: Text(
                doubleLessons.elementAt(index),
                textAlign: TextAlign.center,
                style: headerStyle,
              ),
            ),
          ),
  );
  List<TableRow> tableItems = [
    header,
  ];
  if (today == null) {
    Color tableColor = Color.fromRGBO(250, 211, 166, 1);
    Color tableSelectedColor = Color.fromRGBO(175, 147, 116, 1);
    double rowHeight = 40;
    List buildLessons = [[], [], [], [], []];
    Map timeTable = edit
        ? context.watch<TimeTableItemsBlock>().copyTimeTable
        : context.watch<UserBloc>().timetable;
    for (final doubleLesson in doubleLessons) {
      int dayIndex = 0;
      List<Widget> dayRowChildren = [
        TableCell(
          child: Container(
            height: rowHeight,
            color: tableColor,
            child: Column(
              children: [
                Text(
                  doubleLesson.split("/")[0],
                  textAlign: TextAlign.center,
                  style: bodyStyle,
                ),
                Text(
                  doubleLesson.split("/")[1],
                  textAlign: TextAlign.center,
                  style: bodyStyle,
                )
              ],
            ),
          ),
        )
      ];
      // // alternative
      // List<Widget> dayRowChildren = [
      //   TableCell(
      //     child:
      //         Text(
      //           doubleLesson,
      //           textAlign: TextAlign.center,
      //           style: bodyStyle,
      //         ),
      //     ),
      // ];
      for (final dayKey in timeTable.keys) {
        Map dayMap = timeTable[dayKey];
        for (final lessonKey in dayMap.keys) {
          if (doubleLesson == lessonKey && !buildLessons.contains(lessonKey)) {
            dayRowChildren.add(
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Container(
                  color: selected(edit, dayKey, doubleLesson, context)
                      ? tableSelectedColor
                      : tableColor,
                  height: rowHeight,
                  child: edit
                      ? FlatButton(
                          onPressed: () {
                            context
                                .read<TimeTableItemsBlock>()
                                .selectedElement = {
                              "day": dayKey,
                              "lesson": doubleLesson
                            };
                          },
                          child: Text(
                            dayMap[lessonKey]["subject"],
                            textAlign: TextAlign.center,
                            style: bodyStyle,
                          ),
                        )
                      : Center(
                          child: Text(
                            dayMap[lessonKey]["subject"],
                            textAlign: TextAlign.center,
                            style: bodyStyle,
                          ),
                        ),
                ),
              ),
            );
            buildLessons[dayIndex].add(lessonKey);
            break;
          } else if (singleLessons.contains(lessonKey) &&
              !buildLessons.contains(lessonKey) &&
              doubleLesson.toString().split("/").contains(lessonKey)) {
            dayRowChildren.add(
              TableCell(
                child: Container(
                  color: selected(edit, dayKey, doubleLesson, context)
                      ? tableSelectedColor
                      : tableColor,
                  height: rowHeight,
                  child: edit
                      ? FlatButton(
                          onPressed: () {
                            context
                                .read<TimeTableItemsBlock>()
                                .selectedElement = {
                              "day": dayKey,
                              "lesson": doubleLesson,
                            };
                          },
                          child: Column(
                            children: [
                              Text(
                                dayMap[lessonKey]["subject"],
                                textAlign: TextAlign.center,
                                style: bodyStyle,
                              ),
                              dayMap.keys.contains(
                                      (int.parse(lessonKey) + 1).toString())
                                  ? Text(
                                      dayMap[(int.parse(lessonKey) + 1)
                                          .toString()]["subject"],
                                      textAlign: TextAlign.center,
                                      style: bodyStyle,
                                    )
                                  : Text(
                                      "---",
                                      textAlign: TextAlign.center,
                                      style: bodyStyle,
                                    ),
                            ],
                          ),
                        )
                      : Center(
                          child: Column(
                            children: [
                              Text(
                                dayMap[lessonKey]["subject"],
                                textAlign: TextAlign.center,
                                style: bodyStyle,
                              ),
                              dayMap.keys.contains(
                                      (int.parse(lessonKey) + 1).toString())
                                  ? Text(
                                      dayMap[(int.parse(lessonKey) + 1)
                                          .toString()]["subject"],
                                      textAlign: TextAlign.center,
                                      style: bodyStyle,
                                    )
                                  : Text(
                                      "---",
                                      textAlign: TextAlign.center,
                                      style: bodyStyle,
                                    ),
                            ],
                          ),
                        ),
                ),
              ),
            );
            buildLessons[dayIndex].add(lessonKey);
            break;
          }
        }
        // -2 -> -1 of index to length and -1 of num of lesson beginning of each row
        if (dayRowChildren.length - 2 < dayIndex) {
          dayRowChildren.add(
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                color: selected(edit, dayKey, doubleLesson, context)
                    ? tableSelectedColor
                    : tableColor,
                height: rowHeight,
                child: edit
                    ? FlatButton(
                        onPressed: () {
                          context.read<TimeTableItemsBlock>().selectedElement =
                              {"day": dayKey, "lesson": doubleLesson};
                        },
                        child: Text(
                          "---",
                          textAlign: TextAlign.center,
                          style: bodyStyle,
                        ),
                      )
                    : Center(
                        child: Text(
                          "---",
                          textAlign: TextAlign.center,
                          style: bodyStyle,
                        ),
                      ),
              ),
            ),
          );
        }
        dayIndex++;
      }
      tableItems.add(
        TableRow(
          children: dayRowChildren,
          // decoration: BoxDecoration(
          //   color: tableColor,
          // ),
        ),
      );
    }
  } else {
    List<Widget> dayRowChildren = [];
    List buildLessons = [];
    Map dayMap = context.watch<UserBloc>().timetable[
// -1 because monday is 1 but the index is 0
        context.watch<UserBloc>().timetable.keys.elementAt(dayOfWeek - 1)];
    for (final doubleLesson in doubleLessons) {
      for (final lessonKey in dayMap.keys) {
        if (doubleLesson == lessonKey && !buildLessons.contains(doubleLesson)) {
          dayRowChildren.add(
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                dayMap[lessonKey]["subject"],
                textAlign: TextAlign.center,
                style: bodyStyle,
              ),
            ),
          );
          buildLessons.add(doubleLesson);
          break;
        } else if (singleLessons.contains(lessonKey) &&
            !buildLessons.contains(lessonKey) &&
            doubleLesson.toString().split("/").contains(lessonKey)) {
          dayRowChildren.add(
            TableCell(
              child: Column(
                children: [
                  Text(
                    dayMap.keys.contains((int.parse(lessonKey) + 1).toString())
                        ? dayMap[lessonKey]["subject"] +
                            " / " +
                            dayMap[(int.parse(lessonKey) + 1).toString()]
                                ["subject"]
                        : dayMap[lessonKey]["subject"] + " / ---",
                    textAlign: TextAlign.center,
                    style: bodyStyle,
                  ),
                ],
              ),
            ),
          );
          buildLessons.add(doubleLesson);
          break;
        }
      }
    }
    for (int i = doubleLessons.length - dayRowChildren.length; i > 0; i--) {
      if (dayRowChildren.length < doubleLessons.length) {
        dayRowChildren.add(
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              "---",
              textAlign: TextAlign.center,
              style: bodyStyle,
            ),
          ),
        );
      }
    }
    tableItems.add(
      TableRow(
        children: dayRowChildren,
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 211, 166, 1),
        ),
      ),
    );
  }
  return tableItems;
}

bool selected(bool edit, String dayKey, String lesson, BuildContext context) {
  if (edit && context.watch<TimeTableItemsBlock>().selectedElement != null) {
    return (context.watch<TimeTableItemsBlock>().selectedElement["day"] ==
            dayKey &&
        context.watch<TimeTableItemsBlock>().selectedElement["lesson"] ==
            lesson);
  } else {
    return false;
  }
}
