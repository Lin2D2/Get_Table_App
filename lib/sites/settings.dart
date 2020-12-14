import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import 'login.dart';

class Settings extends StatefulWidget {
  @override
  State createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsList(
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
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                ),
                leading: CircleAvatar(
                  backgroundColor: context.watch<UserBloc>().userTitle != null
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: const Text(
            'Settings',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
