import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget sideNavigationRail(BuildContext context,
    {GlobalKey<SliderMenuContainerState> sliderMenuKey}) {
  void _onItemTapped(int index) {
    int oldIndex = context.read<IndexMainBloc>().index;
    if (oldIndex != index || index == 0) {
      String route;
      bool drawerWasOpen = sliderMenuKey.currentState.isDrawerOpen;
      switch (index) {
        case 0:
          {
            sliderMenuKey.currentState.toggle();
            break;
          }
        case 1:
          {
            route = "/home";
            break;
          }
        case 2:
          {
            route = "/tableView";
            break;
          }
        case 3:
          {
            route = "/timeTable";
            break;
          }
        case 4:
          {
            route = "/settings";
            break;
          }
      }
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (route != null) {
        sliderMenuKey.currentState.closeDrawer();
        // TODO wait until animation is complete
        Navigator.pushReplacementNamed(context, route);
      }
      if (drawerWasOpen && route == null) {
        context.read<IndexMainBloc>().set(context.read<IndexMainBloc>().previousIndex);
      } else {
        if (route == null) {
          context.read<IndexMainBloc>().previousIndex = context.read<IndexMainBloc>().index;
        }
        context.read<IndexMainBloc>().set(index);
      }
    }
  }

  return NavigationRail(
    minWidth: 80,
    selectedIndex: context.watch<IndexMainBloc>().index,
    onDestinationSelected: _onItemTapped,
    labelType: NavigationRailLabelType.all,
    backgroundColor: Colors.grey[900],
    // TODO the Colors below don't apply
    unselectedLabelTextStyle: TextStyle(color: Colors.white, fontSize: 11),
    unselectedIconTheme: IconThemeData(color: Colors.white),
    selectedLabelTextStyle: TextStyle(color: Colors.amber[800], fontSize: 13),
    selectedIconTheme: IconThemeData(color: Colors.amber[800]),
    destinations: [
      if (sliderMenuKey != null)
        NavigationRailDestination(
          icon: Icon(Icons.menu),
          label: Text('Menu'),
        ),
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
