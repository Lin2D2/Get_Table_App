import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget bottomNavigationBar(BuildContext context) {
  void _onItemTapped(int index) {
    int oldIndex = context.read<IndexMainBloc>().index;
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
    context.read<IndexMainBloc>().set(index);
  }

  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: context.watch<IndexMainBloc>().index,
    backgroundColor: Colors.grey[900],
    fixedColor: Colors.amber[800],
    unselectedItemColor: Colors.white,
    onTap: _onItemTapped,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.table_chart),
        label: 'TableView',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.view_quilt),
        label: 'Timetable',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.build),
        label: 'Settings',
      ),
    ],
  );
}
