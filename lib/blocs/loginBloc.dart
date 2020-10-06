import 'package:flutter/material.dart';


class LoginBloc extends ChangeNotifier {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _userTitle = "Not Logged in";

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  String get userTitle => _userTitle;

  set userTitle(String val) {
    _userTitle = val;
    notifyListeners();
  }
}
