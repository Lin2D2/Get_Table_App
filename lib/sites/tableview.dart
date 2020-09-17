import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Get_Table_App/types/days.dart';
import 'package:Get_Table_App/types/day.dart';

class TableView extends StatefulWidget {
  TableView({Key key}) : super(key: key);

  @override
  _TableViewState createState() => new _TableViewState();
}

class _TableViewState extends State<TableView> {
  double iconSize = 40;
  int _selectedIndexTableView = 0;
  String _title = "";
  Future<Days> futureDays;
  Future<Day> futureDay;

  Future<Days> fetchDays() async {
    try {
      final response = await http.get('http://localhost:5000/api/days');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return Days.fromJson(json.decode(response.body));
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

  Future<Day> fetchDay(date) async {
    try {
      final response = await http.get('http://localhost:5000/api/day/' + date);
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

  @override
  void initState() {
    super.initState();
    futureDays = fetchDays();
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return IndexedStack(
      index: _selectedIndexTableView,
      children: [
        Scaffold(
          body: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 5.0,
                child: Center(
                  child: Text(
                    "Days view",
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              FutureBuilder<Days>(
                future: futureDays,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GridView.extent(
                        maxCrossAxisExtent: 200,
                        padding: const EdgeInsets.all(4),
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        children: List.generate(
                          snapshot.data.days.length,
                          // Demo Content
                          (i) => Container(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndexTableView += 1;
                                  _title = snapshot.data.days[i];
                                });
                              },
                              child: Container(
                                child: Container(
                                  decoration: BoxDecoration(
                                    // add color change to button
                                    color: Colors.grey[700],
                                    border: Border.all(
                                      color: Colors.grey[700],
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      snapshot.data.days[i],
                                      style: TextStyle(color: Colors.white),
                                    ),
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
            ],
          ),
        ),
        Scaffold(
          body: FutureBuilder<Day>(
            future: fetchDay(_title),
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
                setState(() {
                  _selectedIndexTableView -= 1;
                });
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                _title,
                style: new TextStyle(
                  fontSize: 40.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

TableRow headerRow() {
  return TableRow(
      decoration: BoxDecoration(
        color: Colors.grey[900],
      ),
      children: [
        Text(
          "lesson",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          "subject",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          "room",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ]);
}
