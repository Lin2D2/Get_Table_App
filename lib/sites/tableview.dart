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
        Center(
          child: Text(
            "Day and Stuff",
            style: new TextStyle(
              fontSize: 40.0,
              color: Colors.black,
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
            child: Container(
          color: Colors.orange,
        )));
