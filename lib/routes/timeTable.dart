import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/widgets/sliderMenu.dart';
import 'package:provider/provider.dart';
import 'package:get_table_app/sites/timetable.dart' as timetable;

class TimeTableRoute extends StatelessWidget {
  final swipeDetector;
  final GlobalKey<SliderMenuContainerState> sliderMenuKey = GlobalKey<SliderMenuContainerState>();

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
            return SliderMenuBottomBar(
              child: timetable.TimeTable(
                sliderMenuKey: sliderMenuKey,
              ),
              sliderMenuKey: sliderMenuKey,
              swipeDetector: swipeDetector,
              swipeDetectorWidget: Container(// SwipeDetector(
                // onSwipeLeft: () {
                //   context.read<IndexMainBloc>().increment();
                //   Navigator.pushNamed(context, '/settings');
                // },
                // onSwipeRight: () {
                //   context.read<IndexMainBloc>().decrement();
                //   Navigator.pushNamed(context, '/tableView');
                // },
                child: timetable.TimeTable(
                  sliderMenuKey: sliderMenuKey,
                ),
              ),
            );
          } else {
            return SliderMenuSideRail(
                child: timetable.TimeTable(),
                sliderMenuKey: sliderMenuKey,
                swipeDetector: swipeDetector,
                swipeDetectorWidget: Container(// SwipeDetector(
                  // onSwipeLeft: () {
                  //   context.read<IndexMainBloc>().increment();
                  //   Navigator.pushNamed(context, '/settings');
                  // },
                  // onSwipeRight: () {
                  //   context.read<IndexMainBloc>().decrement();
                  //   Navigator.pushNamed(context, '/tableView');
                  // },
                  child: timetable.TimeTable(),
                ));
          }
        },
      ),
    );
  }
}
