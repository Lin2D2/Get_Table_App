import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Videoconference extends StatefulWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey;

  Videoconference({Key key, this.sliderMenuKey}) : super(key: key);

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
