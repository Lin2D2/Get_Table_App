import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<Home> {
  TableRow elementsToADD = TableRow(children: []);
  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Card(
                elevation: 5.0,
                child: Center(
                    child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Dashboard",
                    style: new TextStyle(
                      fontSize: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ))),
            Expanded(
              child: ListView(
                children: <Card>[
                  createItem(
                      "Overview Today",
                      [
                        createTableRow(
                          "1/2",
                          "MA",
                          "C5",
                          false,
                          extraColumn: "room C6",
                        ),
                        createTableRow(
                          "3/4",
                          "de",
                          "C7",
                          false,
                          extraColumn: "vertretung",
                        ),
                      ],
                      extraColumn: "change"),
                  createItem(
                    "Time Table Today",
                    [
                      createTableRow(
                        " ",
                        " ",
                        " ",
                        false,
                      ),
                    ],
                  ),
                  createItem(
                      "Overview Tomorow",
                      [
                        createTableRow(
                          " ",
                          " ",
                          " ",
                          false,
                          extraColumn: " ",
                        ),
                      ],
                      extraColumn: "change"),
                  createItem("Time Table Tomorow", [
                    createTableRow(
                      " ",
                      " ",
                      " ",
                      false,
                    ),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Card createItem(String title, List<TableRow> tableRows,
    {String extraColumn = ""}) {
  tableRows.insert(
      0,
      createTableRow(
        "lesson",
        "subject",
        "room",
        true,
        extraColumn: extraColumn,
      ));
  return Card(
    color: Colors.white,
    elevation: 5.0,
    child: Column(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(),
            children: tableRows,
          ),
        ),
      ],
    ),
  );
}

TableRow createTableRow(String item1, String item2, String item3, bool header,
    {String extraColumn = ""}) {
  TextStyle style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: (header ? Colors.white : Colors.black));
  TableRow row = TableRow(
      decoration: BoxDecoration(
        color: (header ? Colors.grey[900] : Colors.white),
      ),
      children: [
        Text(
          item1,
          textAlign: TextAlign.center,
          style: style,
        ),
        Text(
          item2,
          textAlign: TextAlign.center,
          style: style,
        ),
        Text(
          item3,
          textAlign: TextAlign.center,
          style: style,
        ),
      ]);
  if (extraColumn != "") {
    row.children.add(Text(
      extraColumn,
      textAlign: TextAlign.center,
      style: style,
    ));
  }
  return row;
}
