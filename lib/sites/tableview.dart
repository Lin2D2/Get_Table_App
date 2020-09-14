import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Get_Table_App/types/days.dart';

class TableView extends StatefulWidget {
  TableView({Key key}) : super(key: key);

  @override
  _TableViewState createState() => new _TableViewState();
}

class _TableViewState extends State<TableView> {
  double iconSize = 40;
  int _selectedIndex = 0;
  String _title = "";
  Future<Days> futureDays;

  Future<Days> fetchDays() async {
    final response = await http.get('http://localhost:5000/api/days');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Days.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Days');
    }
  }

  @override
  void initState() {
    super.initState();
    futureDays = fetchDays();
  }

  List<TableRow> tableList = createTableList(120);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        Scaffold(
          body: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 5.0,
                child: Center(
                  child: Text(
                    "Day and Stuff",
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: GridView.extent(
              //     maxCrossAxisExtent: 200,
              //     padding: const EdgeInsets.all(4),
              //     mainAxisSpacing: 4,
              //     crossAxisSpacing: 4,
              //     children: List.generate(
              //       32,
              //       // Demo Content
              //       (i) => Container(
              //         child: GestureDetector(
              //           onTap: () {
              //             print("Container clicked" + i.toString());
              //             setState(() {
              //               _selectedIndex += 1;
              //               _title = i.toString();
              //             });
              //           },
              //           onTapDown: (details) {
              //             print(i.toString() + "is down");
              //             // add color change to button
              //           },
              //           onTapCancel: () {
              //             print(i.toString() + "is Up");
              //             // add color change to button
              //           },
              //           child: Container(
              //             child: Container(
              //               decoration: BoxDecoration(
              //                 // add color change to button
              //                 color: Colors.grey[700],
              //                 border: Border.all(
              //                   color: Colors.grey[700],
              //                   width: 2,
              //                 ),
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               child: Center(
              //                 child: Text(
              //                   "item: " + i.toString(),
              //                   style: TextStyle(color: Colors.white),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
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
                                print("Container clicked" +
                                    snapshot.data.days[i]);
                                setState(() {
                                  _selectedIndex += 1;
                                  _title = snapshot.data.days[i];
                                });
                              },
                              onTapDown: (details) {
                                print(i.toString() + "is down");
                                // add color change to button
                              },
                              onTapCancel: () {
                                print(i.toString() + "is Up");
                                // add color change to button
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
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Table(
                border: TableBorder.all(),
                children: tableList,
              ),
            ),
          ),
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex -= 1;
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

List<TableRow> createTableList(int count) {
  List<TableRow> list = generateTableBody(count);
  list.insert(0, headerRow());
  return list;
}

List<TableRow> generateTableBody(int count) => List.generate(
      count,
      // Demo Content
      (i) => TableRow(children: [
        Center(
          child: Text("Test"),
        ),
        Center(
          child: Text("Test"),
        ),
        Center(
          child: Text("Test"),
        ),
      ]),
    );

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
