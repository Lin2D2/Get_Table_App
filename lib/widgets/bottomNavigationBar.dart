import 'package:Get_Table_App/blocs/indexMainBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget bottomNavigationBar(BuildContext context) {
  void _onItemTapped(int index) {
    int oldIndex = context.read<IndexMainBloc>().index;
    context.read<IndexMainBloc>().set(index);
    String route;
    switch (index) {
      case 0:
        {
          route = "/home";
          break;
        }
      case 1:
        {
          route = "/tableView";
          break;
        }
      case 2:
        {
          route = "/timeTable";
          break;
        }
      case 3:
        {
          route = "/settings";
          break;
        }
    }
    if (oldIndex != index) {
      Navigator.pushNamed(context, route);
    }
  }

  return Theme(
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
  );
}
