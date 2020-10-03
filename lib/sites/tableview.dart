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
  int _selectedIndexTableView = 0;
  Future<Days> futureDays;
  Future<Day> futureDay;

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

  // Future<Day> fetchDay(date) async {
  //   try {
  //     final response = await http.get('http://' +
  //         context.read<IpAddressBloc>().ipAddress +
  //         ':5000/api/day/' +
  //         date);
  //     if (response.statusCode == 200) {
  //       // If the server did return a 200 OK response,
  //       // then parse the JSON.
  //       return Day.fromJson(json.decode(response.body));
  //     } else {
  //       print(response.statusCode);
  //       // If the server did not return a 200 OK response,
  //       // then throw an exception.
  //       throw Exception('Failed to load Days, status code: ' +
  //           response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     print(e);
  //     return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    futureDays = fetchDays();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<TableViewListBloc>().stackItems = Scaffold(
      body: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 5.0,
            child: Center(
              child: Text(
                "Days view",
                style: new TextStyle(
                  fontSize: 40.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          FutureBuilder<Days>(
            future: futureDays,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GridView.extent(
                    maxCrossAxisExtent: 200,
                    padding: const EdgeInsets.all(4),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    children: List.generate(
                      snapshot.data.days.length,
                      // Demo Content
                      (i) => Container(
                        child: GestureDetector(
                          // onTapDown: (tapDownDetails) {
                          //   context
                          //       .read<TableViewListBloc>()
                          //       .addStackItems(
                          //       tableViewItem(snapshot.data.days[i], context));
                          //   print(context
                          //       .read<TableViewListBloc>().stackItems.length);
                          //   print(context
                          //       .read<TableViewListBloc>().stackItems);
                          // },
                          // onTapUp: (tapDownDetails) {
                          //   print(context
                          //       .read<TableViewListBloc>().stackItems.length);
                          //   print(context
                          //       .read<TableViewListBloc>().stackItems);
                          //   // TODO do new
                          //   context.read<IndexTableViewBloc>().index += 1;
                          // },
                          onTap: () {
                            context
                                .read<TableViewListBloc>()
                                .addStackItems(
                                    tableViewItem(snapshot.data.days[i], context));
                            print(context
                                .read<TableViewListBloc>().stackItems.length);
                            print(context
                                .read<TableViewListBloc>().stackItems);
                            // TODO do new
                            // TODO is still throwing error: child != null is not true
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
        ],
      ),
    );
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
