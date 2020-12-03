import 'package:Get_Table_App/blocs/indexMainBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget sideNavigationRail(BuildContext context) {
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

  return NavigationRail(
    selectedIndex: context.read<IndexMainBloc>().index,
    onDestinationSelected: _onItemTapped,
    labelType: NavigationRailLabelType.selected,
    backgroundColor: Colors.grey[900],
    // TODO the Colors below don't apply
    unselectedLabelTextStyle: TextStyle(color: Colors.white),
    unselectedIconTheme: IconThemeData(color: Colors.white),
    selectedLabelTextStyle: TextStyle(color: Colors.amber[800]),
    selectedIconTheme: IconThemeData(color: Colors.amber[800]),
    destinations: [
      NavigationRailDestination(
        icon: Icon(Icons.home),
        label: Text('Home'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.table_chart),
        label: Text('TableView'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.view_quilt),
        label: Text('Timetable'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.build),
        label: Text('Settings'),
      ),
    ],
  );
}
