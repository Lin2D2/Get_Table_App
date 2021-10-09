import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class Files extends StatefulWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey;

  Files({Key key, this.sliderMenuKey}) : super(key: key);

  @override
  State createState() => new FilesState();
}

class FilesState extends State<Files> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Files"),
      ),
    );
  }
}
