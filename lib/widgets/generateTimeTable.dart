import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List lessons = [
  "1/2",
  "3/4",
  "5/6",
  "7/8",
  "9/10",
];

List<TableRow> generateTimeTable(BuildContext context, {int dayOfWeek, bool today}) {
  TextStyle headerStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle bodyStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  TableRow header = TableRow(
      decoration: BoxDecoration(
        color: Colors.grey[900],
      ),
      children: today == null
          ? ([
                Text(
                  "lesson",
                  textAlign: TextAlign.center,
                  style: headerStyle,
                ),
              ] +
              List.generate(
                context.watch<UserBloc>().timetable.keys.length,
                (index) => Text(
                  context.watch<UserBloc>().timetable.keys.elementAt(index),
                  textAlign: TextAlign.center,
                  style: headerStyle,
                ),
              ))
          : List.generate(
              lessons.length,
              (index) => Text(
                lessons.elementAt(index),
                textAlign: TextAlign.center,
                style: headerStyle,
              ),
            ));
  Widget findRightElement(
      BuildContext context, int upperIndex, int lowerIndex) {
    Map day = context.watch<UserBloc>().timetable[
        context.watch<UserBloc>().timetable.keys.elementAt(lowerIndex)];
    Widget result;
    for (final lesson in day.keys) {
      if (lessons.elementAt(upperIndex) == lesson) {
        result = Text(
          day[lesson]["subject"],
          textAlign: TextAlign.center,
          style: bodyStyle,
        );
        break;
      } else {
        // TODO show column for non double lessons
        result = Text(
          "",
          textAlign: TextAlign.center,
          style: bodyStyle,
        );
      }
    }
    Text(
      "",
      textAlign: TextAlign.center,
      style: bodyStyle,
    );
    return result;
  }

  List<TableRow> tableItems = [
    header,
  ];
  int index = 0;
  if (today == null) {
    for (final lesson in lessons) {
      tableItems.add(
        TableRow(
          children: [
                Text(
                  lesson,
                  textAlign: TextAlign.center,
                  style: bodyStyle,
                ),
              ] +
              List.generate(
                //context.watch<UserBloc>().timetable.keys.length,
                5,
                (lowerIndex) => findRightElement(context, index, lowerIndex),
              ),
          decoration: BoxDecoration(
            color: index.isEven
                ? Color.fromRGBO(250, 211, 166, 1)
                : Color.fromRGBO(253, 236, 217, 1),
          ),
        ),
      );
      index++;
    }
  } else {
    tableItems.add(
      TableRow(
        children: List.generate(
          //context.watch<UserBloc>().timetable.keys.length,
          5,
          (upperIndex) => findRightElement(
              context, upperIndex, dayOfWeek - 1),
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(250, 211, 166, 1),
        ),
      ),
    );
  }
  return tableItems;
}
