import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Calender extends StatefulWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey;

  Calender({Key key, this.sliderMenuKey}) : super(key: key);

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
