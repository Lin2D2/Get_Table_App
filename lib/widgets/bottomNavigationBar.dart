import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_table_app/services/navigatorService.dart';

Widget bottomNavigationBar(BuildContext context) {
  NavigatorService navigatorService = NavigatorService();
  void _onItemTapped(int index) {  // TODO make this dynamic and let user rearrange items
    int oldIndex = context.read<IndexMainBloc>().index;
    if (oldIndex != index) {
      int id = context.read<IndexMainBloc>().userFavorites[index];
      navigatorService.changeSiteReplaceId(context, id);
    }
  }
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: context.watch<IndexMainBloc>().id == 0 ? 0 : context.watch<IndexMainBloc>().index,
    backgroundColor: Colors.grey[900],
    unselectedItemColor: Colors.white,
    selectedItemColor: context.watch<IndexMainBloc>().userFavorites.contains(context.watch<IndexMainBloc>().id) ? Colors.amber[800] : Colors.white,
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
