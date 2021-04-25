import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:get_table_app/widgets/swipeDrawers.dart';
import 'package:provider/provider.dart';
import 'package:get_table_app/sites/settings.dart' as settings;

class SettingsRoute extends StatelessWidget {
  final swipeDetector;
  final GlobalKey<SwipeDrawerState> drawerKey = GlobalKey<SwipeDrawerState>();

  SettingsRoute(this.swipeDetector);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SwipeDrawerBottomBar(
              drawerKey: drawerKey,
              child: settings.Settings(drawerKey: drawerKey),
              swipeDetector: swipeDetector,
              swipeDetectorWidget: Container(// SwipeDetector(
                // onSwipeRight: () {
                //   context.read<IndexMainBloc>().decrement();
                //   Navigator.pushNamed(context, '/timeTable');
                // },
                child: settings.Settings(drawerKey: drawerKey),
              ),
            );
          } else {
            return SwipeDrawerSideRail(
              drawerKey: drawerKey,
              child: settings.Settings(),
              swipeDetector: swipeDetector,
              swipeDetectorWidget: Container(// SwipeDetector(
                // onSwipeRight: () {
                //   context.read<IndexMainBloc>().decrement();
                //   Navigator.pushNamed(context, '/timeTable');
                // },
                child: settings.Settings(),
              ),
            );
          }
        },
      ),
    );
  }
}
