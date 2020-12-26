import 'package:Get_Table_App/blocs/filterTable.dart';
import 'package:Get_Table_App/blocs/indexMainBloc.dart';
import 'package:Get_Table_App/blocs/absentsTableApiBloc.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:Get_Table_App/widgets/absentsTable.dart';
import 'package:Get_Table_App/widgets/absentsTableStatefulFuture.dart';
import 'package:Get_Table_App/widgets/createCard.dart';
import 'package:Get_Table_App/widgets/timeTableStatefulFuture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _filterController = TextEditingController();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (sliverContext, innerBoxScrolled) => [
          SliverAppBar(
            elevation: 10,
            forceElevated: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            stretch: true,
            toolbarHeight: 1,
            collapsedHeight: 40,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              // title: const Text(
              //   'Dashboard',
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 25,
              //       fontWeight: FontWeight.bold),
              // ),
              background: Container(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 330) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dashboard',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    } else {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                              "assets/logo-herderschule-luenburg-512-150x150.png"),
                          Text(
                            'Dashboard',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                          ), // TODO Logo Face of Herder
                        ],
                      );
                    }
                  },
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
            //context.watch<TimeTableApiBloc>.refresh();
          },
          child: ListView(
            children: context.watch<UserBloc>().userTitle != null
                ? [
                    TimeTableFuture(
                        futureObject:
                            context.watch<AbsentsTableApiBloc>().dayToday,
                        today: true),
                    AbsentsTableFuture(
                      futureObject:
                          context.watch<AbsentsTableApiBloc>().dayToday,
                      filter: context.watch<UserBloc>().year,
                      title: true,
                    ),
                    TimeTableFuture(
                        futureObject:
                            context.watch<AbsentsTableApiBloc>().dayTomorrow,
                        today: false),
                    AbsentsTableFuture(
                      futureObject:
                          context.watch<AbsentsTableApiBloc>().dayTomorrow,
                      filter: context.watch<UserBloc>().year,
                      title: true,
                    ),
                  ]
                : [
                    Card(
                      color: Colors.white,
                      elevation: 5.0,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 600) {
                            return MaterialBanner(
                              forceActionsBelow: true,
                              leading: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              content: Text(context
                                          .watch<UserBloc>()
                                          .userTitle ==
                                      null
                                  ? 'You have to Login to see Personalised content, '
                                      'but you can filter the table'
                                  : 'You have to Create an TimeTable to see Personalised content'),
                              actions: [
                                SizedBox(
                                  width: context.watch<UserBloc>().userTitle ==
                                          null
                                      ? 190
                                      : 225,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: context
                                                    .watch<UserBloc>()
                                                    .userTitle ==
                                                null
                                            ? Container(
                                                width: 70,
                                                child: RaisedButton(
                                                  child: Text("Login"),
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Login()),
                                                    );
                                                  },
                                                ),
                                              )
                                            : Container(
                                                width: 70,
                                                child: RaisedButton(
                                                  child: Chip(
                                                    avatar: Icon(Icons.edit),
                                                    label: Text("Create"),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, "/timeTable");
                                                    context
                                                        .read<IndexMainBloc>()
                                                        .set(2);
                                                  },
                                                ),
                                              ),
                                      ),
                                      Text("Year:"),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          width: 40,
                                          child: TextField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: _filterController,
                                            onChanged: (value) {
                                              context
                                                  .read<FilterTable>()
                                                  .filterValue = value;
                                            },
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return MaterialBanner(
                              leading: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              content: Text(
                                  'You have to Login to see Personalised content, '
                                  'but you can filter the table'),
                              actions: [
                                SizedBox(
                                  width: 190,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: RaisedButton(
                                          child: Text("Login"),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()),
                                            );
                                          },
                                        ),
                                      ),
                                      Text("Year:"),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          width: 40,
                                          child: TextField(
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            controller: _filterController,
                                            onChanged: (value) {
                                              context
                                                  .read<FilterTable>()
                                                  .filterValue = value;
                                            },
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    DayTable(),
                  ],
          ),
        ),
      ),
    );
  }
}

class DayTable extends StatefulWidget {
  const DayTable({Key key}) : super(key: key);

  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<DayTable> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Day>(
      future: context.watch<AbsentsTableApiBloc>().dayToday,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LayoutBuilder(builder: (layoutBuilderContext, constraints) {
            if (constraints.maxWidth > 600) {
              return createCard(
                context,
                createAbsentsTable(
                  snapshot.data.day["header"],
                  snapshot.data.day["content"],
                  year: layoutBuilderContext.watch<FilterTable>().filterValue,
                ),
                massage: snapshot.data.day["massage"],
                title: "Overview Today",
              );
            } else {
              return createCard(
                context,
                createAbsentsTable(
                    snapshot.data.day["header"], snapshot.data.day["content"],
                    year: layoutBuilderContext.watch<FilterTable>().filterValue,
                    smallScreen: true),
                massage: snapshot.data.day["massage"],
                title: "Overview Today",
              );
            }
          });
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return createCard(
            context,
            Container(),
            title: "Overview Today",
          );
        }
        return Center(
            child: createCard(
              context,
          CircularProgressIndicator(),
          title: "Overview Today",
        ));
      },
    );
  }
}
