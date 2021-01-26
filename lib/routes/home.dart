import 'package:flutter/material.dart';
import 'package:get_table_app/blocs/filterTable.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:get_table_app/blocs/absentsTableApiBloc.dart';
import 'package:get_table_app/sites/home.dart' as home;

class HomeRoute extends StatelessWidget {
  final swipeDetector;

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
              child: Scaffold(
                body: swipeDetector
                    ? SwipeDetector(
                        onSwipeLeft: () {
                          Navigator.pushNamed(context, '/tableView');
                          context.read<IndexMainBloc>().increment();
                        },
                        child: home.Home(),
                      )
                    : home.Home(),
                bottomNavigationBar: bottomNavigationBar(context),
              ),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => FilterTable(),
                ),
              ],
              child: Scaffold(
                body: Row(
                  children: [
                    sideNavigationRail(context),
                    VerticalDivider(thickness: 1, width: 1),
                    Expanded(
                      child: swipeDetector
                          ? SwipeDetector(
                              onSwipeLeft: () {
                                Navigator.pushNamed(context, '/tableView');
                                context.read<IndexMainBloc>().increment();
                              },
                              child: home.Home(),
                            )
                          : home.Home(),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
