import 'package:flutter/material.dart';


class TableViewListBloc extends ChangeNotifier {
  List<Widget> _stackItems;

  get stackItems => _stackItems;

  set stackItems(Widget element) {
    _stackItems = [element];
  }

  void addStackItems(Widget element) {
    _stackItems.add(element);
    notifyListeners();
  }
}