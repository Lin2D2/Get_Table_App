import 'package:get_table_app/services/apiManagerService.dart';
import 'package:flutter/material.dart';
import 'package:get_table_app/types/day.dart';
import 'package:get_table_app/types/days.dart';

class AbsentsTableApiBloc extends ChangeNotifier{
  Future<Days> _days = ApiRoutes.fetchDays();
  Future<Day> _dayToday = ApiRoutes.fetchTomorrowToday("today");
  Future<Day> _dayTomorrow = ApiRoutes.fetchTomorrowToday("tomorrow");

  Future<Days> get days => _days;
  Future<Day> get dayToday => _dayToday;
  Future<Day> get dayTomorrow => _dayTomorrow;

  void refresh() {
    _days = ApiRoutes.fetchDays();
    _dayToday = ApiRoutes.fetchTomorrowToday("today");
    _dayTomorrow = ApiRoutes.fetchTomorrowToday("tomorrow");
    notifyListeners();
  }
}