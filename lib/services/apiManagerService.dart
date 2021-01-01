import 'dart:io';
import 'package:get_table_app/types/day.dart';
import 'package:get_table_app/types/days.dart';
import 'package:get_table_app/types/post.dart';
import 'package:get_table_app/types/subjects.dart';
import 'package:get_table_app/types/teachers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {
  static const String _baseUrl = "http://" +
      "central-homelab.freedynamicdns.net"+
      ":5000/api/";

  Future<dynamic> get(String url) async {
    print('Api Get, api/$url');
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, Map body) async {
    print('Api Post, api/$url');
    var responseJson;
    try {
      final response = await http.post(_baseUrl + url,
          body: json.encode(body),
          headers: <String, String>{
            'Content-Type': 'application/json',
            "Accept": "application/json",
          });
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw Exception('No Internet connection');
    }
    print('api Post done!');
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
    }
  }
}

class ApiRoutes {
  static const String _daysConst = 'days';
  static const String _dayConst = 'day';
  static const String _tomorrowTodayConst = 'today-tomorrow';
  static const String _timeTablePushConst = "timetable/push";
  static const String _userPushConst = 'login';
  static const String _teachersConst = 'teachers';
  static const String _subjectsConst = 'subjects';
  static ApiBaseHelper _helper = ApiBaseHelper();

  static Future<Days> fetchDays() async {
    final response = await _helper.get(_daysConst);
    print("response from fetchDays: $response");
    return Days.fromJson(response);
  }

  static Future<Day> fetchDay(String day) async {
    final response = await _helper.get("$_dayConst/$day");
    print("response from fetchDay: $response");
    return Day.fromJson(response);
  }

  static Future<Day> fetchTomorrowToday(String day) async {
    final response = await _helper.get("$_tomorrowTodayConst/$day");
    print("response from fetchDay: $response");
    return Day.fromJson(response);
  }

  static Future<String> timeTablePostRequest(Map body) async {
    final response = await _helper.post(_timeTablePushConst, body);
    print("response from timeTablePostRequest: $response");
    return Post.fromJson(response).state;
  }

  static Future<UserPost> userPostRequest(Map body) async {
    final response = await _helper.post(_userPushConst, body);
    print("response from userPostRequest: $response");
    return UserPost.fromJson(response);
  }

  static Future<Teachers> fetchTeachers() async {
    final response = await _helper.get(_teachersConst);
    print("response from fetchTeachers: $response");
    return Teachers.fromJson(response);
  }

  static Future<Subjects> fetchSubjects() async {
    final response = await _helper.get(_subjectsConst);
    print("response from fetchSubjects: $response");
    return Subjects.fromJson(response);
  }
}
