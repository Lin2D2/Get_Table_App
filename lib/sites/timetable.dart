import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: context.watch<UserBloc>().userTitle != null
            ? Column(
                children: [
                  MaterialBanner(
                    // TODO display A or B week here
                    content: Text(''),
                    actions: [
                      RaisedButton(
                        child: Chip(
                          avatar: Icon(context.watch<TimeTableItemsBlock>().edit
                              ? Icons.save
                              : Icons.edit),
                          label: Text(context.watch<TimeTableItemsBlock>().edit
                              ? "Save"
                              : "Edit"),
                        ),
                        onPressed: context.watch<TimeTableItemsBlock>().edit
                            ? () {
                                // TODO need still to save data
                                context.read<TimeTableItemsBlock>().edit =
                                    false;
                              }
                            : () {
                                context.read<TimeTableItemsBlock>().edit = true;
                              },
                      ),
                    ],
                  ),
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Container(
                      child: Center(
                        child: Text(
                          context
                              .watch<TimeTableItemsBlock>()
                              .selectedElement
                              .toString(),
                        ),
                      ),
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            : MaterialBanner(
                leading: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
                content: const Text('You have to Login to see content here'),
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
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
