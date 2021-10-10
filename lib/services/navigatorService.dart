import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';

class NavigatorService {
  final Map<int, String> routes = {
    // NOTE 0 index is for routes that are not named routes like login
    1: "/home",
    2: "/tableView",
    3: "/timeTable",
    4: "/settings",
    5: "/email",
    6: "/files",
    7: "/calender",
    8: "/tasks",
    9: "/videoconference",
  };

  void changeSiteReplaceId(BuildContext context, int id) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    Navigator.pushReplacementNamed(context, routes[id]);
    context.read<IndexMainBloc>().id = id;
    if (context.read<IndexMainBloc>().userFavorites.contains(id)) {
      context.read<IndexMainBloc>().index = context.read<IndexMainBloc>().userFavorites.indexOf(id);
    }
  }

  void changeSitePushRoute(BuildContext context, Route route) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    Navigator.push(context, route);  // NOTE to exit use pop()
    context.read<IndexMainBloc>().id = context.read<IndexMainBloc>().index = 0;
  }
}