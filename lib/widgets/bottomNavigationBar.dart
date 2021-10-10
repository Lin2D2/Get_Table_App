import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget bottomNavigationBar(BuildContext context) {
  void _onItemTapped(int index) {  // TODO make this dynamic and let user rearrange items
    int oldIndex = context.read<IndexMainBloc>().index - 1;
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
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      Navigator.pushReplacementNamed(context, route);
    }
    context.read<IndexMainBloc>().set(index + 1);
  }
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: context.watch<IndexMainBloc>().index != 0 ? context.watch<IndexMainBloc>().index - 1 : 1,
    backgroundColor: Colors.grey[900],
    unselectedItemColor: Colors.white,
    selectedItemColor: context.watch<IndexMainBloc>().index == 0 ? Colors.white : Colors.amber[800],
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
