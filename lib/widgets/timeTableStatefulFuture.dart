import 'package:Get_Table_App/services/dayOfWeek.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:flutter/material.dart';

import 'createCard.dart';
import 'generateTimeTable.dart';

class TimeTableFuture extends StatefulWidget {
  final Future futureObject;
  final bool today;

  TimeTableFuture({Key key, @required this.futureObject, @required this.today})
      : super(key: key);

  @override
  State createState() => new _TimeTableFutureState();
}

class _TimeTableFutureState extends State<TimeTableFuture> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Day>(
      future: widget.futureObject,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String weekday = snapshot.data.day["title"].toString().split(" ")[1];
          return createCard(
            context,
            Table(
              border: TableBorder.all(),
              children: generateTimeTable(context,
                  dayOfWeek: getdayOfWeek(weekDay: weekday),
                  today: widget.today),
            ),
            title: "TimeTable " + weekday,
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return createCard(
            context,
            Center(
              child: Text(
                "Sever not reachable",
                style: TextStyle(color: Colors.red),
              ),
            ),
            title: "TimeTable Tomorow",
          );
        }
        return createCard(
          context,
          Center(
            child: CircularProgressIndicator(),
          ),
          title: "TimeTable Tomorow",
        );
      },
    );
  }
}
