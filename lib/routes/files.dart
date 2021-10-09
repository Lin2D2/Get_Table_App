import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/widgets/sliderMenu.dart';
import 'package:get_table_app/sites/files.dart' as files;

class FilesRoute extends StatelessWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey = GlobalKey<SliderMenuContainerState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return SliderMenuBottomBar(
              sliderMenuKey: sliderMenuKey,
              child: files.Files(
                sliderMenuKey: sliderMenuKey,
              ),
              swipeDetector: false,
              swipeDetectorWidget: null,
            );
          } else {
            return SliderMenuSideRail(
              sliderMenuKey: sliderMenuKey,
              child: files.Files(
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
