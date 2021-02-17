import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'login.dart';

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
          child: SettingsList(
            backgroundColor: Theme.of(context).backgroundColor,
            sections: [
              SettingsSection(
                title: 'Account',
                tiles: [
                  SettingsTile(
                    title: context.watch<UserBloc>().userTitle != null
                        ? context.watch<UserBloc>().userTitle
                        : "Gast",
                    trailing: RaisedButton(
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
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                    ),
                    leading: CircleAvatar(
                      backgroundColor:
                          context.watch<UserBloc>().userTitle != null
                              ? Colors.blue.shade800
                              : Colors.red,
                      child: Text(context.watch<UserBloc>().userTitle != null
                          ? context.watch<UserBloc>().userTitle[0].toUpperCase()
                          : "G"),
                    ),
                    onTap: () {
                      // TODO Edit User
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: 'Common',
                tiles: [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
