import 'package:get_table_app/blocs/userBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'apiManagerService.dart';

class TimeTableService {
  static saveTimeTable(BuildContext context) async {
    UserBloc _userBloc = context.read<UserBloc>();
    if (_userBloc.loggedIn) {
      String responeState = await ApiRoutes.timeTablePostRequest({
        "login": {
          "username": _userBloc.username,
          "password": _userBloc.password != null ? _userBloc.password : null,
        },
        "timetable": _userBloc.timetable,
        "year": _userBloc.year,
      });
      switch (responeState) {
        case "success":
          return true;
        default:
          return false;
      }
    } else {
      return false;
    }
  }
}
