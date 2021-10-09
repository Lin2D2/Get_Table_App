import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Tasks extends StatefulWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey;

  Tasks({Key key, this.sliderMenuKey}) : super(key: key);

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
