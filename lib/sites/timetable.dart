import 'package:Get_Table_App/blocs/indexTimeTableBloc.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
import 'package:Get_Table_App/services/timetableService.dart';
import 'package:Get_Table_App/sites/settings.dart';
import 'package:Get_Table_App/widgets/generateTimeTable.dart';
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
            child: context.watch<UserBloc>().timetable != null
                ? Column(
                    children: [
                      MaterialBanner(
                        // TODO display A or B week here
                        content: Text(''),
                        actions: [
                          RaisedButton(
                            child: Chip(
                              avatar: Icon(Icons.edit),
                              label: Text("Edit"),
                            ),
                            onPressed: () {
                              context.read<IndexTimeTableBloc>().set(1);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Table(
                          border: TableBorder.all(),
                          children: context.watch<UserBloc>().timetable != null
                              ? generateTimeTable(context)
                              : [],
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
                    ],
                  )
                : MaterialBanner(
                    leading: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    content:
                        const Text('You have to Login to see content here'),
                    actions: [
                      RaisedButton(
                        child: Text("Login"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                      ),
                    ],
                  ),
          ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Center(
              child: const Text(
                'TimeTable',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
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
