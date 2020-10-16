import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/blocs/severIpBloc.dart';
import 'package:Get_Table_App/types/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Settings extends StatelessWidget {
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
    Future postRequest(Map body) async {
      return http.post(
          'http://' +
              context.read<IpAddressBloc>().ipAddress +
              ':5000/api/login',
          body: json.encode(body),
          headers: <String, String>{
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json',
            "Accept": "application/json",
          }).then((http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }
        return UserPost.fromJson(json.decode(response.body));
      });
    }

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
                      print({
                        "username":
                            context.read<UserBloc>().usernameController.text,
                        "password":
                            context.read<UserBloc>().passwordController.text,
                      });
                      UserPost response = (await postRequest({
                        "username":
                            context.read<UserBloc>().usernameController.text,
                        "password":
                            context.read<UserBloc>().passwordController.text,
                      }));
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
