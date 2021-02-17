import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get_table_app/blocs/absentsTableApiBloc.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:get_table_app/blocs/indexTableViewBloc.dart';
import 'package:get_table_app/widgets/swipeDrawers.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:get_table_app/sites/tableview.dart' as tableView;

class TableViewRoute extends StatelessWidget {
  final swipeDetector;
  final GlobalKey<SwipeDrawerState> drawerKey = GlobalKey<SwipeDrawerState>();

  TableViewRoute(this.swipeDetector);

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
                  create: (_) => IndexTableViewBloc(),
                ),
              ],
              child: SwipeDrawerBottomBar(
                drawerKey: drawerKey,
                child: tableView.TableView(
                  drawerKey: drawerKey,
                ),
                swipeDetector: swipeDetector,
                swipeDetectorWidget: SwipeDetector(
                  onSwipeLeft: () {
                    context.read<IndexMainBloc>().increment();
                    Navigator.pushNamed(context, '/timeTable');
                  },
                  onSwipeRight: () {
                    context.read<IndexMainBloc>().decrement();
                    Navigator.pushNamed(context, '/home');
                  },
                  child: tableView.TableView(
                    drawerKey: drawerKey,
                  ),
                ),
              ),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => IndexTableViewBloc(),
                ),
              ],
              child: SwipeDrawerSideRail(
                drawerKey: drawerKey,
                child: tableView.TableView(),
                swipeDetector: swipeDetector,
                swipeDetectorWidget: SwipeDetector(
                  onSwipeLeft: () {
                    context.read<IndexMainBloc>().increment();
                    Navigator.pushNamed(context, '/timeTable');
                  },
                  onSwipeRight: () {
                    context.read<IndexMainBloc>().decrement();
                    Navigator.pushNamed(context, '/home');
                  },
                  child: tableView.TableView(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
