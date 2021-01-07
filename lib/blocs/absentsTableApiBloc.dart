import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_table_app/types/day.dart';
import 'package:get_table_app/types/days.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AbsentsTableApiBloc extends ChangeNotifier {
  bool isSet = false;
  Future<Days> _days;
  Future<Day> _dayToday;
  Future<Day> _dayTomorrow;

  Future<Days> get days => _days;
  Future<Day> get dayToday => _dayToday;
  Future<Day> get dayTomorrow => _dayTomorrow;

  void refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _days = Future(() {
      // TODO check that the value is valid befor return
      return Days.fromJson(jsonDecode(prefs.getString("DaysRaw")));
    });
    _dayToday = Future(() {
      return Day.fromJson(jsonDecode(prefs.getString("TodayRaw")));
    });
    _dayTomorrow = Future(() {
      return Day.fromJson(jsonDecode(prefs.getString("TomorrowRaw")));
    });
    notifyListeners();
  }
}
