import 'package:Get_Table_App/blocs/indexMainBloc.dart';
import 'package:Get_Table_App/blocs/indexTimeTableBloc.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
import 'package:Get_Table_App/services/timetableService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTable extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: context.watch<IndexTimeTableBloc>().index,
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(),
              children: context.watch<UserBloc>().timetable != null
                  ? generateTable(context) : [],
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(4),
                2: FlexColumnWidth(4),
                3: FlexColumnWidth(4),
                4: FlexColumnWidth(4),
                5: FlexColumnWidth(4),
              },
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                context.read<IndexMainBloc>().set(3);
                Navigator.pushNamed(context, '/settings');
              },
            ),
            title: Center(
              child: const Text(
                'TimeTable',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "edit",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  context.read<IndexTimeTableBloc>().set(1);
                },
              ),
            ],
          ),
        ),
        Scaffold(
          body: Container(
            child: ListView(
              children: List.generate(
                context.watch<TimeTableItemsBlock>().daysString.length,
                (i) => Card(
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          context.watch<TimeTableItemsBlock>().daysString[i],
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Table(
                        border: TableBorder.all(),
                        children: context.watch<TimeTableItemsBlock>().days(i),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                            child: RaisedButton(
                              onPressed: () {
                                context
                                    .read<TimeTableItemsBlock>()
                                    .add(i, true, context);
                              },
                              child: Text("add double lesson"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                            child: RaisedButton(
                              // add new Row to Table
                              onPressed: () {
                                context
                                    .read<TimeTableItemsBlock>()
                                    .add(i, false, context);
                              },
                              child: Text("add single lesson"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                            child: RaisedButton(
                              // add new Row to Table
                              onPressed: () {
                                context
                                    .read<TimeTableItemsBlock>()
                                    .removeLast(i, context);
                              },
                              child: Text("remove"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
              child: const Text(
                'Edit Timetable',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                context.read<IndexTimeTableBloc>().set(0);
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "save",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  await TimeTableService.saveTimeTable(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

List<TableRow> generateTable(BuildContext context) {
  TextStyle headerStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle bodyStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  TableRow header = TableRow(
    decoration: BoxDecoration(
      color: Colors.grey[900],
    ),
    children: [
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
        ),
  );
  List lessons = [
    "1/2",
    "3/4",
    "5/6",
    "7/8",
    "9/10",
  ];
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
      }
      else {
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

  List<TableRow> tableItems = List.generate(
    lessons.length,
    (upperIndex) => TableRow(
      children: [
            Text(
              lessons[upperIndex],
              textAlign: TextAlign.center,
              style: bodyStyle,
            ),
          ] +
          List.generate(
            //context.watch<UserBloc>().timetable.keys.length,
            5,
            (lowerIndex) => findRightElement(context, upperIndex, lowerIndex),
          ),
    ),
  );
  tableItems.insert(0, header);

  return tableItems;
}
