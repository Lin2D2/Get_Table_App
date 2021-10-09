import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/widgets/sliderMenu.dart';
import 'package:get_table_app/sites/settings.dart' as settings;

class SettingsRoute extends StatelessWidget {
  final swipeDetector;
  final GlobalKey<SliderMenuContainerState> sliderMenuKey = GlobalKey<SliderMenuContainerState>();

  SettingsRoute(this.swipeDetector);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SliderMenuBottomBar(
              sliderMenuKey: sliderMenuKey,
              child: settings.Settings(sliderMenuKey: sliderMenuKey),
              swipeDetector: swipeDetector,
              swipeDetectorWidget: Container(// SwipeDetector(
                // onSwipeRight: () {
                //   context.read<IndexMainBloc>().decrement();
                //   Navigator.pushNamed(context, '/timeTable');
                // },
                child: settings.Settings(sliderMenuKey: sliderMenuKey),
              ),
            );
          } else {
            return SliderMenuSideRail(
              sliderMenuKey: sliderMenuKey,
              child: settings.Settings(),
              swipeDetector: swipeDetector,
              swipeDetectorWidget: Container(// SwipeDetector(
                // onSwipeRight: () {
                //   context.read<IndexMainBloc>().decrement();
                //   Navigator.pushNamed(context, '/timeTable');
                // },
                child: settings.Settings(),
              ),
            );
          }
        },
      ),
    );
  }
}
