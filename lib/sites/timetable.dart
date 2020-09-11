import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<TimeTable> {
  List<TableRow> Monday = [
    TableRow(
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
        ]),
  ];
  List<TableRow> Tuesday = [
    TableRow(
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
        ]),
  ];
  List<TableRow> Wensday = [
    TableRow(
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
        ]),
  ];
  List<TableRow> Thursday = [
    TableRow(
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
        ]),
  ];
  List<TableRow> Friday = [
    TableRow(
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
        ]),
  ];
  TableRow ElementsToADD = TableRow(children: [
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
                  children: Monday,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: IconButton(
                      // add new Row to Table
                      onPressed: () {
                        Monday.add(ElementsToADD);
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
                        Monday.removeLast();
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
                  children: Tuesday,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: IconButton(
                      // add new Row to Table
                      onPressed: () {
                        Tuesday.add(ElementsToADD);
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
                        Tuesday.removeLast();
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
                  children: Wensday,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: IconButton(
                      // add new Row to Table
                      onPressed: () {
                        Wensday.add(ElementsToADD);
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
                        Wensday.removeLast();
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
                  children: Thursday,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                    child: IconButton(
                      // add new Row to Table
                      onPressed: () {
                        Thursday.add(ElementsToADD);
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
                        Thursday.removeLast();
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
                    children: Friday,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                      child: IconButton(
                        // add new Row to Table
                        onPressed: () {
                          Friday.add(ElementsToADD);
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
                          Friday.removeLast();
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
