import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';

class Videoconference extends StatefulWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;

  Videoconference({Key key, this.drawerKey}) : super(key: key);

  @override
  State createState() => new VideoconferenceState();
}

class VideoconferenceState extends State<Videoconference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Videoconference"),
      ),
    );
  }
}
