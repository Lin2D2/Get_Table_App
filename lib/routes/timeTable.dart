import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/widgets/sliderMenu.dart';
import 'package:provider/provider.dart';
import 'package:get_table_app/sites/timetable.dart' as timetable;

class TimeTableRoute extends StatelessWidget {  // TODO instead use StatefulWidget
  final swipeDetector;
  GlobalKey<SliderMenuContainerState> sliderMenuKey = GlobalKey<SliderMenuContainerState>();
  bool previousDrawCallConstraintTrue;

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
            if (sliderMenuKey.currentState != null
                && previousDrawCallConstraintTrue != null
                && previousDrawCallConstraintTrue == false) {
              sliderMenuKey = GlobalKey<SliderMenuContainerState>();
            }
            previousDrawCallConstraintTrue = true;
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
            if (sliderMenuKey.currentState != null
                && previousDrawCallConstraintTrue != null
                && previousDrawCallConstraintTrue == true) {
              sliderMenuKey = GlobalKey<SliderMenuContainerState>();
            }
            previousDrawCallConstraintTrue = false;
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
