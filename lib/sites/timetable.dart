import 'package:flutter/material.dart';

class TimeTable extends StatefulWidget {
  TimeTable({Key key}) : super(key: key);

  @override
  _TimeTableState createState() => new _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  double iconSize = 40;
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return Scaffold(
        body: Wrap(
            spacing: 8.0, // gap between adjacent chips
            runSpacing: 4.0, // gap between lines
            children: [
          create_timetable_item("Thursday", []),
          create_timetable_item("Friday", [
            // Demo Content
            ["1/2", "MA", "C5"],
            ["5/6", "de", "C7"],
          ]),
        ]));
  }
}

// maybe give this widget an state that it can add list items dynamical
Widget create_timetable_item(String type, List<List<String>> happend) {
  const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  const TextStyle secoundoptionStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white);
  List<TableRow> rows = [];
  // TODO make function with return
  for (var item in happend) {
    List<TextField> row_elements = [];
    for (String element in item) {
      TextEditingController controller = TextEditingController();
      controller.value = TextEditingValue(
        text: element,
      );
      row_elements.add(TextField(
        controller: controller,
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
              Center(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(2, 2, 2, 0),
                      child: IconButton(
                          // add new Row to Table
                          onPressed: () {
                            print("add button pressed");
                            rows.add(TableRow(
                              children: header,
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                              ),
                            ));
                          },
                          splashRadius: 20.0,
                          icon: Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 30.0,
                          ))))
            ],
          )));
}
