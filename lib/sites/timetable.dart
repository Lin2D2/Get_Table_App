import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/services/navigatorService.dart';
import 'package:get_table_app/widgets/generateTimeTable.dart';
import 'package:get_table_app/widgets/timeTableEdit.dart';
import 'package:get_table_app/widgets/timeTableToolRow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class TimeTable extends StatefulWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey;
  final NavigatorService navigatorService = NavigatorService();

  TimeTable({Key key, this.sliderMenuKey}) : super(key: key);

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
            leading: widget.sliderMenuKey != null
                ? InkWell(
                    onTap: () {
                      widget.sliderMenuKey.currentState.toggle();
                    },
                    child: Icon(Icons.menu))
                : null,
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
        body: SingleChildScrollView(
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
                        ElevatedButton(
                          style: Theme.of(context).elevatedButtonTheme.style,
                          child: Text("Login",
                            style: Theme.of(context).textTheme.button,),
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();
                            widget.navigatorService.changeSitePushRoute(context,
                                MaterialPageRoute(builder: (context) => Login()));
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
    );
  }
}
