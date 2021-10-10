import 'package:flutter/material.dart';


class IndexMainBloc extends ChangeNotifier {
  int _id = 1;  // because default open side is home
  int _index = 0;
  int previousIndex;
  List<int> _userFavorites = [1, 2, 3, 4];  // TODO User Set Favorites in button Navigation bar and at the top of drawer

  // TODO get current root not auto set to the first Navigator 2.0
  int get id => _id;
  int get index => _index;
  List<int> get userFavorites => _userFavorites;  // TODO setter

  set id(int val) {
    _id = val;
    notifyListeners();
  }

  set index(int val) {
    _index = val;
    notifyListeners();
  }
}
