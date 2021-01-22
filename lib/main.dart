import 'dart:io';
import 'package:get_table_app/blocs/filterTable.dart';
import 'package:get_table_app/blocs/timeTableScrollerIndexes.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/services/apiManagerService.dart';
import 'package:get_table_app/sites/settings.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get_storage/get_storage.dart';
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

Future<void> setStorage() async {
  // TODO do this in an separate thread or on the system
  // TODO only set if get returns no error
  try {
    if (!kIsWeb) {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await GetStorage.init("Get_Table_App");
        final box = GetStorage("Get_Table_App");
        box.write('SubjectsRaw', await ApiRoutes.fetchSubjectsRaw());
        box.write('TeachersRaw', await ApiRoutes.fetchTeachersRaw());
        box.write('DaysRaw', await ApiRoutes.fetchDaysRaw());
        box.write('TodayRaw', await ApiRoutes.fetchTomorrowTodayRaw("today"));
        box.write(
            'TomorrowRaw', await ApiRoutes.fetchTomorrowTodayRaw("tomorrow"));
      }
    } else {
      await GetStorage.init("Get_Table_App");
      final box = GetStorage("Get_Table_App");
      box.write('SubjectsRaw', await ApiRoutes.fetchSubjectsRaw());
      box.write('TeachersRaw', await ApiRoutes.fetchTeachersRaw());
      box.write('DaysRaw', await ApiRoutes.fetchDaysRaw());
      box.write('TodayRaw', await ApiRoutes.fetchTomorrowTodayRaw("today"));
      box.write(
          'TomorrowRaw', await ApiRoutes.fetchTomorrowTodayRaw("tomorrow"));
    }
  } on SocketException catch (_) {
    print('No Internet');
  }

}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    swipeDetector = false;
  } else {
    LocalPlatform platform = LocalPlatform();
    swipeDetector = platform.isAndroid || platform.isIOS;
  }
  try {
    setStorage();
  } catch(e) {
    print(e);
  }
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
        ChangeNotifierProvider(
          create: (_) => TimeTableScrollerIndexes(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
          accentColor: Colors.black,
          backgroundColor: Colors.white,
          bottomAppBarColor: Colors.grey[900],
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.red,
          accentColor: Colors.amber[700],
          backgroundColor: Colors.grey[850],
          bottomAppBarColor: Colors.grey[900],
        ),
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
      context.watch<AbsentsTableApiBloc>().initalSet();
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
      context.watch<AbsentsTableApiBloc>().initalSet();
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
      context.watch<TimeTableItemsBlock>().initalSet();
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
