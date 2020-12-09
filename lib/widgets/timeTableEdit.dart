import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTableEdit extends StatefulWidget {
  @override
  State createState() => new _TimeTableEditState();
}

class _TimeTableEditState extends State<TimeTableEdit> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 260,
      width: width,
      // context.read<TimeTableItemsBlock>().copyTimeTable
      child: Container(
        child: Column(
          children: context.watch<TimeTableItemsBlock>().selectedElement == null
              ? [
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
                          child: Text("lesson"),
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
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: width / 4,
                        height: 50,
                        child: Column(
                          children: [
                            Text("add lesson"),
                            Row(
                              children: [
                                Container(
                                  width: width / 7,
                                  height: 30,
                                  child: TextField(),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Text("add"),
                                    onPressed: () {},
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
                                  child: TextField(),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Text("add"),
                                    onPressed: () {},
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
                                  child: TextField(),
                                ),
                                Container(
                                  width: 40,
                                  height: 30,
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0.0),
                                    child: Text("add"),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
        ),
      ),
    );
  }
}
