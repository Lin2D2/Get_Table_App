import 'package:Get_Table_App/services/apiManagerService.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:flutter/material.dart';

Widget tableViewItem(String title, BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Day>(
        future: TimeTableApi.fetchDay(title),
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