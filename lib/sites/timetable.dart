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
                                    .add(i, true);
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
                                    .add(i, false);
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
                                    .removeLast(i);
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
                  // return showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       // Retrieve the text the user has entered by using the
                  //       // TextEditingController.
                  //       content: Text("test"),
                  //     );
                  //   },
                  // );
                  print(context.read<TimeTableItemsBlock>().formDataRaw);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
