import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/types/subjects.dart';
import 'package:Get_Table_App/types/teachers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTableEdit extends StatefulWidget {
  @override
  State createState() => new _TimeTableEditState();
}

class _TimeTableEditState extends State<TimeTableEdit> {
  // TODO screen with smaller 375 brakes the Layout
  bool _lessonSelected = false;
  bool _teacherSelected = false;
  bool _weekSelectedAB = true;
  int _weekIndex = 0;
  int _subjectsIndex = 0;
  int _teachersIndex = 0;
  int _roomIndex = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 200,
      width: width,
      child: Container(
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
                      width: 85,
                      height: 20,
                    ),
                  if (_lessonSelected)
                    Container(
                      width: 80,
                      height: 20,
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
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      context
                              .watch<TimeTableItemsBlock>()
                              .selectedElement["day"] +
                          (MediaQuery.of(context).size.width < 365
                              ? " class: "
                              : " lesson") +
                          context
                              .watch<TimeTableItemsBlock>()
                              .selectedElement["lesson"],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 20,
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
                          : () {
                              if (!_lessonSelected) {
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
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (!_lessonSelected)
                      Column(
                        children: [
                          Container(
                            width: 80,
                            height: 20,
                            child: Center(
                              child: Text("week"),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 128,
                            child: CupertinoPicker.builder(
                              scrollController: FixedExtentScrollController(
                                  initialItem: _weekIndex),
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
                        ],
                      ),
                    // TODO Problem: CupertinoPicker only updates on scroll
                    Column(
                      children: [
                        Container(
                          width: 90,
                          height: 20,
                          child: Center(
                            child: Text("subject"),
                          ),
                        ),
                        FutureBuilder(
                          future: context.watch<TimeTableItemsBlock>().subjects,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: _lessonSelected ? 90 : 200,
                                height: 128,
                                child: CupertinoPicker.builder(
                                  scrollController: FixedExtentScrollController(
                                      initialItem: _subjectsIndex),
                                  useMagnifier: true,
                                  childCount: _lessonSelected
                                      ? snapshot.data.subjectsShort.length
                                      : snapshot.data.subjectsLong.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: Text(_lessonSelected
                                          ? snapshot.data.subjectsShort
                                              .elementAt(index)
                                          : snapshot.data.subjectsLong
                                              .elementAt(index)),
                                    );
                                  },
                                  itemExtent: 20,
                                  onSelectedItemChanged: (selectedIndex) async {
                                    setState(() {
                                      _subjectsIndex = selectedIndex;
                                    });
                                    TimeTableItemsBlock itemsBlock =
                                        context.read<TimeTableItemsBlock>();
                                    Map day = itemsBlock.copyTimeTable[
                                        itemsBlock.selectedElement["day"]];
                                    String lesson =
                                        itemsBlock.selectedElement["lesson"];
                                    Subjects _subject =
                                        await itemsBlock.subjects;
                                    if (day.containsKey(lesson)) {
                                      if (day[lesson].containsKey("subject")) {
                                        day[lesson]["subject"] = _subject
                                            .subjectsShort
                                            .elementAt(selectedIndex);
                                      } else {
                                        day[lesson].addAll({
                                          "subject": _subject.subjectsShort
                                              .elementAt(selectedIndex)
                                        });
                                      }
                                    } else {
                                      day.addAll({
                                        lesson: {
                                          "subject": _subject.subjectsShort
                                              .elementAt(selectedIndex)
                                        }
                                      });
                                    }
                                    print(itemsBlock.copyTimeTable);
                                  },
                                ),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ],
                    ),
                    if (_lessonSelected)
                      Column(
                        children: [
                          Container(
                            width: 90,
                            height: 20,
                            child: Center(
                              child: Text("teacher"),
                            ),
                          ),
                          FutureBuilder(
                            future:
                                context.watch<TimeTableItemsBlock>().teachers,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: _teacherSelected ? 90 : 200,
                                  height: 128,
                                  child: CupertinoPicker.builder(
                                    scrollController:
                                        FixedExtentScrollController(
                                            initialItem: _teachersIndex),
                                    useMagnifier: true,
                                    childCount: snapshot.data.teachers.length,
                                    itemBuilder: (context, index) {
                                      return Center(
                                        child: Text(_teacherSelected
                                            ? snapshot.data.teachers
                                                    .elementAt(index)["name"]
                                                ["short"]
                                            : snapshot.data.teachers
                                                    .elementAt(index)["name"]
                                                ["long"]),
                                      );
                                    },
                                    itemExtent: 20,
                                    onSelectedItemChanged:
                                        (selectedIndex) async {
                                      setState(() {
                                        _teachersIndex = selectedIndex;
                                      });
                                      TimeTableItemsBlock itemsBlock =
                                          context.read<TimeTableItemsBlock>();
                                      Map day = itemsBlock.copyTimeTable[
                                          itemsBlock.selectedElement["day"]];
                                      String lesson =
                                          itemsBlock.selectedElement["lesson"];
                                      Teachers _teachers =
                                          await itemsBlock.teachers;
                                      if (day.containsKey(lesson)) {
                                        if (day[lesson]
                                            .containsKey("teacher")) {
                                          day[lesson]["teacher"] =
                                              _teachers.teachers.elementAt(
                                                      selectedIndex)["name"]
                                                  ["short"];
                                        } else {
                                          day[lesson].addAll({
                                            "teacher": _teachers.teachers
                                                    .elementAt(
                                                        selectedIndex)["name"]
                                                ["short"]
                                          });
                                        }
                                      } else {
                                        day.addAll({
                                          lesson: {
                                            "teacher": _teachers.teachers
                                                    .elementAt(
                                                        selectedIndex)["name"]
                                                ["short"]
                                          }
                                        });
                                      }
                                      print(itemsBlock.copyTimeTable);
                                    },
                                  ),
                                );
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ],
                      ),
                    if (_teacherSelected)
                      Column(
                        children: [
                          Container(
                            width: 90,
                            height: 20,
                            child: Center(
                              child: Text("room"),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 128,
                            child: CupertinoPicker.builder(
                              scrollController: FixedExtentScrollController(
                                  initialItem: _roomIndex),
                              useMagnifier: true,
                              childCount: context
                                  .watch<TimeTableItemsBlock>()
                                  .rooms
                                  .length,
                              itemBuilder: (context, index) {
                                return Center(
                                  child: Text(context
                                      .read<TimeTableItemsBlock>()
                                      .rooms
                                      .elementAt(index)),
                                );
                              },
                              itemExtent: 20,
                              onSelectedItemChanged: (selectedIndex) {
                                setState(() {
                                  _roomIndex = selectedIndex;
                                });
                                TimeTableItemsBlock itemsBlock =
                                    context.read<TimeTableItemsBlock>();
                                Map day = itemsBlock.copyTimeTable[
                                    itemsBlock.selectedElement["day"]];
                                String lesson =
                                    itemsBlock.selectedElement["lesson"];

                                print(itemsBlock.copyTimeTable);
                              },
                            ),
                          ),
                        ],
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
