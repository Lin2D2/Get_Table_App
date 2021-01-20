import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/types/subjects.dart';
import 'package:get_table_app/types/teachers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectElement extends StatefulWidget {
  bool lessonSelected;
  bool teacherSelected;
  bool weekSelectedAB;
  int weekIndex;
  int subjectsIndex;
  int teachersIndex;
  int roomIndex;
  SelectElement(
      {Key key,
      @required this.lessonSelected,
      @required this.teacherSelected,
      @required this.weekSelectedAB,
      @required this.weekIndex,
      @required this.subjectsIndex,
      @required this.teachersIndex,
      @required this.roomIndex})
      : super(key: key);

  @override
  _SelectElementState createState() => _SelectElementState();
}

class _SelectElementState extends State<SelectElement> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!widget.lessonSelected)
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
                        initialItem: widget.weekIndex),
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
                    itemExtent: 30,
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
                      width: widget.lessonSelected ? 90 : 200,
                      height: 128,
                      child: CupertinoPicker.builder(
                        scrollController: FixedExtentScrollController(
                            initialItem: widget.subjectsIndex),
                        useMagnifier: true,
                        childCount: widget.lessonSelected
                            ? snapshot.data.subjectsShort.length
                            : snapshot.data.subjectsLong.length,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(widget.lessonSelected
                                ? snapshot.data.subjectsShort.elementAt(index)
                                : snapshot.data.subjectsLong.elementAt(index)),
                          );
                        },
                        itemExtent: 30,
                        onSelectedItemChanged: (selectedIndex) async {
                          setState(() {
                            widget.subjectsIndex = selectedIndex;
                          });
                          TimeTableItemsBlock itemsBlock =
                              context.read<TimeTableItemsBlock>();
                          Map day = itemsBlock
                              .copyTimeTable[itemsBlock.selectedElement["day"]];
                          String lesson = itemsBlock.selectedElement["lesson"];
                          Subjects _subject = await itemsBlock.subjects;
                          if (day.containsKey(lesson)) {
                            if (day[lesson].containsKey("subject")) {
                              day[lesson]["subject"] = _subject.subjectsShort
                                  .elementAt(selectedIndex);
                            } else {
                              day[lesson].putIfAbsent(
                                  "subject",
                                  () => _subject.subjectsShort
                                      .elementAt(selectedIndex));
                            }
                          } else {
                            day.putIfAbsent(
                                lesson,
                                () => {
                                      "subject": _subject.subjectsShort
                                          .elementAt(selectedIndex)
                                    });
                          }
                          print(itemsBlock.copyTimeTable);
                          if (widget.lessonSelected) {
                            // TODO dosent set rerenders maybe just lock the subjects scroll when in teacher selection
                            setState(() {
                              widget.teachersIndex = 0;
                            });
                            Teachers teachers = await context
                                .read<TimeTableItemsBlock>()
                                .teachers;
                            Subjects subjects = await context
                                .read<TimeTableItemsBlock>()
                                .subjects;
                            String subject = subjects.subjectsLong
                                .elementAt(widget.subjectsIndex);
                            List filteredTeachers = [];
                            for (final teacher in teachers.teachers) {
                              if (teacher["subjects"].length > 0) {
                                if (teacher["subjects"].contains(subject)) {
                                  filteredTeachers.add(teacher);
                                }
                              }
                            }
                            context
                                .read<TimeTableItemsBlock>()
                                .filteredTeachers = filteredTeachers;
                          }
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
          if (widget.lessonSelected)
            Column(
              children: [
                Container(
                  width: 90,
                  height: 20,
                  child: Center(
                    child: Text("teacher"),
                  ),
                ),
                Container(
                  width: widget.teacherSelected ? 90 : 200,
                  height: 128,
                  child: CupertinoPicker.builder(
                    scrollController: FixedExtentScrollController(
                        initialItem: widget.teachersIndex),
                    useMagnifier: true,
                    childCount: context
                        .watch<TimeTableItemsBlock>()
                        .filteredTeachers
                        .length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(widget.teacherSelected
                            ? context
                                .read<TimeTableItemsBlock>()
                                .filteredTeachers
                                .elementAt(index)["name"]["short"]
                            : context
                                .read<TimeTableItemsBlock>()
                                .filteredTeachers
                                .elementAt(index)["name"]["long"]),
                      );
                    },
                    itemExtent: 30,
                    onSelectedItemChanged: (selectedIndex) async {
                      setState(() {
                        widget.teachersIndex = selectedIndex;
                      });
                      TimeTableItemsBlock itemsBlock =
                          context.read<TimeTableItemsBlock>();
                      Map day = itemsBlock
                          .copyTimeTable[itemsBlock.selectedElement["day"]];
                      String lesson = itemsBlock.selectedElement["lesson"];
                      Teachers _teachers = await itemsBlock.teachers;
                      if (day.containsKey(lesson)) {
                        if (day[lesson].containsKey("teacher")) {
                          day[lesson]["teacher"] = _teachers.teachers
                              .elementAt(selectedIndex)["name"]["short"];
                        } else {
                          day[lesson].addAll({
                            "teacher": _teachers.teachers
                                .elementAt(selectedIndex)["name"]["short"]
                          });
                        }
                      } else {
                        day.addAll({
                          lesson: {
                            "teacher": _teachers.teachers
                                .elementAt(selectedIndex)["name"]["short"]
                          }
                        });
                      }
                      print(itemsBlock.copyTimeTable);
                    },
                  ),
                ),
              ],
            ),
          if (widget.teacherSelected)
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
                        initialItem: widget.roomIndex),
                    useMagnifier: true,
                    childCount:
                        context.watch<TimeTableItemsBlock>().rooms.length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(context
                            .read<TimeTableItemsBlock>()
                            .rooms
                            .elementAt(index)),
                      );
                    },
                    itemExtent: 30,
                    onSelectedItemChanged: (selectedIndex) {
                      setState(() {
                        widget.roomIndex = selectedIndex;
                      });
                      TimeTableItemsBlock itemsBlock =
                          context.read<TimeTableItemsBlock>();
                      Map day = itemsBlock
                          .copyTimeTable[itemsBlock.selectedElement["day"]];
                      String lesson = itemsBlock.selectedElement["lesson"];

                      print(itemsBlock.copyTimeTable);
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
