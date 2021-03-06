import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get_table_app/widgets/swipeDrawers.dart';
import 'package:provider/provider.dart';
import 'package:get_table_app/sites/email.dart' as email;

class EmailRoute extends StatelessWidget {
  final GlobalKey<SwipeDrawerState> drawerKey = GlobalKey<SwipeDrawerState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SwipeDrawerBottomBar(
              drawerKey: drawerKey,
              child: email.Email(
                drawerKey: drawerKey,
              ),
              swipeDetector: false,
              swipeDetectorWidget: null,
            );
          } else {
            return SwipeDrawerSideRail(
              drawerKey: drawerKey,
              child: email.Email(
                drawerKey: drawerKey,
              ),
              swipeDetector: false,
              swipeDetectorWidget: null,
            );
          }
        },
      ),
    );
  }
}
