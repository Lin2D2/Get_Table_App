import 'package:flutter/material.dart';

class TableView extends StatefulWidget {
  TableView({Key key}) : super(key: key);

  @override
  _TableViewState createState() => new _TableViewState();
}

class _TableViewState extends State<TableView> {
  double iconSize = 40;
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  Widget _buildList(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Card(
          color: Colors.white30,
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
              children: _buildGridTileList(32)),
        )
      ],
    ));
  }
}

List<Container> _buildGridTileList(int count) => List.generate(
    count,
    // Demo Content
    (i) => Container(
        child: GestureDetector(
            onTap: () {
              print("Container clicked" + i.toString());
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
              )),
            )))));
