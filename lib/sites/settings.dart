import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:flutter/material.dart';
import 'package:get_table_app/sites/about.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'login.dart';
import 'package:get_table_app/blocs/globalTheme.dart' as global;

class Settings extends StatefulWidget {
  final GlobalKey<SwipeDrawerState> drawerKey;

  const Settings({Key key, this.drawerKey}) : super(key: key);

  @override
  State createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (sliverContext, innerBoxScrolled) => [
          SliverAppBar(
            elevation: 10,
            forceElevated: true,
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            stretch: true,
            toolbarHeight: 44,
            collapsedHeight: 45,
            expandedHeight: 100,
            leading: widget.drawerKey != null
                ? InkWell(
                    onTap: () {
                      widget.drawerKey.currentState.openOrClose();
                    },
                    child: Icon(Icons.menu))
                : null,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(181, 36, 30, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                ),
              ),
              centerTitle: true,
            ),
          ),
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            print("refresh");
          },
          child: ListView(
            children: [
              SettingsSection(title: "Account", tiles: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: context.watch<UserBloc>().userTitle != null
                        ? Colors.blue.shade800
                        : Colors.red,
                    child: Text(context.watch<UserBloc>().userTitle != null
                        ? context.watch<UserBloc>().userTitle[0].toUpperCase()
                        : "G"),
                  ),
                  title: Text(
                    context.watch<UserBloc>().userTitle != null
                        ? context.watch<UserBloc>().userTitle
                        : "Gast",
                  ),
                  trailing: ElevatedButton(
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
                  onTap: () {
                    // TODO Edit User
                  },
                ),
              ]),
              SettingsSection(
                title: 'Theme',
                tiles: [
                  ListTile(
                    title: Text("Theme"),
                    leading: Icon(Icons.design_services),
                    trailing: ToggleSwitch(
                      initialLabelIndex: global.theme,
                      minWidth:
                      MediaQuery.of(context).size.width > 370 ? 86 : 50,
                      labels: MediaQuery.of(context).size.width > 370
                          ? ['System', 'Dark', 'Light']
                          : ["", "", ""],
                      icons: [
                        Icons.devices,
                        Icons.nightlight_round,
                        Icons.wb_sunny
                      ],
                      // Icons.smartphone
                      onToggle: (index) {
                        setState(() {
                          global.theme = index;
                        });
                        print('switched to: $index');
                      },
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: "About",
                tiles: [
                  AboutSection(),
                ],
                height: MediaQuery.of(context).size.height - 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> tiles;
  final double height;

  SettingsSection({@required this.title, @required this.tiles, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height != null ? height : 44 + (50 * tiles.length).toDouble(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(),
              ] +
              tiles,
        ),
      ),
    );
  }
}

Widget SettingsTile({@required String title, Widget leading, Widget trailing}) {
  return Container(
    height: 50,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [leading, Text(title), trailing],
    ),
  );
}
