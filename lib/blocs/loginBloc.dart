import 'package:flutter/material.dart';


class LoginBloc extends ChangeNotifier {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _userTitle = "Not Logged in";
  String _username;
  String _password;

  String get username => _username;
  String get password => _password;

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  String get userTitle => _userTitle;

  set userTitle(String val) {
    _userTitle = val;
    notifyListeners();
  }

  set username(String val) {
    _username = val;
    notifyListeners();
  }
  set password(String val) {
    _password = val;
    notifyListeners();
  }
}
