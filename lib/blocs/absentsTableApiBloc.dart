import 'package:Get_Table_App/services/apiManagerService.dart';
import 'package:flutter/material.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:Get_Table_App/types/days.dart';

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