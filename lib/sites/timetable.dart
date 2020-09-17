import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<TimeTable> {
  int _selectedIndexTimeTable = 0;
  List<TableRow> monday = [
    headerRow(),
  ];
  List<TableRow> tuesday = [
    headerRow(),
  ];
  List<TableRow> wednesday = [
    headerRow(),
  ];
  List<TableRow> thursday = [
    headerRow(),
  ];
  List<TableRow> friday = [
    headerRow(),
  ];
  TableRow elementsToADD = TableRow(
    children: [
      Container(
        height: 30,
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
        ),
      ),
      Container(
        height: 30,
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
        ),
      ),
      Container(
        height: 30,
        child: TextField(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext ctxt) {
    return IndexedStack(
      index: _selectedIndexTimeTable,
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Table(),  // TODO create Table from data of TableEdit or Database
          ),
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            leading: IconButton(
              icon: Icon(Icons.settings), // TODO add link to settings page
              onPressed: () {
                setState(() {});
              },
            ),
            title: Center(
              child: const Text(
                'TimeTable',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "edit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(
                    () {
                      _selectedIndexTimeTable = 1;
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Scaffold(
          body: Container(
            child: ListView(
              children: List.generate(
                  [monday, tuesday, wednesday, thursday, friday].length,
                  (i) => Card(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                [
                                  "Monday",
                                  "Tuesday",
                                  "Wednesday",
                                  "Thursday",
                                  "Friday"
                                ][i],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Table(
                              border: TableBorder.all(),
                              children: [
                                monday,
                                tuesday,
                                wednesday,
                                thursday,
                                friday
                              ][i],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                                  child: IconButton(
                                    // add new Row to Table
                                    onPressed: () {
                                      [
                                        monday,
                                        tuesday,
                                        wednesday,
                                        thursday,
                                        friday
                                      ][i]
                                          .add(elementsToADD);
                                      setState(() {});
                                    },
                                    splashRadius: 20.0,
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.pink,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                                  child: IconButton(
                                    // add new Row to Table
                                    onPressed: () {
                                      [
                                        monday,
                                        tuesday,
                                        wednesday,
                                        thursday,
                                        friday
                                      ][i]
                                          .removeLast();
                                      setState(() {});
                                    },
                                    splashRadius: 20.0,
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.pink,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            title: Center(
              child: const Text(
                'Edit Timetable',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _selectedIndexTimeTable = 0;
                });
              },
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "save",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {});  // TODO add save function
                },
              ),
            ],
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
    ],
  );
}
