import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTableEdit extends StatefulWidget {
  @override
  State createState() => new _TimeTableEditState();
}

class _TimeTableEditState extends State<TimeTableEdit> {
  // TODO screen with smaller 375 brakes the Layout
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return SizedBox(
      height: 300,
      width: width,
      // context.read<TimeTableItemsBlock>().copyTimeTable
      child: Container(
        child: Column(
          children: context
              .watch<TimeTableItemsBlock>()
              .selectedElement == null
              ? [
            TimeTableEditAddRow(),
            Divider(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Select a lesson to edit it",
                ),
              ),
            ),
          ]
              : [
            TimeTableEditAddRow(),
            Divider(),
            Center(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  context
                      .watch<TimeTableItemsBlock>()
                      .selectedElement["day"] +
                      " lesson: " +
                      context
                          .watch<TimeTableItemsBlock>()
                          .selectedElement["lesson"],
                ),
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80,
                  child: Center(
                    child: Text("week"),
                  ),
                ),
                Container(
                  width: 90,
                  child: Center(
                    child: Text("subject"),
                  ),
                ),
                Container(
                  width: 90,
                  child: Center(
                    child: Text("room"),
                  ),
                ),
                Container(
                  width: 90,
                  child: Center(
                    child: Text("teacher"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 80,
                    child: CupertinoPicker.builder(
                      useMagnifier: true,
                      childCount: 3,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Text("A/B");
                          case 1:
                            return Text("A");
                          case 2:
                            return Text("B");
                          default:
                            return Text("");
                            break;
                        }
                      },
                      itemExtent: 20,
                      onSelectedItemChanged: (selectedIndex) {
                        switch (selectedIndex) {
                          case 0:
                            print("A/B");
                            break;
                          case 1:
                            print("A");
                            break;
                          case 2:
                            print("B");
                            break;
                          default:
                            print(selectedIndex);
                            break;
                        }
                      },
                    ),
                  ),
                  // TODO Problem: CupertinoPicker only updates on scroll
                  Container(
                    width: 90,
                    child: CupertinoPicker.builder(
                      useMagnifier: true,
                      childCount: context
                          .watch<TimeTableItemsBlock>()
                          .subjects
                          .length,
                      itemBuilder: (context, index) {
                        return Text(context
                            .read<TimeTableItemsBlock>()
                            .subjects
                            .elementAt(index));
                      },
                      itemExtent: 20,
                      onSelectedItemChanged: (selectedIndex) {
                        print(selectedIndex);
                        final watch = context.read<TimeTableItemsBlock>();
                        final lesson = watch.selectedElement["lesson"];
                        Map day = watch
                            .copyTimeTable[watch.selectedElement["day"]];
                        if (day.containsKey(lesson)) {
                          if (day[lesson].containsKey("subject")) {
                            day[lesson]["subject"] =
                                watch.subjects.elementAt(selectedIndex);
                          } else {
                            day[lesson].addAll({
                              "subject": watch.subjects.elementAt(selectedIndex)
                            });
                          }
                        } else {
                          print(selectedIndex.runtimeType);
                          day.addAll({
                            lesson: {
                              "subject":
                              watch.subjects.elementAt(selectedIndex)
                            }
                          });
                        }
                        print(watch.copyTimeTable);
                      },
                    ),
                  ),
                  Container(
                    width: 90,
                    child: CupertinoPicker.builder(
                      useMagnifier: true,
                      childCount: context
                          .watch<TimeTableItemsBlock>()
                          .rooms
                          .length,
                      itemBuilder: (context, index) {
                        return Text(context
                            .read<TimeTableItemsBlock>()
                            .rooms
                            .elementAt(index));
                      },
                      itemExtent: 20,
                      onSelectedItemChanged: (selectedIndex) {
                        print(selectedIndex);
                        final watch = context.read<TimeTableItemsBlock>();
                        final lesson = watch.selectedElement["lesson"];
                        Map day = watch
                            .copyTimeTable[watch.selectedElement["day"]];
                        if (day.containsKey(lesson)) {
                          if (day[lesson].containsKey("room")) {
                            day[lesson]["room"] =
                                watch.rooms.elementAt(selectedIndex);
                          } else {
                            day[lesson].addAll({
                              "room": watch.rooms.elementAt(selectedIndex)
                            });
                          }
                        } else {
                          print(selectedIndex.runtimeType);
                          day.addAll({
                            lesson: {
                              "room":
                              watch.rooms.elementAt(selectedIndex)
                            }
                          });
                        }
                        print(watch.copyTimeTable);
                      },
                    ),
                  ),
                  Container(
                    width: 90,
                    child: CupertinoPicker.builder(
                      useMagnifier: true,
                      childCount: context
                          .watch<TimeTableItemsBlock>()
                          .teacher
                          .length,
                      itemBuilder: (context, index) {
                        return Text(context
                            .read<TimeTableItemsBlock>()
                            .teacher
                            .elementAt(index));
                      },
                      itemExtent: 20,
                      onSelectedItemChanged: (selectedIndex) {
                        print(selectedIndex);
                        final watch = context.read<TimeTableItemsBlock>();
                        final lesson = watch.selectedElement["lesson"];
                        Map day = watch
                            .copyTimeTable[watch.selectedElement["day"]];
                        if (day.containsKey(lesson)) {
                          if (day[lesson].containsKey("teacher")) {
                            day[lesson]["teacher"] =
                                watch.teacher.elementAt(selectedIndex);
                          } else {
                            day[lesson].addAll({
                              "teacher": watch.teacher.elementAt(selectedIndex)
                            });
                          }
                        } else {
                          print(selectedIndex.runtimeType);
                          day.addAll({
                            lesson: {
                              "teacher":
                              watch.teacher.elementAt(selectedIndex)
                            }
                          });
                        }
                        print(watch.copyTimeTable);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeTableEditAddRow extends StatefulWidget {
  TimeTableEditAddRow({Key key});

  @override
  State createState() => new _TimeTableEditAddRowState();
}

class _TimeTableEditAddRowState extends State<TimeTableEditAddRow> {
  // TODO screen with smaller 375 brakes the Layout
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    TextEditingController _subjectController = TextEditingController();
    TextEditingController _roomController = TextEditingController();
    TextEditingController _teacherController = TextEditingController();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: width / 4,
          height: 50,
          child: Column(
            children: [
              Text("add subject"),
              Row(
                children: [
                  Container(
                    width: width / 7,
                    height: 30,
                    child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: _subjectController,
                      onSubmitted: (value) {
                        if (value.length > 0 && value.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('added'),
                            ),
                          );
                          context
                              .read<TimeTableItemsBlock>()
                              .subjectsAdd(value);
                          print(context
                              .read<TimeTableItemsBlock>()
                              .subjects);
                        } else if (value.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Enter some Text'),
                            ),
                          );
                        } else if (value.length > 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Input can't be longer than 2"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 30,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: Text("add"),
                      onPressed: () {
                        if (_subjectController.text.length > 0 &&
                            _subjectController.text.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Changed'),
                            ),
                          );
                          context
                              .read<TimeTableItemsBlock>()
                              .subjectsAdd(_subjectController.text);
                        } else if (_subjectController.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Enter some Text'),
                            ),
                          );
                        } else if (_subjectController.text.length > 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Input can't be longer than 2"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: width / 4,
          height: 50,
          child: Column(
            children: [
              Text("add room"),
              Row(
                children: [
                  Container(
                    width: width / 7,
                    height: 30,
                    child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: _roomController,
                      onSubmitted: (value) {
                        if (value.length > 0 && value.length < 4) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('added'),
                            ),
                          );
                          context.read<TimeTableItemsBlock>().roomsAdd(value);
                        } else if (value.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Enter some Text'),
                            ),
                          );
                        } else if (value.length > 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Input can't be longer than 3"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 30,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: Text("add"),
                      onPressed: () {
                        if (_roomController.text.length > 0 &&
                            _roomController.text.length < 4) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Changed'),
                            ),
                          );
                          context
                              .read<TimeTableItemsBlock>()
                              .roomsAdd(_roomController.text);
                        } else if (_roomController.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Enter some Text'),
                            ),
                          );
                        } else if (_roomController.text.length > 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Input can't be longer than 3"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: width / 4,
          height: 50,
          child: Column(
            children: [
              Text("add teacher"),
              Row(
                children: [
                  Container(
                    width: width / 7,
                    height: 30,
                    child: TextField(
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: _teacherController,
                      onSubmitted: (value) {
                        if (value.length > 0 && value.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('added'),
                            ),
                          );
                          context.read<TimeTableItemsBlock>().teacherAdd(value);
                        } else if (value.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Enter some Text'),
                            ),
                          );
                        } else if (value.length > 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Input can't be longer than 2"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 30,
                    child: FlatButton(
                      padding: EdgeInsets.all(0.0),
                      child: Text("add"),
                      onPressed: () {
                        if (_teacherController.text.length > 0 &&
                            _teacherController.text.length < 3) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Changed'),
                            ),
                          );
                          context
                              .read<TimeTableItemsBlock>()
                              .teacherAdd(_teacherController.text);
                        } else if (_teacherController.text.length == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Enter some Text'),
                            ),
                          );
                        } else if (_teacherController.text.length > 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Input can't be longer than 2"),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
