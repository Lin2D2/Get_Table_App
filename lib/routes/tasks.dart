import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/widgets/sliderMenu.dart';
import 'package:get_table_app/sites/tasks.dart' as tasks;

class TasksRoute extends StatelessWidget {  // TODO instead use StatefulWidget
  GlobalKey<SliderMenuContainerState> sliderMenuKey = GlobalKey<SliderMenuContainerState>();
  bool previousDrawCallConstraintTrue;

  @override
  Widget build(BuildContext context) {
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
              sliderMenuKey: sliderMenuKey,
              child: tasks.Tasks(
                sliderMenuKey: sliderMenuKey,
              ),
              swipeDetector: false,
              swipeDetectorWidget: null,
            );
          } else {
            if (sliderMenuKey.currentState != null
                && previousDrawCallConstraintTrue != null
                && previousDrawCallConstraintTrue == true) {
              sliderMenuKey = GlobalKey<SliderMenuContainerState>();
            }
            previousDrawCallConstraintTrue = false;
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
