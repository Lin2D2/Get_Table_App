import 'package:flutter/material.dart';


class TableViewListBloc extends ChangeNotifier {
  List<Widget> stackItems;

  void addStackItems(Widget element) {
    stackItems.add(element);
    notifyListeners();
  }
}