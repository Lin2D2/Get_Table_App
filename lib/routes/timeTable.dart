import 'package:flutter/material.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:provider/provider.dart';
import 'package:swipedetector/swipedetector.dart';
import 'package:get_table_app/sites/timetable.dart' as timetable;

class TimeTableRoute extends StatelessWidget {
  final swipeDetector;

  TimeTableRoute(this.swipeDetector);

  @override
  Widget build(BuildContext context) {
    if (!context.watch<TimeTableItemsBlock>().isSet) {
      context.watch<TimeTableItemsBlock>().initalSet();
      context.watch<TimeTableItemsBlock>().isSet = true;
    }
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Scaffold(
              body: swipeDetector
                  ? SwipeDetector(
                      onSwipeLeft: () {
                        context.read<IndexMainBloc>().increment();
                        Navigator.pushNamed(context, '/settings');
                      },
                      onSwipeRight: () {
                        context.read<IndexMainBloc>().decrement();
                        Navigator.pushNamed(context, '/tableView');
                      },
                      child: timetable.TimeTable(),
                    )
                  : timetable.TimeTable(),
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
                            onSwipeLeft: () {
                              context.read<IndexMainBloc>().increment();
                              Navigator.pushNamed(context, '/settings');
                            },
                            onSwipeRight: () {
                              context.read<IndexMainBloc>().decrement();
                              Navigator.pushNamed(context, '/tableView');
                            },
                            child: timetable.TimeTable(),
                          )
                        : timetable.TimeTable(),
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
