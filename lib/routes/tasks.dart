import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/widgets/sliderMenu.dart';
import 'package:get_table_app/sites/tasks.dart' as tasks;

class TasksRoute extends StatelessWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey = GlobalKey<SliderMenuContainerState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SliderMenuBottomBar(
              sliderMenuKey: sliderMenuKey,
              child: tasks.Tasks(
                sliderMenuKey: sliderMenuKey,
              ),
              swipeDetector: false,
              swipeDetectorWidget: null,
            );
          } else {
            return SliderMenuSideRail(
              sliderMenuKey: sliderMenuKey,
              child: tasks.Tasks(
                sliderMenuKey: sliderMenuKey,
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
