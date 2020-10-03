import 'package:Get_Table_App/blocs/indexTableViewBloc.dart';
import 'package:Get_Table_App/blocs/severIpBloc.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Widget tableViewItem(String title, BuildContext context) {
    Future<Day> fetchDay(date) async {
      try {
        final response = await http.get('http://' +
            context.read<IpAddressBloc>().ipAddress +
            ':5000/api/day/' +
            date);
        if (response.statusCode == 200) {
          // If the server did return a 200 OK response,
          // then parse the JSON.
          return Day.fromJson(json.decode(response.body));
        } else {
          print(response.statusCode);
          // If the server did not return a 200 OK response,
          // then throw an exception.
          throw Exception('Failed to load Days, status code: ' +
              response.statusCode.toString());
        }
      } catch (e) {
        print(e);
        return null;
      }
    }
    return Scaffold(
      body: FutureBuilder<Day>(
        future: fetchDay(title),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Table(
                  border: TableBorder.all(),
                  children: List.generate(
                    snapshot.data.day["header"].length,
                    // Demo Content
                        (row) => TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                        ),
                        children: List.generate(
                          snapshot.data.day["header"][row].length,
                          // Demo Content
                              (rowElement) => Center(
                            child: Text(
                              snapshot.data.day["header"][row]
                              [rowElement],
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )),
                  ) +
                      List.generate(
                        snapshot.data.day["content"].length,
                        // Demo Content
                            (row) => TableRow(
                          children: List.generate(
                            snapshot.data.day["content"][row].length,
                            // Demo Content
                                (rowElement) => Center(
                              child: Text(
                                snapshot.data.day["content"][row]
                                [rowElement],
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // TODO do new
            context.read<IndexTableViewBloc>().index -= 1;
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            title,
            style: new TextStyle(
              fontSize: 40.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );

}