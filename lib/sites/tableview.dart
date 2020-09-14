import 'package:flutter/material.dart';

class TableView extends StatefulWidget {
  TableView({Key key}) : super(key: key);

  @override
  _TableViewState createState() => new _TableViewState();
}

class _TableViewState extends State<TableView> {
  double iconSize = 40;
  int _selectedIndex = 0;
  String _title = "Demo String";
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
              Expanded(
                child: GridView.extent(
                  maxCrossAxisExtent: 200,
                  padding: const EdgeInsets.all(4),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: List.generate(
                    32,
                    // Demo Content
                    (i) => Container(
                      child: GestureDetector(
                        onTap: () {
                          print("Container clicked" + i.toString());
                          setState(() {
                            _selectedIndex += 1;
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
                                "item: " + i.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Scaffold(
          body: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: Table(
              border: TableBorder.all(),
              children: tableList,
            ),),
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
