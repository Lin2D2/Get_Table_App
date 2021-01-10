import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/widgets/generateTimeTable.dart';
import 'package:get_table_app/widgets/timeTableEdit.dart';
import 'package:get_table_app/widgets/timeTableToolRow.dart';
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (sliverContext, innerBoxScrolled) => [
          SliverAppBar(
            elevation: 10,
            forceElevated: true,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            stretch: true,
            toolbarHeight: 44,
            collapsedHeight: 45,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TimeTable',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(181, 36, 30, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                ),
              ),
              centerTitle: true,
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            print("refresh");
          },
          child: SingleChildScrollView(
            child: Column(
              children: context.watch<UserBloc>().userTitle != null
                  ? [
                      TimeTableToolRow(),
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
                      TimeTableToolRow(),
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
        ),
      ),
    );
  }
}
