import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';

class Calender extends StatefulWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;

  Calender({Key key, this.drawerKey}) : super(key: key);

  @override
  State createState() => new CalenderState();
}

class CalenderState extends State<Calender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Calender"),
      ),
    );
  }
}
