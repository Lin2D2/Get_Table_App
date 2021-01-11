import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get_table_app/types/day.dart';
import 'package:get_table_app/types/days.dart';

class AbsentsTableApiBloc extends ChangeNotifier {
  GetStorage _box = GetStorage();
  bool isSet = false;
  Future<Days> _days;
  Future<Day> _dayToday;
  Future<Day> _dayTomorrow;

  Future<Days> get days => _days;
  Future<Day> get dayToday => _dayToday;
  Future<Day> get dayTomorrow => _dayTomorrow;

  void initalSet() {
    // TODO only refreshes from disk not from sever!
    // TODO check that the value is valid befor return
    final box = GetStorage("Get_Table_App");
    _days = Future(() {
      return Days.fromJson(box.read("DaysRaw"));
    });
    _dayToday = Future(() {
      return Day.fromJson(box.read("TodayRaw"));
    });
    _dayTomorrow = Future(() {
      return Day.fromJson(box.read("TomorrowRaw"));
    });
    box.listenKey('DaysRaw', (value) {
      _days = Future(() {
        return Days.fromJson(box.read("DaysRaw"));
      });
    });
    box.listenKey('TodayRaw', (value) {
      _dayToday = Future(() {
        return Day.fromJson(box.read("TodayRaw"));
      });
    });
    box.listenKey('TomorrowRaw', (value) {
      _dayTomorrow = Future(() {
        return Day.fromJson(box.read("TomorrowRaw"));
      });
    });
  }
}
