import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
import 'package:Get_Table_App/widgets/generateTimeTable.dart';
import 'package:Get_Table_App/widgets/timeTableEdit.dart';
import 'package:Get_Table_App/widgets/timeTableToolRow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class TimeTable extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<TimeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: context.watch<UserBloc>().userTitle != null
              ? [
                  timeTableToolRow(context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Table(
                      border: TableBorder.all(),
                      children: generateTimeTable(context,
                          edit: context.watch<TimeTableItemsBlock>().edit),
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
                  Divider(),
                  context.watch<TimeTableItemsBlock>().edit
                      ? TimeTableEdit()
                      : Container(),
                ]
              : [
                  MaterialBanner(
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
                            MaterialPageRoute(
                              builder: (context) => Login(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  timeTableToolRow(context),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Table(
                      border: TableBorder.all(),
                      children: generateTimeTable(context,
                          edit: context.watch<TimeTableItemsBlock>().edit),
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
                  Divider(),
                  context.watch<TimeTableItemsBlock>().edit
                      ? TimeTableEdit()
                      : Container(),
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
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
