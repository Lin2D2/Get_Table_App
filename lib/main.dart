import 'package:Get_Table_App/blocs/indexTimeTableBloc.dart';
import 'package:flutter/material.dart';
import 'blocs/indexMainBloc.dart';
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
    return MaterialApp(
      title: _title,
      home: ChangeNotifierProvider(
        create: (_) => IndexMainBloc(),
        child: MyStatefulWidget(),
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
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
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
                  print(context.watch<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().increment();
                },
                child: Home(),
              ),
              SwipeDetector(
                onSwipeLeft: () {
                  print(context.watch<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().increment();
                },
                onSwipeRight: () {
                  print(context.watch<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().decrement();
                },
                child: TableView(),
              ),
              SwipeDetector(
                onSwipeLeft: () {
                  print(context.watch<IndexMainBloc>().index);
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
                    ChangeNotifierProvider(
                        create: (_) => IndexTimeTableBloc()),
                  ],
                  child: TimeTable(),
                ),
              ),
              SwipeDetector(
                onSwipeRight: () {
                  print(context.watch<IndexMainBloc>().index);
                  context.read<IndexMainBloc>().decrement();
                },
                child: Scaffold(
                  body: Column(
                    children: [
                      Text(
                        'Index 3: Settings',
                        style: optionStyle,
                      ),
                      RaisedButton(
                        child: Text('Login'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
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
              icon: const Icon(Icons.view_module),
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

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Get Table',
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  //forgot password screen
                },
                textColor: Colors.grey[900],
                child: Text('Forgot Password'),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.grey[900],
                    child: Text('Login'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.grey[900],
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}