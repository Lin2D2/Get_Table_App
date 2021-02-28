import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';

class IServBaseHelper {
  static const String _iservUrl = 'https://gymherderschule.de/iserv/';
  static const String _iservDomain = 'gymherderschule.de';

  Future<http.Response> get(String url) async {
    print('Api Get, iserv/$url');
    http.Response response;
    try {
      response = await http.get(_iservUrl + url);
    } on SocketException {
      throw Exception('failed to reach Sever');
    }
    print('api get recieved!');
    return response;
  }

  Future<http.Response> post(String url, Map body) async {
    print('Api Post, iserv/$url');
    http.Response response;
    try {
      response = await http.post(
        _iservUrl + url,
        body: body
      );
    } on SocketException {
      throw Exception('failed to reach Sever');
    }
    print('api Post done!');
    return response;
  }
}

class IServRoutes {
  static const String _iservUserCheckAuthorisedConst = 'app/login';
  static IServBaseHelper _helper = IServBaseHelper();
  static Future<bool> iservUserCheckAuthorised(
      String username, String password) async {
    final response = await _helper.post(_iservUserCheckAuthorisedConst, {
      "_username": username,
      "_password": password,
    });
    print("response from userPostRequest: $response");
    print(response.statusCode);  // NOTE 302 is actually the correct response?!?! it means that the login has worked, a 200 here means login failed
    if (response.statusCode == 200) {
      return false;
    } else if (response.statusCode == 302) {
      List cookies = response.headers["set-cookie"].split(",");
      for (final cookie in cookies) {
        print(cookie);
      }
      return true;
    }
  }
}
