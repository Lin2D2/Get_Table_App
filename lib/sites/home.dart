import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State createState() => new DynamicList();
}

class DynamicList extends State<Home> {
  TableRow elementsToADD = TableRow(children: []);

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      body: ListView(
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
          context.watch<UserBloc>().timetable != null
              ? createItem(
                  "Time Table Today",
                  generateTable(context, true),
                )
              : createItem(
                  "Time Table Today",
                  [],
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
          context.watch<UserBloc>().timetable != null
              ? createItem(
                  "Time Table Tomorow",
                  generateTable(context, true),
                )
              : createItem(
                  "Time Table Tomorow",
                  [],
                ),
        ],
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: const Text(
            'Dashboard',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
          ),
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

List<TableRow> generateTable(BuildContext context, bool today) {
  DateTime date = DateTime.now();
  int dayOfWeek =
      today ? date.weekday - 1 : date.weekday; // TODO here because of holidays
  // int dayOfWeek = today ? date.weekday : date.weekday + 1;  // TODO this is the actual one
  if (dayOfWeek == 6 && today) {
    dayOfWeek = 1;
  }
  if (dayOfWeek == 6 && !today) {
    dayOfWeek = 1;
  }
  if (dayOfWeek == 7 && today) {
    dayOfWeek = 1;
  }
  if (dayOfWeek == 7 && !today) {
    dayOfWeek = 2;
  }
  if (dayOfWeek == 1 && !today) {
    dayOfWeek = 2;
  }
  TextStyle bodyStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);
  List lessons = [
    "1/2",
    "3/4",
    "5/6",
    "7/8",
    "9/10",
  ];
  List<Widget> findRightElement(BuildContext context, int index) {
    Map day = context.watch<UserBloc>().timetable.values.elementAt(dayOfWeek);
    List<Widget> row;
    for (final lesson in day.keys) {
      print(lesson);
      print(lessons.elementAt(index));
      print("");
      if (lesson.toString().contains("/")) {
        if (lessons.elementAt(index) == lesson) {
          row = [
            Text(
              lesson,
              textAlign: TextAlign.center,
              style: bodyStyle,
            ),
            Text(
              day[lesson]["subject"],
              textAlign: TextAlign.center,
              style: bodyStyle,
            ),
            Text(
              day[lesson]["room"],
              textAlign: TextAlign.center,
              style: bodyStyle,
            ),
          ];
          break;
        }
      } else {
        row = [
          Text(
            lesson,
            textAlign: TextAlign.center,
            style: bodyStyle,
          ),
          Text(
            "",
            textAlign: TextAlign.center,
            style: bodyStyle,
          ),
          Text(
            "",
            textAlign: TextAlign.center,
            style: bodyStyle,
          ),
        ];
      }
    }
    print(row);
    return row;
  }

  List<TableRow> tableItems = List.generate(
    lessons.length - 1, // TODO fix
    (index) => TableRow(
      children: findRightElement(context, index),
    ),
  );
  print(tableItems.length);
  return tableItems;
}
