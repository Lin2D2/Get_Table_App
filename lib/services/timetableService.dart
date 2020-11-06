import 'package:Get_Table_App/blocs/formDataRawBloc.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'apiManagerService.dart';

class TimeTableService {
  static saveTimeTable(BuildContext context) async {
    // print(context.read<FormDataRawBloc>().formDataRaw);
    // TODO do api call and local call to save data local and to database
    // TODO need to implement User class and login
    Map _monday = {};
    Map _tuesday = {};
    Map _wednesday = {};
    Map _thursday = {};
    Map _friday = {};
    for (final day
    in context
        .read<FormDataRawBloc>()
        .formDataRaw) {
      switch (day["day"]) {
        case "monday":
          {
            _monday.putIfAbsent(
                day["lesson"],
                    () =>
                {
                  "week":
                  "not implemented", //day["dropdown"].value,
                  "subject": day["controller"][0].text,
                  "room": day["controller"][1].text,
                });
            break;
          }
        case "tuesday":
          {
            _tuesday.putIfAbsent(
                day["lesson"],
                    () =>
                {
                  "week":
                  "not implemented", //day["dropdown"].value,
                  "subject": day["controller"][0].text,
                  "room": day["controller"][1].text,
                });
            break;
          }
        case "wednesday":
          {
            _wednesday.putIfAbsent(
                day["lesson"],
                    () =>
                {
                  "week":
                  "not implemented", //day["dropdown"].value,
                  "subject": day["controller"][0].text,
                  "room": day["controller"][1].text,
                });
            break;
          }
        case "thursday":
          {
            _thursday.putIfAbsent(
                day["lesson"],
                    () =>
                {
                  "week":
                  "not implemented", //day["dropdown"].value,
                  "subject": day["controller"][0].text,
                  "room": day["controller"][1].text,
                });
            break;
          }
        case "friday":
          {
            _friday.putIfAbsent(
                day["lesson"],
                    () =>
                {
                  "week":
                  "not implemented", //day["dropdown"].value,
                  "subject": day["controller"][0].text,
                  "room": day["controller"][1].text,
                });
            break;
          }
      }
    }
    Map timeTable = {
      "monday": _monday,
      "tuesday": _tuesday,
      "wednesday": _wednesday,
      "thursday": _thursday,
      "friday": _friday
    };
    timeTable.putIfAbsent(
        "login",
            () =>
        {
          "username": context
              .read<UserBloc>()
              .username,
          "password": context
              .read<UserBloc>()
              .password
        });
    String response = (await TimeTableApi.timeTablePostRequest(timeTable));
    switch (response) {
      case "success":
        {
          // to stuff
          break;
        }
    }
  }
}