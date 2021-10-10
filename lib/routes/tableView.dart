import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/blocs/absentsTableApiBloc.dart';
import 'package:get_table_app/blocs/indexTableViewBloc.dart';
import 'package:get_table_app/widgets/sliderMenu.dart';
import 'package:provider/provider.dart';
import 'package:get_table_app/sites/tableview.dart' as tableView;

class TableViewRoute extends StatelessWidget {  // TODO instead use StatefulWidget
  final swipeDetector;
  GlobalKey<SliderMenuContainerState> sliderMenuKey = GlobalKey<SliderMenuContainerState>();
  bool previousDrawCallConstraintTrue;

  TableViewRoute(this.swipeDetector);

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
            if (sliderMenuKey.currentState != null
                && previousDrawCallConstraintTrue != null
                && previousDrawCallConstraintTrue == false) {
              sliderMenuKey = GlobalKey<SliderMenuContainerState>();
            }
            previousDrawCallConstraintTrue = true;
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => IndexTableViewBloc(),
                ),
              ],
              child: SliderMenuBottomBar(
                sliderMenuKey: sliderMenuKey,
                child: tableView.TableView(
                  sliderMenuKey: sliderMenuKey,
                ),
                swipeDetector: swipeDetector,
                swipeDetectorWidget: Container(// SwipeDetector(
                  // onSwipeLeft: () {
                  //   context.read<IndexMainBloc>().increment();
                  //   Navigator.pushNamed(context, '/timeTable');
                  // },
                  // onSwipeRight: () {
                  //   context.read<IndexMainBloc>().decrement();
                  //   Navigator.pushNamed(context, '/home');
                  // },
                  child: tableView.TableView(
                    sliderMenuKey: sliderMenuKey,
                  ),
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
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => IndexTableViewBloc(),
                ),
              ],
              child: SliderMenuSideRail(
                sliderMenuKey: sliderMenuKey,
                child: tableView.TableView(),
                swipeDetector: swipeDetector,
                swipeDetectorWidget: Container(// SwipeDetector(
                  // onSwipeLeft: () {
                  //   context.read<IndexMainBloc>().increment();
                  //   Navigator.pushNamed(context, '/timeTable');
                  // },
                  // onSwipeRight: () {
                  //   context.read<IndexMainBloc>().decrement();
                  //   Navigator.pushNamed(context, '/home');
                  // },
                  child: tableView.TableView(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
