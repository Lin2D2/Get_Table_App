import 'package:Get_Table_App/blocs/indexTimeTableBloc.dart';
import 'package:Get_Table_App/blocs/loginBloc.dart';
import 'package:Get_Table_App/blocs/severIpBloc.dart';
import 'package:Get_Table_App/sites/settings.dart';
import 'package:flutter/material.dart';
import 'blocs/indexMainBloc.dart';
import 'blocs/indexTableViewBloc.dart';
import 'blocs/themeBloc.dart';
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
          create: (_) => LoginBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => IpAddressBloc(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        home: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  void _onItemTapped(int index) {
    context.read<IndexMainBloc>().set(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ThemeBloc()),
          ],
          child: IndexedStack(
            index: context.watch<IndexMainBloc>().index,
            children: <Widget>[
              SwipeDetector(
                onSwipeLeft: () {
                  print(context.read<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().increment();
                },
                child: Home(),
              ),
              SwipeDetector(
                onSwipeLeft: () {
                  print(context.read<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().increment();
                },
                onSwipeRight: () {
                  print(context.read<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().decrement();
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
              SwipeDetector(
                onSwipeLeft: () {
                  print(context.read<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().increment();
                },
                onSwipeRight: () {
                  print(context.watch<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().decrement();
                },
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => TimeTableItemsBlock()),
                    ChangeNotifierProvider(create: (_) => IndexTimeTableBloc()),
                  ],
                  child: TimeTable(),
                ),
              ),
              SwipeDetector(
                onSwipeRight: () {
                  print(context.read<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().decrement();
                },
                child: Settings(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.grey[900],
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: new TextStyle(color: Colors.white))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.table_chart),
              title: Text('Tableview'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.view_quilt),
              title: Text('Timetable'),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.build),
              title: Text('Settings'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: context.watch<IndexMainBloc>().index,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
