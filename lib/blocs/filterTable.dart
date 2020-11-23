import 'package:flutter/material.dart';


class FilterTable extends ChangeNotifier {
  String _filterValue;

  String get filterValue => _filterValue;

  set filterValue(String value) {
    _filterValue = value;
    notifyListeners();
  }
}