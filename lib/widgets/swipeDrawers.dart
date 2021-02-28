import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_table_app/blocs/indexMainBloc.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/sites/login.dart';
import 'package:get_table_app/widgets/bottomNavigationBar.dart';
import 'package:get_table_app/widgets/sideNavigationRail.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:provider/provider.dart';

class SwipeDrawerBottomBar extends StatelessWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;
  final Widget child;
  final bool swipeDetector;
  final Widget swipeDetectorWidget;

  const SwipeDrawerBottomBar({
    Key key,
    @required this.drawerKey,
    @required this.child,
    @required this.swipeDetector,
    @required this.swipeDetectorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDrawer(
        radius: 20,
        key: drawerKey,
        bodyBackgroundPeekSize: 0,
        bodySize: MediaQuery.of(context).size.width / 5 * 2,
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: buildDrawer(context, drawerKey),
        child: Scaffold(
          body: swipeDetector ? swipeDetectorWidget : child,
          bottomNavigationBar: bottomNavigationBar(context),
        ),
      ),
    );
  }
}

class SwipeDrawerSideRail extends StatelessWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;
  final Widget child;
  final swipeDetector;
  final Widget swipeDetectorWidget;

  const SwipeDrawerSideRail({
    Key key,
    @required this.drawerKey,
    @required this.child,
    @required this.swipeDetector,
    @required this.swipeDetectorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SwipeDrawer(
        radius: 20,
        key: drawerKey,
        bodyBackgroundPeekSize: 40,
        bodySize: MediaQuery.of(context).size.width / 5 * 3,
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: buildDrawer(context, drawerKey),
        child: Scaffold(
          body: Row(
            children: [
              sideNavigationRail(context, drawerKey: drawerKey),
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

Widget buildDrawer(BuildContext context, GlobalKey<SwipeDrawerState> drawerKey) {
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
              RaisedButton(
                child: Text(context.watch<UserBloc>().userTitle != null
                    ? "Logout"
                    : "Login"),
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
          ListTile(
            title: Text('Home'),
            leading: Icon(Icons.home),
            onTap: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              drawerKey.currentState.closeDrawer();
              Navigator.pushNamed(context, "/home");
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
              Navigator.pushNamed(context, "/tableView");
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
              Navigator.pushNamed(context, "/timeTable");
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
              Navigator.pushNamed(context, "/email");
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
              Navigator.pushNamed(context, "/files");
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
              Navigator.pushNamed(context, "/calender");
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
              Navigator.pushNamed(context, "/tasks");
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
              Navigator.pushNamed(context, "/videoconference");
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
              Navigator.pushNamed(context, "/settings");
              context.read<IndexMainBloc>().set(4);  // TODO index changes
            },
          ),
          Divider(),
        ],
      ),
    ),
  );
}
