import 'package:get_table_app/services/apiManagerService.dart';
import 'package:get_table_app/types/day.dart';
import 'package:flutter/material.dart';

import 'absentsTable.dart';

Widget tableViewItem(String title, BuildContext context) {
  return Scaffold(
    body: FutureBuilder<Day>(
      future: ApiRoutes.fetchDay(title),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  // TODO make this minimal width so there is no free space next to the Text
                  padding: EdgeInsets.all(8),
                  child: Card(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Nachrichten zum Tag:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(snapshot.data.day["massage"] != null
                            ? snapshot.data.day["massage"]
                            : "Keine Nachricht"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                  child: createAbsentsTable(snapshot.data.day["header"],
                      snapshot.data.day["content"]),
                ),
              ],
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
          Navigator.pop(context);
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
