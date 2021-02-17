import 'package:flutter/material.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:drawer_swipe/drawer_swipe.dart';

class SwipeDrawerBottomBar extends StatelessWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;
  final Widget child;
  final bool swipeDetector;
  final Widget swipeDetectorWidget;

  const SwipeDrawerBottomBar({
    Key key,
    @required this.drawerKey,
    @required this.child,
    @required this.swipeDetector,
    @required this.swipeDetectorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDrawer(
        radius: 20,
        key: drawerKey,
        bodyBackgroundPeekSize: 40,
        bodySize: MediaQuery.of(context).size.width / 3 * 1,
        backgroundColor: Colors.red,
        drawer: buildDrawer(),
        child: Scaffold(
          body: swipeDetector ? swipeDetectorWidget : child,
          bottomNavigationBar: bottomNavigationBar(context),
        ),
      ),
    );
  }
}

class SwipeDrawerSideRail extends StatelessWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;
  final Widget child;
  final swipeDetector;
  final Widget swipeDetectorWidget;

  const SwipeDrawerSideRail({
    Key key,
    @required this.drawerKey,
    @required this.child,
    @required this.swipeDetector,
    @required this.swipeDetectorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDrawer(
        radius: 20,
        key: drawerKey,
        bodyBackgroundPeekSize: 40,
        bodySize: MediaQuery.of(context).size.width / 5 * 4,
        backgroundColor: Colors.red,
        drawer: buildDrawer(),
        child: Scaffold(
          body: Row(
            children: [
              sideNavigationRail(context, drawerKey: drawerKey),
              VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: swipeDetector ? swipeDetectorWidget : child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildDrawer() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('Title'),
        ),
        ListTile(
          title: Text('Title'),
        ),
        ListTile(
          title: Text('Title'),
        ),
      ],
    ),
  );
}
