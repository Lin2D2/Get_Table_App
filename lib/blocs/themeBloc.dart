import 'package:flutter/material.dart';


class ThemeBloc extends ChangeNotifier {
  Theme _theme; // TODO init theme
  Theme get theme => _theme;

  set theme(Theme val) {
    _theme = val;
    notifyListeners();
  }
}
