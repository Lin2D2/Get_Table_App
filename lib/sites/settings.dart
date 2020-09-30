import 'package:Get_Table_App/blocs/loginBloc.dart';
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
      body: Column(
        children: [
          Text(
            'Index 3: Settings',
            style: optionStyle,
          ),
          RaisedButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Login extends StatelessWidget {
  static String ipAdress = "192.168.56.1";

  // Future<http.Response> postRequest(Map data) async {
  //   // return http.post(
  //   //   'http://' + ipAdress + ':5000/api/login',
  //   //   headers: <String, String>{
  //   //     'Content-Type': 'application/json; charset=UTF-8',
  //   //   },
  //   //   body: jsonEncode(<String, Map>{
  //   //     'data': data,
  //   //   }),
  //   // );
  //   return http.post('http://' + ipAdress + ':5000/api/login', body: data).then((http.Response response) {
  //     final int statusCode = response.statusCode;
  //
  //     if (response.statusCode == 200) {
  //       // If the call to the server was successful, parse the JSON
  //       return Post.fromJson(json.decode(response.body));
  //       // print("Status OK");
  //     } else {
  //       // If that call was not successful, throw an error.
  //       throw Exception('Failed to load post');
  //     }
  //   });
  // }
  Future postRequest(Map body) async {
    return http.post('http://' + ipAdress + ':5000/api/login',
        body:  jsonEncode(body),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Accept": "application/json",
        }).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return Post.fromJson(json.decode(response.body)).state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Get Table',
                    style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                  controller: context.watch<LoginBloc>().usernameController,
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
                  controller: context.watch<LoginBloc>().passwordController,
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
                            context.read<LoginBloc>().usernameController.text,
                        "password":
                            context.read<LoginBloc>().passwordController.text,
                      });
                      print(await postRequest({
                        "username":
                            context.read<LoginBloc>().usernameController.text,
                        "password":
                            context.read<LoginBloc>().passwordController.text,
                      }));
                      Navigator.pop(context);
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
      ),
    );
  }
}
