import 'package:flutter/material.dart';


class FormDataRawBloc extends ChangeNotifier {
  List _formDataRaw = [];
  List get formDataRaw => _formDataRaw;

  set formDataRaw(List val) {
    _formDataRaw = val;
    notifyListeners();
  }
}
