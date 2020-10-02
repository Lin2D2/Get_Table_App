import 'package:flutter/material.dart';


class IpAddressBloc extends ChangeNotifier {
  String _ipAddress = "192.168.20.144";
  String get ipAddress => _ipAddress;

  set ipAddress(String val) {
    _ipAddress = val;
    notifyListeners();
  }

}