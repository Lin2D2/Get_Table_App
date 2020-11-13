import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/services/dayOfWeek.dart';
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
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) => [
          SliverAppBar(
            elevation: 10,
            forceElevated: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            stretch: true,
            onStretchTrigger: () async {
              print("stretch");
            },
            toolbarHeight: 1,
            collapsedHeight: 40,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              // title: const Text(
              //   'Dashboard',
              //   style: TextStyle(
              //       color: Colors.black,
              //       fontSize: 25,
              //       fontWeight: FontWeight.bold),
              // ),
              background: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                        "assets/logo-herderschule-luenburg-512-150x150.png"),
                    Text(
                      'Dashboard',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 100,
                      height: 50,
                    ), // TODO Gesicht von Herder
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(181, 36, 30, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0)),
                ),
              ),
              centerTitle: true,
            ),
          ),
        ],
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
                    generateAbsentsTable(context, true),
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
                    generateAbsentsTable(context, true),
                  )
                : createItem(
                    "Time Table Tomorow",
                    [],
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

List<TableRow> generateDayOfTimeTable(BuildContext context, bool today) {
  int dayOfWeek = getdayOfWeek(today);
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
    lessons.length - 2, // TODO fix
    (index) => TableRow(
      children: findRightElement(context, index),
    ),
  );
  print(tableItems.length);
  return tableItems;
}
