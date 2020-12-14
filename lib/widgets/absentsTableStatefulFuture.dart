import 'package:Get_Table_App/types/day.dart';
import 'package:flutter/material.dart';
import 'absentsTable.dart';
import 'createCard.dart';

class AbsentsTableFuture extends StatefulWidget {
  final Future futureObject;
  final String filter;
  final bool title;

  AbsentsTableFuture(
      {Key key, @required this.futureObject, this.filter, this.title})
      : super(key: key);

  @override
  State createState() => new _AbsentsTableFutureState();
}

class _AbsentsTableFutureState extends State<AbsentsTableFuture> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Day>(
      future: widget.futureObject,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LayoutBuilder(
            builder: (layoutBuilderContext, constraints) {
              List titleList = snapshot.data.day["title"].toString().split(" ");
              titleList = [titleList[0].split(".")[0] + "."] +
                  [titleList[1], titleList[3], titleList[2]];
              if (constraints.maxWidth > 600) {
                return createCard(
                  context,
                  createAbsentsTable(
                      snapshot.data.day["header"], snapshot.data.day["content"],
                      year: widget.filter),
                  massage: snapshot.data.day["massage"],
                  title: widget.title != null ? titleList.join(" ") : null,
                );
              } else {
                return createCard(
                  context,
                  createAbsentsTable(
                      snapshot.data.day["header"], snapshot.data.day["content"],
                      year: widget.filter, smallScreen: true),
                  massage: snapshot.data.day["massage"],
                  title: widget.title != null ? titleList.join(" ") : null,
                );
              }
            },
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return createCard(
            context,
            Center(
              child: Text(
                "Sever not reachable",
                style: TextStyle(color: Colors.red),
              ),
            ),
            title: "Overview Today",
          );
        }
        return createCard(
          context,
          Center(
            child: CircularProgressIndicator(),
          ),
          title: "Overview Today",
        );
      },
    );
  }
}
