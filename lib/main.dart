import 'package:Get_Table_App/blocs/filterTable.dart';
import 'package:Get_Table_App/blocs/indexTimeTableBloc.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/sites/settings.dart';
import 'package:Get_Table_App/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'blocs/formDataRawBloc.dart';
import 'blocs/indexMainBloc.dart';
import 'blocs/indexTableViewBloc.dart';
import 'blocs/themeBloc.dart';
import 'blocs/timeTableApiBloc.dart';
import 'blocs/timeTableItemsBlock.dart';
import 'sites/home.dart';
import 'sites/tableview.dart';
import 'sites/timetable.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
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
          create: (_) => TimeTableApiBloc(),
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
      ),
    );
  }
}

class HomeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SwipeDetector(
          onSwipeRight: () {
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
      ),
    );
  }
}

class TableViewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SwipeDetector(
          onSwipeRight: () {
            context.read<IndexMainBloc>().increment();
            Navigator.pushNamed(context, '/timeTable');
          },
          onSwipeLeft: () {
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
      ),
    );
  }
}

class TimeTableRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SwipeDetector(
          onSwipeRight: () {
            context.read<IndexMainBloc>().increment();
            Navigator.pushNamed(context, '/settings');
          },
          onSwipeLeft: () {
            context.read<IndexMainBloc>().decrement();
            Navigator.pushNamed(context, '/tableView');
          },
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => TimeTableItemsBlock(),
              ),
              ChangeNotifierProvider(
                create: (_) => IndexTimeTableBloc(),
              ),
              ChangeNotifierProvider(
                create: (_) => FormDataRawBloc(),
              ),
            ],
            child: TimeTable(),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    );
  }
}

class SettingsRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SwipeDetector(
          onSwipeLeft: () {
            context.read<IndexMainBloc>().decrement();
            Navigator.pushNamed(context, '/timeTable');
          },
          child: Settings(),
        ),
        bottomNavigationBar: bottomNavigationBar(context),
      ),
    );
  }
}
