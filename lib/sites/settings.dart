import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/services/apiManagerService.dart';
import 'package:Get_Table_App/types/post.dart';
import 'package:Get_Table_App/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: ListView(
        children: <Widget>[
          Card(
            child: Row(children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: CircleAvatar(
                  backgroundColor: Colors.blue.shade800,
                  child: Text(
                      context.watch<UserBloc>().userTitle[0].toUpperCase()),
                ),
              ),
              Text(context.watch<UserBloc>().userTitle),
              Spacer(),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: RaisedButton(
                  child: Text('Login'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  },
                ),
              ),
            ]),
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

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                  controller: context.watch<UserBloc>().usernameController,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  controller: context.watch<UserBloc>().passwordController,
                ),
              ),
              FlatButton(
                onPressed: () {
                  //forgot password screen
                },
                textColor: Colors.grey[900],
                child: Text('Forgot Password'),
              ),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.grey[900],
                    child: Text('Login'),
                    onPressed: () async {
                      Map loginMap = {
                        "username":
                            context.read<UserBloc>().usernameController.text,
                        "password":
                            context.read<UserBloc>().passwordController.text,
                      };
                      print(loginMap);
                      UserPost response =
                          await TimeTableApi.userPostRequest(loginMap);
                      switch (response.state) {
                        case "success":
                          {
                            context.read<UserBloc>().username = context
                                .read<UserBloc>()
                                .usernameController
                                .text;
                            context.read<UserBloc>().password = context
                                .read<UserBloc>()
                                .passwordController
                                .text;
                            context.read<UserBloc>().userTitle = context
                                .read<UserBloc>()
                                .usernameController
                                .text;
                            context.read<UserBloc>().timetable =
                                response.timetable;
                            context.read<UserBloc>().year =
                                response.year;
                            Navigator.pop(context);
                            break;
                          }
                        case "wrong password":
                          {
                            break;
                          }
                        case "need to Sign in":
                          {
                            break;
                          }
                        case "failed":
                          {
                            break;
                          }
                      }
                    },
                  )),
              Container(
                child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.grey[900],
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        //signup screen
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            // TODO add link to settings page
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: const Text(
              'Login',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: <Widget>[
            Container(
              width: 60,
            ),
          ],
        ),
      ),
    );
  }
}
