import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new DyanmicList();
}

class DyanmicList extends State<Home> {
  TableRow ElementsToADD = TableRow(children: []);
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
                  CreateItem(
                      "Overview Today",
                      [
                        CreateTableRow(
                          "1/2",
                          "MA",
                          "C5",
                          false,
                          ExtraColumn: "room C6",
                        ),
                        CreateTableRow(
                          "3/4",
                          "de",
                          "C7",
                          false,
                          ExtraColumn: "vertretung",
                        ),
                      ],
                      ExtraColumn: "change"),
                  CreateItem(
                    "Time Table Today",
                    [
                      CreateTableRow(
                        " ",
                        " ",
                        " ",
                        false,
                      ),
                    ],
                  ),
                  CreateItem(
                      "Overview Tomorow",
                      [
                        CreateTableRow(
                          " ",
                          " ",
                          " ",
                          false,
                          ExtraColumn: " ",
                        ),
                      ],
                      ExtraColumn: "change"),
                  CreateItem("Time Table Tomorow", [
                    CreateTableRow(
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

Card CreateItem(String Title, List<TableRow> TableRows,
    {String ExtraColumn = ""}) {
  TableRows.insert(
      0,
      CreateTableRow(
        "lesson",
        "subject",
        "room",
        true,
        ExtraColumn: ExtraColumn,
      ));
  return Card(
    color: Colors.white,
    elevation: 5.0,
    child: Column(
      children: [
        Center(
          child: Text(
            Title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Table(
            border: TableBorder.all(),
            children: TableRows,
          ),
        ),
      ],
    ),
  );
}

TableRow CreateTableRow(String item1, String item2, String item3, bool Header,
    {String ExtraColumn = ""}) {
  TextStyle Style = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.bold,
      color: (Header ? Colors.white : Colors.black));
  TableRow Row = TableRow(
      decoration: BoxDecoration(
        color: (Header ? Colors.grey[900] : Colors.white),
      ),
      children: [
        Text(
          item1,
          textAlign: TextAlign.center,
          style: Style,
        ),
        Text(
          item2,
          textAlign: TextAlign.center,
          style: Style,
        ),
        Text(
          item3,
          textAlign: TextAlign.center,
          style: Style,
        ),
      ]);
  if (ExtraColumn != "") {
    Row.children.add(Text(
      ExtraColumn,
      textAlign: TextAlign.center,
      style: Style,
    ));
  }
  return Row;
}
