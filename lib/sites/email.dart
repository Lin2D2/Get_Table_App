import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;

  Email({Key key, this.drawerKey}) : super(key: key);

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
