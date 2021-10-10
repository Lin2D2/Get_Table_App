import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/services/apiManagerService.dart';
import 'package:get_table_app/services/iservManagerService.dart';
import 'package:get_table_app/types/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400, maxHeight: 340),
                  child: Padding(
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
                            controller:
                                context.watch<UserBloc>().usernameController,
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
                            controller:
                                context.watch<UserBloc>().passwordController,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //forgot password screen
                          },
                          style: Theme.of(context).textButtonTheme.style,
                          child: Text('Forgot Password',
                            style: Theme.of(context).textTheme.button,  // TODO dark button theme textColor: Colors.grey[900]
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style,
                            child: Text('Login',
                              style: Theme.of(context).textTheme.button,
                            ),
                            onPressed: () async {
                              Map loginMap = {
                                "username": context
                                    .read<UserBloc>()
                                    .usernameController
                                    .text,
                                "password": context
                                    .read<UserBloc>()
                                    .passwordController
                                    .text,
                              };
                              print(loginMap);
                              UserPost response =
                                  await ApiRoutes.userPostRequest(loginMap);
                              switch (response.state) {
                                case "success":
                                  {
                                    UserBloc _userBloc =
                                        context.read<UserBloc>();
                                    _userBloc.username =
                                        _userBloc.usernameController.text;
                                    _userBloc.password =
                                        _userBloc.passwordController.text;
                                    _userBloc.userTitle =
                                        _userBloc.usernameController.text;
                                    if (response.timetable != null) {
                                      _userBloc.timetable = response.timetable;
                                      _userBloc.timeTableSet = true;
                                    }
                                    _userBloc.year = response.year;
                                    context
                                        .read<TimeTableItemsBlock>()
                                        .yearController
                                        .text = response.year;
                                    context.read<TimeTableItemsBlock>().year =
                                        response.year;
                                    _userBloc.loggedIn = true;
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        key: UniqueKey(),
                                        backgroundColor: Colors.green,
                                        content: Text('Success'),
                                      ),
                                    );
                                    break;
                                  }
                                case "wrong password":
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('wrong password'),
                                      ),
                                    );
                                    break;
                                  }
                                case "need to Sign in":
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('need to Sign in'),
                                      ),
                                    );
                                    break;
                                  }
                                case "failed":
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Failed'),
                                      ),
                                    );
                                    break;
                                  }
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('Failed'),
                                    ),
                                  );
                                  break;
                              }
                            },
                          ),
                        ),
                        Center(
                          child: Container(
                            height: 20,
                            child: Text("or"),
                          ),
                        ),
                        Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: ElevatedButton(
                            style: Theme.of(context).elevatedButtonTheme.style,  // Colors.blue[900]
                            child: Text('IServ-Login',
                              style: Theme.of(context).textTheme.button,),
                            onPressed: () async {
                              bool authorised =
                                  await IServRoutes.iservUserCheckAuthorised(
                                      context
                                          .read<UserBloc>()
                                          .usernameController
                                          .text,
                                      context
                                          .read<UserBloc>()
                                          .passwordController
                                          .text);
                              if (authorised) {
                                Map loginMap = {
                                  "username": context
                                      .read<UserBloc>()
                                      .usernameController
                                      .text,
                                  "authorised": true,
                                };
                                UserPost response =
                                    await ApiRoutes.iservUserPostRequest(
                                        loginMap);
                                switch (response.state) {
                                  case "success":
                                    {
                                      UserBloc _userBloc =
                                          context.read<UserBloc>();
                                      _userBloc.username =
                                          _userBloc.usernameController.text;
                                      _userBloc.userTitle =
                                          _userBloc.usernameController.text;
                                      if (response.timetable != null) {
                                        _userBloc.timetable =
                                            response.timetable;
                                        _userBloc.timeTableSet = true;
                                      }
                                      _userBloc.year = response.year;
                                      context
                                          .read<TimeTableItemsBlock>()
                                          .yearController
                                          .text = response.year;
                                      context.read<TimeTableItemsBlock>().year =
                                          response.year;
                                      _userBloc.loggedIn = true;
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          key: UniqueKey(),
                                          backgroundColor: Colors.green,
                                          content: Text('Success'),
                                        ),
                                      );
                                      break;
                                    }
                                  case "need to Sign in":
                                    {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text('need to Sign in'),
                                        ),
                                      );
                                      break;
                                    }
                                  default:
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text('Failed'),
                                      ),
                                    );
                                    break;
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Failed'),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('Does not have account?'),
                              TextButton(
                                style: Theme.of(context).elevatedButtonTheme.style,
                                child: Text(
                                  'Sign in',
                                  style: Theme.of(context).textTheme.button,  // TextStyle(fontSize: 20, color: Colors.grey[900]),
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
                ),
              ]),
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
