import 'package:Get_Table_App/blocs/formDataRawBloc.dart';
import 'package:Get_Table_App/blocs/indexMainBloc.dart';
import 'package:Get_Table_App/blocs/indexTimeTableBloc.dart';
import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class TimeTable extends StatefulWidget {
//   @override
//   State createState() => new DynamicList();
// }
//
// class DynamicList extends State<TimeTable> {

class TimeTable extends StatelessWidget {
  const TimeTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: context.watch<IndexTimeTableBloc>().index,
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child:
                Table(), // TODO create Table from data of TableEdit or Database
          ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              // TODO add link to settings page
              onPressed: () {
                context.read<IndexMainBloc>().set(3);
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
                onPressed: () {
                  // print(context.read<FormDataRawBloc>().formDataRaw);
                  // TODO do api call and local call to save data local and to database
                  // TODO need to implement User class and login
                  List _monday = [];
                  List _tuesday = [];
                  List _wednesday = [];
                  List _thursday = [];
                  List _friday = [];
                  for (final day
                      in context.read<FormDataRawBloc>().formDataRaw) {
                    print(day["day"]);
                    switch (day["day"]) {
                      case "monday":
                        {
                          _monday.add({
                            "week": day["dropdown"].value,
                            "lesson": day["lesson"].text,
                            "subject": day["controller"][0].text,
                            "room": day["controller"][1].text,
                          });
                          break;
                        }
                      case "tuesday":
                        {
                          _tuesday.add({
                            "week": day["dropdown"].value,
                            "lesson": day["lesson"].text,
                            "subject": day["controller"][0].text,
                            "room": day["controller"][1].text,
                          });
                          break;
                        }
                      case "wednesday":
                        {
                          _wednesday.add({
                            "week": day["dropdown"].value,
                            "lesson": day["lesson"].text,
                            "subject": day["controller"][0].text,
                            "room": day["controller"][1].text,
                          });
                          break;
                        }
                      case "thursday":
                        {
                          _thursday.add({
                            "week": day["dropdown"].value,
                            "lesson": day["lesson"].text,
                            "subject": day["controller"][0].text,
                            "room": day["controller"][1].text,
                          });
                          break;
                        }
                      case "friday":
                        {
                          _friday.add({
                            "week": day["dropdown"].value,
                            "lesson": day["lesson"].text,
                            "subject": day["controller"][0].text,
                            "room": day["controller"][1].text,
                          });
                          break;
                        }
                    }
                  }
                  Map Timetable = {
                    "monday": _monday,
                    "tuesday": _tuesday,
                    "wednesday": _wednesday,
                    "thursday": _thursday,
                    "friday": _friday
                  };
                  print(Timetable);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
