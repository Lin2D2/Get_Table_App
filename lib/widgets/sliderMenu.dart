import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/sites/login.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:provider/provider.dart';

class SliderMenuBottomBar extends StatelessWidget {  // TODO make Scrollable
  final GlobalKey<SliderMenuContainerState> sliderMenuKey;
  final Widget child;
  final bool swipeDetector;
  final Widget swipeDetectorWidget;

  const SliderMenuBottomBar({
    Key key,
    @required this.sliderMenuKey,
    @required this.child,
    @required this.swipeDetector,
    @required this.swipeDetectorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderMenuContainer(
        key: sliderMenuKey,
        sliderMenuOpenSize: MediaQuery.of(context).size.height - 100,
        sliderMenuCloseSize: 0,
        slideDirection: SlideDirection.TOP_TO_BOTTOM,
        appBarColor: Theme.of(context).backgroundColor,
        hasAppBar: false,
        sliderMenu: buildSliderMenu(context, sliderMenuKey),
        sliderMain: Scaffold(
          body: swipeDetector ? swipeDetectorWidget : child,
          bottomNavigationBar: bottomNavigationBar(context),
        ),
      ),
    );
  }
}

class SliderMenuSideRail extends StatelessWidget {
  final GlobalKey<SliderMenuContainerState> sliderMenuKey;
  final Widget child;
  final swipeDetector;
  final Widget swipeDetectorWidget;

  const SliderMenuSideRail({
    Key key,
    @required this.sliderMenuKey,
    @required this.child,
    @required this.swipeDetector,
    @required this.swipeDetectorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderMenuContainer(
        key: sliderMenuKey,  // TODO depending on screen with, start open
        sliderMenuOpenSize: 400,
        sliderMenuCloseSize: 55,
        appBarColor: Theme.of(context).backgroundColor,
        hasAppBar: false,
        sliderMenu: buildSliderMenu(context, sliderMenuKey),
        sliderMain: Scaffold(
          body: Row(
            children: [
              VerticalDivider(thickness: 1, width: 1),
              Expanded(
                child: swipeDetector ? swipeDetectorWidget : child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSliderMenu(BuildContext context, GlobalKey<SliderMenuContainerState> drawerKey) {
  return Container(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                  backgroundColor: context.watch<UserBloc>().userTitle != null
                      ? Colors.blue.shade800
                      : Colors.red,
                  child: Text(context.watch<UserBloc>().userTitle != null
                      ? context.watch<UserBloc>().userTitle[0].toUpperCase()
                      : "G"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  (context.watch<UserBloc>().userTitle != null
                          ? context.watch<UserBloc>().userTitle
                          : "Gast")
                      .split(".")[0],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                child: Text(context.watch<UserBloc>().userTitle != null
                    ? "Logout"
                    : "Login", style: Theme.of(context).textTheme.button),
                onPressed: context.watch<UserBloc>().userTitle != null
                    ? () {
                        // TODO Logout
                      }
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
              ),
            ],
          ),
          // TODO make this dynamic and let user rearrange items
          // TODO highlight selected item
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/home");
              context.read<IndexMainBloc>().set(1);  // TODO index changes
            },
          ),
          Divider(),
          ListTile(
            title: Text('TableView'),
            leading: Icon(Icons.table_chart),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/tableView");
              context.read<IndexMainBloc>().set(2);  // TODO index changes
            },
          ),
          Divider(),
          ListTile(
            title: Text('TimeTable'),
            leading: Icon(Icons.view_quilt),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/timeTable");
              context.read<IndexMainBloc>().set(3);  // TODO index changes
            },
          ),
          Divider(),
          ListTile(
            title: Text('E-Mail'),
            leading: Icon(Icons.mail),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/email");
              context.read<IndexMainBloc>().set(0);  // TODO index changes
            },
          ),
          Divider(),
          ListTile(
            title: Text('Files'),
            leading: Icon(Icons.folder),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/files");
              context.read<IndexMainBloc>().set(0);  // TODO index changes
            },
          ),
          Divider(),
          ListTile(
            title: Text('Calender'),
            leading: Icon(Icons.calendar_today),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/calender");
              context.read<IndexMainBloc>().set(0);  // TODO index changes
            },
          ),
          Divider(),
          ListTile(
            title: Text('Tasks'),
            leading: Icon(Icons.assignment),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/tasks");
              context.read<IndexMainBloc>().set(0);  // TODO index changes
            },
          ),
          Divider(),
          ListTile(
            title: Text('Videoconference'),
            leading: Icon(Icons.video_call),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/videoconference");
              context.read<IndexMainBloc>().set(0);  // TODO index changes
            },
          ),
          Divider(),
          ListTile(
            // TODO put it somewhere else
            title: Text('Settings'),
            leading: Icon(Icons.build),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushReplacementNamed(context, "/settings");
              context.read<IndexMainBloc>().set(4);  // TODO index changes
            },
          ),
          Divider(),
        ],
      ),
    ),
  );
}
