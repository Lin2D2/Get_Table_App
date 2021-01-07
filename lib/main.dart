import 'dart:convert';
import 'package:get_table_app/blocs/filterTable.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/services/apiManagerService.dart';
import 'package:get_table_app/sites/settings.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/indexMainBloc.dart';
import 'blocs/indexTableViewBloc.dart';
import 'blocs/absentsTableApiBloc.dart';
import 'blocs/timeTableItemsBlock.dart';
import 'sites/home.dart';
import 'sites/tableview.dart';
import 'sites/timetable.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:provider/provider.dart';
import 'package:platform/platform.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

bool swipeDetector;

void main() async {
  if (kIsWeb) {
    swipeDetector = false;
  } else {
    LocalPlatform platform = LocalPlatform();
    swipeDetector = platform.isAndroid || platform.isIOS;
  }
  // TODO do this in an separate thread or on the system
  // start async function or thread
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(
      'SubjectsRaw', jsonEncode(await ApiRoutes.fetchSubjectsRaw()));
  await prefs.setString(
      'TeachersRaw', jsonEncode(await ApiRoutes.fetchTeachersRaw()));
  await prefs.setString('DaysRaw', jsonEncode(await ApiRoutes.fetchDaysRaw()));
  await prefs.setString(
      'TodayRaw', jsonEncode(await ApiRoutes.fetchTomorrowTodayRaw("today")));
  await prefs.setString('TomorrowRaw',
      jsonEncode(await ApiRoutes.fetchTomorrowTodayRaw("tomorrow")));
  // end
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Time Table App';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => IndexMainBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => AbsentsTableApiBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimeTableItemsBlock(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/home':
              return PageTransition(
                child: HomeRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/tableView':
              return PageTransition(
                child: TableViewRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/timeTable':
              return PageTransition(
                child: TimeTableRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            case '/settings':
              return PageTransition(
                child: SettingsRoute(),
                type: PageTransitionType.fade,
                settings: settings,
              );
              break;
            default:
              return null;
          }
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!context.watch<AbsentsTableApiBloc>().isSet) {
      context.watch<AbsentsTableApiBloc>().refresh();
      context.watch<AbsentsTableApiBloc>().isSet = true;
    }
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => FilterTable(),
                ),
              ],
              child: Scaffold(
                body: swipeDetector
                    ? SwipeDetector(
                        onSwipeLeft: () {
                          Navigator.pushNamed(context, '/tableView');
                          context.read<IndexMainBloc>().increment();
                        },
                        child: Home(),
                      )
                    : Home(),
                bottomNavigationBar: bottomNavigationBar(context),
              ),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => FilterTable(),
                ),
              ],
              child: Scaffold(
                body: Row(
                  children: [
                    sideNavigationRail(context),
                    VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: swipeDetector
                          ? SwipeDetector(
                              onSwipeLeft: () {
                                Navigator.pushNamed(context, '/tableView');
                                context.read<IndexMainBloc>().increment();
                              },
                              child: Home(),
                            )
                          : Home(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class TableViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!context.watch<AbsentsTableApiBloc>().isSet) {
      context.watch<AbsentsTableApiBloc>().refresh();
      context.watch<AbsentsTableApiBloc>().isSet = true;
    }
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => IndexTableViewBloc(),
                ),
              ],
              child: Scaffold(
                body: swipeDetector
                    ? SwipeDetector(
                        onSwipeLeft: () {
                          context.read<IndexMainBloc>().increment();
                          Navigator.pushNamed(context, '/timeTable');
                        },
                        onSwipeRight: () {
                          context.read<IndexMainBloc>().decrement();
                          Navigator.pushNamed(context, '/home');
                        },
                        child: TableView(),
                      )
                    : TableView(),
                bottomNavigationBar: bottomNavigationBar(context),
              ),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => IndexTableViewBloc(),
                ),
              ],
              child: Scaffold(
                body: Row(
                  children: [
                    sideNavigationRail(context),
                    VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: swipeDetector
                          ? SwipeDetector(
                              onSwipeLeft: () {
                                context.read<IndexMainBloc>().increment();
                                Navigator.pushNamed(context, '/timeTable');
                              },
                              onSwipeRight: () {
                                context.read<IndexMainBloc>().decrement();
                                Navigator.pushNamed(context, '/home');
                              },
                              child: TableView(),
                            )
                          : TableView(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class TimeTableRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!context.watch<TimeTableItemsBlock>().isSet) {
      context.watch<TimeTableItemsBlock>().refresh();
      context.watch<TimeTableItemsBlock>().isSet = true;
    }
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Scaffold(
              body: swipeDetector
                  ? SwipeDetector(
                      onSwipeLeft: () {
                        context.read<IndexMainBloc>().increment();
                        Navigator.pushNamed(context, '/settings');
                      },
                      onSwipeRight: () {
                        context.read<IndexMainBloc>().decrement();
                        Navigator.pushNamed(context, '/tableView');
                      },
                      child: TimeTable(),
                    )
                  : TimeTable(),
              bottomNavigationBar: bottomNavigationBar(context),
            );
          } else {
            return Scaffold(
              body: Row(
                children: [
                  sideNavigationRail(context),
                  VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: swipeDetector
                        ? SwipeDetector(
                            onSwipeLeft: () {
                              context.read<IndexMainBloc>().increment();
                              Navigator.pushNamed(context, '/settings');
                            },
                            onSwipeRight: () {
                              context.read<IndexMainBloc>().decrement();
                              Navigator.pushNamed(context, '/tableView');
                            },
                            child: TimeTable(),
                          )
                        : TimeTable(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Scaffold(
              body: swipeDetector
                  ? SwipeDetector(
                      onSwipeRight: () {
                        context.read<IndexMainBloc>().decrement();
                        Navigator.pushNamed(context, '/timeTable');
                      },
                      child: Settings(),
                    )
                  : Settings(),
              bottomNavigationBar: bottomNavigationBar(context),
            );
          } else {
            return Scaffold(
              body: Row(
                children: [
                  sideNavigationRail(context),
                  VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: swipeDetector
                        ? SwipeDetector(
                            onSwipeRight: () {
                              context.read<IndexMainBloc>().decrement();
                              Navigator.pushNamed(context, '/timeTable');
                            },
                            child: Settings(),
                          )
                        : Settings(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
