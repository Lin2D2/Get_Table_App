import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';

class Files extends StatefulWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;

  Files({Key key, this.drawerKey}) : super(key: key);

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
