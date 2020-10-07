import 'package:Get_Table_App/blocs/indexTableViewBloc.dart';
import 'package:Get_Table_App/blocs/severIpBloc.dart';
import 'package:Get_Table_App/blocs/tableViewListBloc.dart';
import 'package:Get_Table_App/widgets/tableViewItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:Get_Table_App/types/days.dart';
import 'package:Get_Table_App/types/day.dart';
import 'package:provider/provider.dart';

class TableView extends StatefulWidget {
  TableView({Key key}) : super(key: key);

  @override
  _TableViewState createState() => new _TableViewState();
}

class _TableViewState extends State<TableView> {
  double iconSize = 40;
  Future<Days> futureDays;
  Future<Day> futureDay;
  Future<Day> futureToday;

  Future<Days> fetchDays() async {
    try {
      final response = await http.get('http://' +
          context.read<IpAddressBloc>().ipAddress +
          ':5000/api/days');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return Days.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load Days, status code: ' +
            response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Day> fetchToday() async {
    try {
      final response = await http.get('http://' +
          context.read<IpAddressBloc>().ipAddress +
          ':5000/api/today');
      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        return Day.fromJson(json.decode(response.body));
      } else {
        print(response.statusCode);
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load Today, status code: ' +
            response.statusCode.toString());
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    futureDays = fetchDays();
    futureToday = fetchToday();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TableViewListBloc>().stackItems = [
      Scaffold(
        body: FutureBuilder<Day>(
          future: futureToday,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      // TODO make this minimal width so there is no free space next to the Text
                      padding: EdgeInsets.all(8),
                      child: Card(
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Nachrichten zum Tag",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(snapshot.data.day["massage"]),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: Table(
                        border: TableBorder.all(),
                        children: List.generate(
                              snapshot.data.day["header"].length,
                              (row) => TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey[900],
                                ),
                                children: List.generate(
                                  snapshot.data.day["header"][row].length,
                                  // Demo Content
                                  (rowElement) => Center(
                                    child: Text(
                                      snapshot.data.day["header"][row]
                                          [rowElement],
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ) +
                            List.generate(
                              snapshot.data.day["content"].length,
                              // Demo Content
                              (row) => TableRow(
                                children: List.generate(
                                  snapshot.data.day["content"][row].length,
                                  // Demo Content
                                  (rowElement) => Center(
                                    child: Text(
                                      snapshot.data.day["content"][row]
                                          [rowElement],
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.view_module,
                color: Colors.black,
              ),
              onPressed: () {
                context.read<IndexTableViewBloc>().increment();
              }),
          title: Center(
            child: FutureBuilder<Day>(
              future: futureToday,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.day["title"],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
                onPressed: () {}),
          ],
        ),
      ),
      Scaffold(
        body: FutureBuilder<Days>(
          future: futureDays,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.extent(
                maxCrossAxisExtent: 200,
                padding: const EdgeInsets.all(4),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: List.generate(
                  snapshot.data.days.length,
                  // Demo Content
                  (i) => Container(
                    child: GestureDetector(
                      onTap: () {
                        context.read<TableViewListBloc>().addStackItems(
                            tableViewItem(snapshot.data.days[i], context));
                        print(context
                            .read<TableViewListBloc>()
                            .stackItems
                            .length);
                        print(context.read<TableViewListBloc>().stackItems);
                        context.read<IndexTableViewBloc>().increment();
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
                              snapshot.data.days[i],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                context.read<IndexTableViewBloc>().decrement();
              }),
          title: Center(
            child: const Text(
              'Days view',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ];
    return IndexedStack(
      index: context.watch<IndexTableViewBloc>().index,
      children: context.watch<TableViewListBloc>().stackItems,
    );
  }
}

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
