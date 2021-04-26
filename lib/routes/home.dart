import 'package:flutter/material.dart';
import 'package:get_table_app/blocs/filterTable.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:get_table_app/widgets/swipeDrawers.dart';
import 'package:provider/provider.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:get_table_app/blocs/absentsTableApiBloc.dart';
import 'package:get_table_app/sites/home.dart' as home;

class HomeRoute extends StatelessWidget {
  final swipeDetector;
  final GlobalKey<SwipeDrawerState> drawerKey = GlobalKey<SwipeDrawerState>();

  HomeRoute(this.swipeDetector);

  @override
  Widget build(BuildContext context) {
    if (!context.watch<AbsentsTableApiBloc>().isSet) {
      context.watch<AbsentsTableApiBloc>().initalSet();
      context.watch<AbsentsTableApiBloc>().isSet = true;
    }
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => FilterTable(),
                ),
              ],
              child: SwipeDrawerBottomBar(
                drawerKey: drawerKey,
                child: home.Home(
                  drawerKey: drawerKey,
                ),
                swipeDetector: swipeDetector,
                swipeDetectorWidget: Container(// SwipeDetector(
                  // onSwipeLeft: () {
                  //   Navigator.pushNamed(context, '/tableView');
                  //   context.read<IndexMainBloc>().increment();
                  // },
                  child: home.Home(
                    drawerKey: drawerKey,
                  ),
                ),
              ),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => FilterTable(),
                ),
              ],
              child: SwipeDrawerSideRail(
                  drawerKey: drawerKey,
                  child: home.Home(),
                  swipeDetector: swipeDetector,
                  swipeDetectorWidget: Container(// SwipeDetector(
                    // onSwipeLeft: () {
                    //   Navigator.pushNamed(context, '/tableView');
                    //   context.read<IndexMainBloc>().increment();
                    // },
                    child: home.Home(),
                  )),
            );
          }
        },
      ),
    );
  }
}
