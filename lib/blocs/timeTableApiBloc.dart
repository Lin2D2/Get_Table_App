import 'package:Get_Table_App/services/apiManagerService.dart';
import 'package:flutter/material.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:Get_Table_App/types/days.dart';

class TimeTableApiBloc extends ChangeNotifier{
  Future<Days> _days = TimeTableApi.fetchDays();
  Future<Day> _dayToday = TimeTableApi.fetchTomorrowToday("today");
  Future<Day> _dayTomorrow = TimeTableApi.fetchTomorrowToday("tomorrow");

  Future<Days> get days => _days;
  Future<Day> get dayToday => _dayToday;
  Future<Day> get dayTomorrow => _dayTomorrow;

  void updateDays() {
    _days = TimeTableApi.fetchDays();
    notifyListeners();
  }
}