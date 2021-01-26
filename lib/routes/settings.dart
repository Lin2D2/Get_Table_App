import 'package:flutter/material.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:get_table_app/sites/settings.dart' as settings;

class SettingsRoute extends StatelessWidget {
  final swipeDetector;

  SettingsRoute(this.swipeDetector);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Scaffold(
              body: swipeDetector
                  ? SwipeDetector(
                      onSwipeRight: () {
                        context.read<IndexMainBloc>().decrement();
                        Navigator.pushNamed(context, '/timeTable');
                      },
                      child: settings.Settings(),
                    )
                  : settings.Settings(),
              bottomNavigationBar: bottomNavigationBar(context),
            );
          } else {
            return Scaffold(
              body: Row(
                children: [
                  sideNavigationRail(context),
                  VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: swipeDetector
                        ? SwipeDetector(
                            onSwipeRight: () {
                              context.read<IndexMainBloc>().decrement();
                              Navigator.pushNamed(context, '/timeTable');
                            },
                            child: settings.Settings(),
                          )
                        : settings.Settings(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
