import 'package:Get_Table_App/blocs/filterTable.dart';
import 'package:Get_Table_App/blocs/timeTableApiBloc.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:Get_Table_App/widgets/absentsTable.dart';
import 'package:Get_Table_App/widgets/dashboradCard.dart';
import 'package:Get_Table_App/widgets/generateTimeTable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _filterController =
        TextEditingController();
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
                child: Row(
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
                    ), // TODO Gesicht von Herder
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
            //context.watch<TimeTableApiBloc>.refresh();
          },
          child: ListView(
            children: context.watch<UserBloc>().timetable != null
                ? <Card>[
                    createDashboardCard(
                      "Time Table Today",
                      Table(
                        border: TableBorder.all(),
                        children: generateTimeTable(context, today: true),
                      ),
                    ),
                    createDashboardCard(
                      "Overview Today",
                      FutureBuilder<Day>(
                        future: context.watch<TimeTableApiBloc>().dayToday,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return LayoutBuilder(
                                builder: (layoutBuilderContext, constraints) {
                              if (constraints.maxWidth > 600) {
                                return createAbsentsTable(
                                    snapshot.data.day["header"],
                                    snapshot.data.day["content"],
                                    year: layoutBuilderContext.watch<UserBloc>().year);
                              } else {
                                return createAbsentsTable(
                                    snapshot.data.day["header"],
                                    snapshot.data.day["content"],
                                    year: layoutBuilderContext.watch<UserBloc>().year,
                                    smallScreen: true);
                              }
                            });
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Center(
                              child: Text(
                                "Sever not reachable",
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                    createDashboardCard(
                      "Time Table Tomorow",
                      Table(
                        border: TableBorder.all(),
                        children: generateTimeTable(context, today: false),
                      ),
                    ),
                    createDashboardCard(
                      "Overview Tomorow",
                      FutureBuilder<Day>(
                        future: context.watch<TimeTableApiBloc>().dayTomorrow,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return LayoutBuilder(
                                builder: (layoutBuilderContext, constraints) {
                              if (constraints.maxWidth > 600) {
                                return createAbsentsTable(
                                    snapshot.data.day["header"],
                                    snapshot.data.day["content"],
                                    year: layoutBuilderContext.watch<UserBloc>().year);
                              } else {
                                return createAbsentsTable(
                                    snapshot.data.day["header"],
                                    snapshot.data.day["content"],
                                    year: layoutBuilderContext.watch<UserBloc>().year,
                                    smallScreen: true);
                              }
                            });
                          } else if (snapshot.hasError) {
                            print(snapshot.error);
                            return Center(
                              child: Text(
                                "Sever not reachable",
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    )
                  ]
                : [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Text(
                            "Login to see the full Dashboard",
                            style: TextStyle(color: Colors.red),
                          ),
                          Row(
                            children: [
                              Text("Filter for Year:"),
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: 35,
                                  height: 30,
                                  child: TextField(
                                    controller: _filterController,
                                    onChanged: (value) {
                                      context.read<FilterTable>().filterValue =
                                          value;
                                    },
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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
    return createDashboardCard(
      "Overview Today",
      FutureBuilder<Day>(
        future: context.watch<TimeTableApiBloc>().dayToday,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LayoutBuilder(builder: (layoutBuilderContext, constraints) {
              if (constraints.maxWidth > 600) {
                return createAbsentsTable(
                    snapshot.data.day["header"], snapshot.data.day["content"],
                    year: layoutBuilderContext.watch<FilterTable>().filterValue);
              } else {
                return createAbsentsTable(
                    snapshot.data.day["header"], snapshot.data.day["content"],
                    year: layoutBuilderContext.watch<FilterTable>().filterValue,
                    smallScreen: true);
              }
            });
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                "Sever not reachable",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
