import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    List<Widget> _ListItems = <Widget>[
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
      Column(children: <Widget>[
        create_overview("Overview Today", true, [
          // Demo Content
          [
            "1/2",
            "Ma",
            "C5",
            "room changed",
          ],
          [
            "3/4",
            "DE",
            "C7",
            "room changed",
          ],
        ]),
        create_overview("Time Table Today", false, [
          // Demo Content
          [
            "1/2",
            "Ma",
            "C5",
          ],
          [
            "3/4",
            "DE",
            "C7",
          ],
          [
            "5/6",
            "Ma",
            "C5",
          ],
          [
            "7/8",
            "DE",
            "C7",
          ],
        ]),
        create_overview("Overview Tomorow", true, [
          // Demo Content
          [
            "3/4",
            "DE",
            "C7",
            "room changed",
          ],
        ]),
        create_overview("Time Table Tomorow", false, [
          // Demo Content
          [
            "1/2",
            "Ma",
            "C5",
          ],
          [
            "3/4",
            "DE",
            "C7",
          ],
          [
            "5",
            "Ma",
            "C5",
          ],
          [
            "6",
            "DE",
            "C7",
          ],
          [
            "7/8",
            "Ma",
            "C5",
          ],
          [
            "9",
            "DE",
            "C7",
          ],
        ]),
      ])
    ];
    return Scaffold(
      body: ListView.builder(
          itemCount: _ListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return (_ListItems[index]);
          }),
    );
  }
}

Widget create_overview(String type, bool change, List<List<String>> happend) {
  const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  const TextStyle secoundoptionStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);
  List<TableRow> rows = [];
  for (var item in happend) {
    List<Text> row_elements = [];
    for (String element in item) {
      row_elements.add(Text(
        element,
        textAlign: TextAlign.center,
      ));
    }
    rows.add(TableRow(children: row_elements));
  }
  List<Text> header = [
    Text(
      "lesson",
      textAlign: TextAlign.center,
      style: secoundoptionStyle,
    ),
    Text(
      "subject",
      textAlign: TextAlign.center,
      style: secoundoptionStyle,
    ),
    Text(
      "room",
      textAlign: TextAlign.center,
      style: secoundoptionStyle,
    ),
  ];
  if (change) {
    header.add(Text(
      "change",
      textAlign: TextAlign.center,
      style: secoundoptionStyle,
    ));
  }

  rows.insert(
      0,
      TableRow(
        children: header,
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
      ));

  return Card(
      color: Colors.white30,
      elevation: 5.0,
      child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  type,
                  style: optionStyle,
                ),
              ),
              Table(
                border: TableBorder.all(),
                children: rows,
              ),
            ],
          )));
}
