import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';

class Tasks extends StatefulWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;

  Tasks({Key key, this.drawerKey}) : super(key: key);

  @override
  State createState() => new TasksState();
}

class TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Tasks"),
      ),
    );
  }
}
