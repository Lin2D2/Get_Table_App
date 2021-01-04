import 'package:get_table_app/blocs/filterTable.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/sites/settings.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'blocs/indexMainBloc.dart';
import 'blocs/indexTableViewBloc.dart';
import 'blocs/absentsTableApiBloc.dart';
import 'blocs/timeTableItemsBlock.dart';
import 'sites/home.dart';
import 'sites/tableview.dart';
import 'sites/timetable.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:provider/provider.dart';

void main() {
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
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Scaffold(
              body: SwipeDetector(
                onSwipeLeft: () {
                  Navigator.pushNamed(context, '/tableView');
                  context.read<IndexMainBloc>().increment();
                },
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => FilterTable(),
                    ),
                  ],
                  child: Home(),
                ),
              ),
              bottomNavigationBar: bottomNavigationBar(context),
            );
          } else {
            return Scaffold(
              body: Row(
                children: [
                  sideNavigationRail(context),
                  VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: SwipeDetector(
                      onSwipeLeft: () {
                        Navigator.pushNamed(context, '/tableView');
                        context.read<IndexMainBloc>().increment();
                      },
                      child: MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (_) => FilterTable(),
                          ),
                        ],
                        child: Home(),
                      ),
                    ),
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

class TableViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Scaffold(
              body: SwipeDetector(
                onSwipeLeft: () {
                  context.read<IndexMainBloc>().increment();
                  Navigator.pushNamed(context, '/timeTable');
                },
                onSwipeRight: () {
                  context.read<IndexMainBloc>().decrement();
                  Navigator.pushNamed(context, '/home');
                },
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => IndexTableViewBloc(),
                    ),
                  ],
                  child: TableView(),
                ),
              ),
              bottomNavigationBar: bottomNavigationBar(context),
            );
          } else {
            return Scaffold(
              body: Row(
                children: [
                  sideNavigationRail(context),
                  VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: SwipeDetector(
                      onSwipeLeft: () {
                        context.read<IndexMainBloc>().increment();
                        Navigator.pushNamed(context, '/timeTable');
                      },
                      onSwipeRight: () {
                        context.read<IndexMainBloc>().decrement();
                        Navigator.pushNamed(context, '/home');
                      },
                      child: MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (_) => IndexTableViewBloc(),
                          ),
                        ],
                        child: TableView(),
                      ),
                    ),
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

class TimeTableRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Scaffold(
              body: SwipeDetector(
                onSwipeLeft: () {
                  context.read<IndexMainBloc>().increment();
                  Navigator.pushNamed(context, '/settings');
                },
                onSwipeRight: () {
                  context.read<IndexMainBloc>().decrement();
                  Navigator.pushNamed(context, '/tableView');
                },
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => TimeTableItemsBlock(),
                    ),
                  ],
                  child: TimeTable(),
                ),
              ),
              bottomNavigationBar: bottomNavigationBar(context),
            );
          } else {
            return Scaffold(
              body: Row(
                children: [
                  sideNavigationRail(context),
                  VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: SwipeDetector(
                      onSwipeLeft: () {
                        context.read<IndexMainBloc>().increment();
                        Navigator.pushNamed(context, '/settings');
                      },
                      onSwipeRight: () {
                        context.read<IndexMainBloc>().decrement();
                        Navigator.pushNamed(context, '/tableView');
                      },
                      child: MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                            create: (_) => TimeTableItemsBlock(),
                          ),
                        ],
                        child: TimeTable(),
                      ),
                    ),
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
              body: SwipeDetector(
                onSwipeRight: () {
                  context.read<IndexMainBloc>().decrement();
                  Navigator.pushNamed(context, '/timeTable');
                },
                child: Settings(),
              ),
              bottomNavigationBar: bottomNavigationBar(context),
            );
          } else {
            return Scaffold(
              body: Row(
                children: [
                  sideNavigationRail(context),
                  VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: SwipeDetector(
                      onSwipeRight: () {
                        context.read<IndexMainBloc>().decrement();
                        Navigator.pushNamed(context, '/timeTable');
                      },
                      child: Settings(),
                    ),
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
