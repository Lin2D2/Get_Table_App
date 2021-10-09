import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Email extends StatefulWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey;

  Email({Key key, this.sliderMenuKey}) : super(key: key);

  @override
  State createState() => new EmailState();
}

class EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Email"),
      ),
    );
  }
}
