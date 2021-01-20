import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/types/subjects.dart';
import 'package:get_table_app/types/teachers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_table_app/widgets/timeTableEditSelectElement.dart';
import 'package:provider/provider.dart';

class TimeTableEdit extends StatefulWidget {
  @override
  State createState() => new _TimeTableEditState();
}

class _TimeTableEditState extends State<TimeTableEdit> {
  // TODO screen with smaller 375 brakes the Layout
  bool _doubleLesson = true;
  List<bool> _toggleButtonBoolList = [false, true];

  bool _lessonSelected = false;
  bool _teacherSelected = false;
  bool _weekSelectedAB = true;
  int _weekIndex = 0;
  int _subjectsIndex = 0;
  int _teachersIndex = 0;
  int _roomIndex = 0;

  bool _lessonSelected2nd = false;
  bool _teacherSelected2nd = false;
  bool _weekSelectedAB2nd = true;
  int _weekIndex2nd = 0;
  int _subjectsIndex2nd = 0;
  int _teachersIndex2nd = 0;
  int _roomIndex2nd = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: _doubleLesson ? 200 : 416,
      width: width,
      child: Column(
        children: <Widget>[
          if (context.watch<TimeTableItemsBlock>().selectedElement == null)
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Select a lesson to edit it",
                ),
              ),
            ),
          if (context.watch<TimeTableItemsBlock>().selectedElement != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!_lessonSelected)
                  Container(
                    width: 99,
                    height: 36,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text("1"),
                        Text("1/2"),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          if (index == 0) {
                            _doubleLesson = false;
                            _toggleButtonBoolList = [true, false];
                          } else {
                            _doubleLesson = true;
                            _toggleButtonBoolList = [false, true];
                          }
                        });
                      },
                      isSelected: _toggleButtonBoolList,
                    ),
                  ),
                if (_lessonSelected)
                  Container(
                    width: 99,
                    height: 36,
                    child: RaisedButton(
                      child: Text("back"),
                      onPressed: () {
                        if (_teacherSelected) {
                          setState(() {
                            _teacherSelected = false;
                          });
                        } else {
                          setState(() {
                            _lessonSelected = false;
                          });
                        }
                      },
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    (MediaQuery.of(context).size.width < 365
                            ? context
                                    .watch<TimeTableItemsBlock>()
                                    .selectedElement["day"][0] +
                                context
                                    .watch<TimeTableItemsBlock>()
                                    .selectedElement["day"][1] +
                                context
                                    .watch<TimeTableItemsBlock>()
                                    .selectedElement["day"][2] +
                                ". class: "
                            : context
                                    .watch<TimeTableItemsBlock>()
                                    .selectedElement["day"] +
                                " lesson: ") +
                        context
                            .watch<TimeTableItemsBlock>()
                            .selectedElement["lesson"],
                  ),
                ),
                Container(
                  width: 99,
                  height: 36,
                  child: RaisedButton(
                    child: Text(_lessonSelected && _teacherSelected
                        ? "finish"
                        : "next"),
                    onPressed: _lessonSelected && _teacherSelected
                        ? () {
                            context.read<UserBloc>().timetable = context
                                .read<TimeTableItemsBlock>()
                                .copyTimeTable;
                            context
                                .read<TimeTableItemsBlock>()
                                .selectedElement = null;
                            setState(() {
                              _roomIndex = 0;
                              _subjectsIndex = 0;
                              _teachersIndex = 0;
                              _weekIndex = 0;
                              _lessonSelected = false;
                              _teacherSelected = false;
                              _weekSelectedAB = true;
                            });
                          }
                        : () async {
                            if (!_lessonSelected) {
                              Teachers teachers = await context
                                  .read<TimeTableItemsBlock>()
                                  .teachers;
                              Subjects subjects = await context
                                  .read<TimeTableItemsBlock>()
                                  .subjects;
                              String subject = subjects.subjectsLong
                                  .elementAt(_subjectsIndex);
                              List filteredTeachers = [];
                              filteredTeachers
                                  .add(teachers.teachers.elementAt(0));
                              for (final teacher in teachers.teachers) {
                                if (teacher["subjects"].length > 0) {
                                  if (teacher["subjects"].contains(subject)) {
                                    filteredTeachers.add(teacher);
                                  } else if (subject == "Religion") {
                                    if (teacher["subjects"]
                                            .contains("kath. Religion") ||
                                        teacher["subjects"]
                                            .contains("ev. Religion")) {
                                      filteredTeachers.add(teacher);
                                    }
                                  }
                                }
                              }
                              context
                                  .read<TimeTableItemsBlock>()
                                  .filteredTeachers = filteredTeachers;
                              setState(() {
                                _lessonSelected = true;
                              });
                            } else {
                              setState(() {
                                _teacherSelected = true;
                              });
                            }
                          },
                  ),
                ),
              ],
            ),
          if (context.watch<TimeTableItemsBlock>().selectedElement != null)
            Divider(),
          if (context.watch<TimeTableItemsBlock>().selectedElement != null)
            SelectElement(
              lessonSelected: _lessonSelected,
              teacherSelected: _teacherSelected,
              weekSelectedAB: _weekSelectedAB,
              weekIndex: _weekIndex,
              subjectsIndex: _subjectsIndex,
              teachersIndex: _teachersIndex,
              roomIndex: _roomIndex,
            ),
          if (context.watch<TimeTableItemsBlock>().selectedElement != null &&
              !_doubleLesson)
            Container(
              child: Column(
                children: [
                  Divider(),
                  Row(
                    children: [
                      Container(
                        width: 99,
                        height: 36,
                        child: ToggleButtons(
                          children: <Widget>[
                            Text("2"),
                            Text("1/2"),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              if (index == 0) {
                                _doubleLesson = false;
                                _toggleButtonBoolList = [true, false];
                              } else {
                                _doubleLesson = true;
                                _toggleButtonBoolList = [false, true];
                              }
                            });
                          },
                          isSelected: _toggleButtonBoolList,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          if (context.watch<TimeTableItemsBlock>().selectedElement != null &&
              !_doubleLesson)
            SelectElement(
              lessonSelected: _lessonSelected2nd,
              teacherSelected: _teacherSelected2nd,
              weekSelectedAB: _weekSelectedAB2nd,
              weekIndex: _weekIndex2nd,
              subjectsIndex: _subjectsIndex2nd,
              teachersIndex: _teachersIndex2nd,
              roomIndex: _roomIndex2nd,
            ),
        ],
      ),
    );
  }
}
