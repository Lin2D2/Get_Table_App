import 'dart:io';
import 'package:Get_Table_App/types/day.dart';
import 'package:Get_Table_App/types/days.dart';
import 'package:Get_Table_App/types/post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ApiBaseHelper {
  static const String _baseUrl = "http://"+
      //"central-homelab.freedynamicdns.net"+
      "192.168.1.209"+
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
      final response =
          await http.post(_baseUrl + url, body: json.encode(body), headers: <String, String>{
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

class TimeTableApi {
  static const String _days = 'days';
  static const String _day = 'day';
  static const String _tomorrowToday = 'today-tomorrow';
  static const String _timeTablePush = "timetable/push";
  static const String _userPush = 'login';
  static ApiBaseHelper _helper = ApiBaseHelper();

  static Future<Days> fetchDays() async {
    final response = await _helper.get(_days);
    print("response from fetchDays: $response");
    return Days.fromJson(response);
  }

  static Future<Day> fetchDay(day) async {
    final response = await _helper.get("$_day/$day");
    print("response from fetchDay: $response");
    return Day.fromJson(response);
  }

  static Future<Day> fetchTomorrowToday(day) async {
    final response = await _helper.get("$_tomorrowToday/$day");
    print("response from fetchDay: $response");
    return Day.fromJson(response);
  }

  static Future<String> timeTablePostRequest(body) async {
    final response = await _helper.post(_timeTablePush, body);
    print("response from timeTablePostRequest: $response");
    return Post.fromJson(response).state;
  }

  static Future<UserPost> userPostRequest(body) async {
    final response = await _helper.post(_userPush, body);
    print("response from userPostRequest: $response");
    return UserPost.fromJson(response);
  }
}
