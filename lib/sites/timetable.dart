import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<TimeTable> {
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
  TableRow elementsToADD = TableRow(children: [
    Container(
        height: 30,
        child: TextField(
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black))),
    Container(
        height: 30,
        child: TextField(
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black))),
    Container(
        height: 30,
        child: TextField(
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black))),
  ]);
  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Card(
                child: Column(
              children: [
                Center(
                  child: Text(
                    "Monday",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Table(
                  border: TableBorder.all(),
                  children: monday,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: IconButton(
                      // add new Row to Table
                      onPressed: () {
                        monday.add(elementsToADD);
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
                        monday.removeLast();
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
                ])
              ],
            )),
            Card(
                child: Column(
              children: [
                Center(
                  child: Text(
                    "Tuesday",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Table(
                  border: TableBorder.all(),
                  children: tuesday,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: IconButton(
                      // add new Row to Table
                      onPressed: () {
                        tuesday.add(elementsToADD);
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
                        tuesday.removeLast();
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
                ])
              ],
            )),
            Card(
                child: Column(
              children: [
                Center(
                  child: Text(
                    "Wendsday",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Table(
                  border: TableBorder.all(),
                  children: wednesday,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: IconButton(
                      // add new Row to Table
                      onPressed: () {
                        wednesday.add(elementsToADD);
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
                        wednesday.removeLast();
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
                ])
              ],
            )),
            Card(
                child: Column(
              children: [
                Center(
                  child: Text(
                    "Thursday",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Table(
                  border: TableBorder.all(),
                  children: thursday,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: IconButton(
                      // add new Row to Table
                      onPressed: () {
                        thursday.add(elementsToADD);
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
                        thursday.removeLast();
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
                ])
              ],
            )),
            Card(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Friday",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Table(
                    border: TableBorder.all(),
                    //children: Days[0],
                    children: friday,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                      child: IconButton(
                        // add new Row to Table
                        onPressed: () {
                          friday.add(elementsToADD);
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
                          friday.removeLast();
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
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
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
