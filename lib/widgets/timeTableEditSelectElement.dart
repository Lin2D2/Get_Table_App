import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/blocs/timeTableScrollerIndexes.dart';
import 'package:get_table_app/types/teachers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectElement extends StatefulWidget {
  final bool lessonSelected;
  final bool teacherSelected;
  final bool weekSelectedAB;
  final bool firstOrSecound;

  SelectElement({
    Key key,
    @required this.lessonSelected,
    @required this.teacherSelected,
    @required this.weekSelectedAB,
    @required this.firstOrSecound,
  }) : super(key: key);

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
                        initialItem: widget.firstOrSecound
                            ? context
                                .watch<TimeTableScrollerIndexes>()
                                .weekIndex
                            : context
                                .watch<TimeTableScrollerIndexes>()
                                .weekIndex2nd),
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
                      child: AbsorbPointer(
                        absorbing: widget.lessonSelected,
                        child: CupertinoPicker.builder(
                          scrollController: FixedExtentScrollController(
                              initialItem: widget.firstOrSecound
                                  ? context
                                      .watch<TimeTableScrollerIndexes>()
                                      .subjectsIndex
                                  : context
                                      .watch<TimeTableScrollerIndexes>()
                                      .subjectsIndex2nd),
                          useMagnifier: true,
                          childCount: widget.lessonSelected
                              ? snapshot.data.subjectsShort.length
                              : snapshot.data.subjectsLong.length,
                          itemBuilder: (context, index) {
                            return widget.lessonSelected
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      (widget.firstOrSecound
                                              ? index ==
                                                  context
                                                      .read<
                                                          TimeTableScrollerIndexes>()
                                                      .subjectsIndex
                                              : index ==
                                                  context
                                                      .read<
                                                          TimeTableScrollerIndexes>()
                                                      .subjectsIndex2nd)
                                          ? Container(
                                              width: 30,
                                              child: Icon(Icons.lock),
                                            )
                                          : Container(
                                              width: 30,
                                            ),
                                      Container(
                                        width: 50,
                                        child: Text(snapshot.data.subjectsShort
                                            .elementAt(index)),
                                      )
                                    ],
                                  )
                                : Text(snapshot.data.subjectsLong
                                    .elementAt(index));
                          },
                          itemExtent: 30,
                          onSelectedItemChanged: (selectedIndex) {
                            setState(() {
                              widget.firstOrSecound
                                  ? context
                                      .read<TimeTableScrollerIndexes>()
                                      .subjectsIndex = selectedIndex
                                  : context
                                      .read<TimeTableScrollerIndexes>()
                                      .subjectsIndex2nd = selectedIndex;
                            });
                          },
                        ),
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
                  child: AbsorbPointer(
                    absorbing: widget.teacherSelected,
                    child: CupertinoPicker.builder(
                      scrollController: FixedExtentScrollController(
                          initialItem: widget.firstOrSecound
                              ? context
                                  .watch<TimeTableScrollerIndexes>()
                                  .teachersIndex
                              : context
                                  .watch<TimeTableScrollerIndexes>()
                                  .teachersIndex2nd),
                      useMagnifier: true,
                      childCount: widget.firstOrSecound
                          ? context
                              .watch<TimeTableItemsBlock>()
                              .filteredTeachers
                              .length
                          : context
                              .watch<TimeTableItemsBlock>()
                              .filteredTeachers2nd
                              .length,
                      itemBuilder: (context, index) {
                        return widget.teacherSelected
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  (widget.firstOrSecound
                                          ? index ==
                                              context
                                                  .read<
                                                      TimeTableScrollerIndexes>()
                                                  .teachersIndex
                                          : index ==
                                              context
                                                  .read<
                                                      TimeTableScrollerIndexes>()
                                                  .teachersIndex2nd)
                                      ? Container(
                                          width: 30,
                                          child: Icon(Icons.lock),
                                        )
                                      : Container(
                                          width: 30,
                                        ),
                                  Container(
                                    width: 50,
                                    child: Text(
                                      widget.firstOrSecound
                                          ? context
                                              .read<TimeTableItemsBlock>()
                                              .filteredTeachers
                                              .elementAt(index)["name"]["short"]
                                          : context
                                                  .read<TimeTableItemsBlock>()
                                                  .filteredTeachers2nd
                                                  .elementAt(index)["name"]
                                              ["short"],
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  widget.firstOrSecound
                                      ? context
                                          .read<TimeTableItemsBlock>()
                                          .filteredTeachers
                                          .elementAt(index)["name"]["long"]
                                      : context
                                          .read<TimeTableItemsBlock>()
                                          .filteredTeachers2nd
                                          .elementAt(index)["name"]["long"],
                                ),
                              );
                      },
                      itemExtent: 30,
                      onSelectedItemChanged: (selectedIndex) async {
                        setState(() {
                          widget.firstOrSecound
                              ? context
                                  .read<TimeTableScrollerIndexes>()
                                  .teachersIndex = selectedIndex
                              : context
                                  .read<TimeTableScrollerIndexes>()
                                  .teachersIndex2nd = selectedIndex;
                        });
                      },
                    ),
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
                        initialItem: widget.firstOrSecound
                            ? context
                                .watch<TimeTableScrollerIndexes>()
                                .roomIndex
                            : context
                                .watch<TimeTableScrollerIndexes>()
                                .roomIndex2nd),
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
                        widget.firstOrSecound
                            ? context
                                .read<TimeTableScrollerIndexes>()
                                .roomIndex = selectedIndex
                            : context
                                .read<TimeTableScrollerIndexes>()
                                .roomIndex2nd = selectedIndex;
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
