import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/blocs/filterTable.dart';
import 'package:get_table_app/widgets/sliderMenu.dart';
import 'package:provider/provider.dart';
import 'package:get_table_app/blocs/absentsTableApiBloc.dart';
import 'package:get_table_app/sites/home.dart' as home;

class HomeRoute extends StatelessWidget {
  final swipeDetector;
  final GlobalKey<SliderMenuContainerState> sliderMenuKey = GlobalKey<SliderMenuContainerState>();

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
              child: SliderMenuBottomBar(
                sliderMenuKey: sliderMenuKey,
                child: home.Home(
                  sliderMenuKey: sliderMenuKey,
                ),
                swipeDetector: swipeDetector,
                swipeDetectorWidget: Container(// SwipeDetector(
                  // onSwipeLeft: () {
                  //   Navigator.pushNamed(context, '/tableView');
                  //   context.read<IndexMainBloc>().increment();
                  // },
                  child: home.Home(
                    sliderMenuKey: sliderMenuKey,
                  ),
                ),
              ),
            );
          } else {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => FilterTable(),
                ),
              ],
              child: SliderMenuSideRail(
                  sliderMenuKey: sliderMenuKey,
                  child: home.Home(),
                  swipeDetector: swipeDetector,
                  swipeDetectorWidget: Container(// SwipeDetector(
                    // onSwipeLeft: () {
                    //   Navigator.pushNamed(context, '/tableView');
                    //   context.read<IndexMainBloc>().increment();
                    // },
                    child: home.Home(),
                  )),
            );
          }
        },
      ),
    );
  }
}
