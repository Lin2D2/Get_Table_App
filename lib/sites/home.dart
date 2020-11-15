import 'package:Get_Table_App/blocs/timeTableApiBloc.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:Get_Table_App/widgets/absentsTable.dart';
import 'package:Get_Table_App/widgets/dashboradCard.dart';
import 'package:Get_Table_App/widgets/generateTimeTable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
                            return createAbsentsTable(
                                snapshot.data.day["header"],
                                snapshot.data.day["content"],
                                year: context.watch<UserBloc>().year);
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
                            return createAbsentsTable(
                                snapshot.data.day["header"],
                                snapshot.data.day["content"],
                                year: context.watch<UserBloc>().year);
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
                : <Card>[
                    createDashboardCard(
                      "Not logged in",
                      Text(
                        "You are not logged in, Login to see the full Dashboard",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    createDashboardCard(
                      "Overview Today",
                      FutureBuilder<Day>(
                        future: context.watch<TimeTableApiBloc>().dayToday,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return createAbsentsTable(
                                snapshot.data.day["header"],
                                snapshot.data.day["content"]);
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
                  ],
          ),
        ),
      ),
    );
  }
}
