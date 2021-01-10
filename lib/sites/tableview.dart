import 'package:get_table_app/blocs/indexTableViewBloc.dart';
import 'package:get_table_app/blocs/absentsTableApiBloc.dart';
import 'package:get_table_app/widgets/absentsTableStatefulFuture.dart';
import 'package:get_table_app/widgets/tableViewItem.dart';
import 'package:flutter/material.dart';
import 'package:get_table_app/types/days.dart';
import 'package:get_table_app/types/day.dart';
import 'package:provider/provider.dart';

class TableView extends StatefulWidget {
  TableView({Key key}) : super(key: key);

  @override
  _TableViewState createState() => new _TableViewState();
}

class _TableViewState extends State<TableView> {
  double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: context.watch<IndexTableViewBloc>().index,
      children: [
        Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: NestedScrollView(
            headerSliverBuilder: (sliverContext, innerBoxScrolled) => [
              SliverAppBar(
                elevation: 10,
                forceElevated: true,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).primaryColor,
                stretch: true,
                toolbarHeight: 44,
                collapsedHeight: 45,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TableView",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
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
                leading: IconButton(
                    icon: Icon(
                      Icons.view_module,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.read<IndexTableViewBloc>().index = 2;
                    }),
                actions: [
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tight(Size(58, double.infinity)),
                    child: FlatButton(
                      child: Text(
                        "next",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        context.read<IndexTableViewBloc>().index = 1;
                      },
                    ),
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tight(Size(50, double.infinity)),
                    child: FlatButton(
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
            body: RefreshIndicator(
              onRefresh: () async {
                print("refresh");
              },
              child: ListView(
                children: [
                  Center(
                    child: FutureBuilder<Day>(
                      future: context.watch<AbsentsTableApiBloc>().dayToday,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.day["title"] != null) {
                            List _titleSplit =
                                snapshot.data.day["title"].split(" ");
                            return Text(
                              _titleSplit[1] +
                                  " " +
                                  _titleSplit[3] +
                                  " " +
                                  _titleSplit[2],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Text(
                              "Holidays",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Text(
                            "Sever not reachable",
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          // By default, show a loading spinner.
                          return Center(
                            child: Text(
                              'TableView',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  AbsentsTableFuture(
                      futureObject:
                          context.watch<AbsentsTableApiBloc>().dayToday),
                ],
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: NestedScrollView(
            headerSliverBuilder: (sliverContext, innerBoxScrolled) => [
              SliverAppBar(
                elevation: 10,
                forceElevated: true,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).primaryColor,
                stretch: true,
                toolbarHeight: 44,
                collapsedHeight: 45,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "TableView",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
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
                leading: IconButton(
                    icon: Icon(
                      Icons.view_module,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.read<IndexTableViewBloc>().index = 2;
                    }),
                actions: [
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tight(Size(65, double.infinity)),
                    child: FlatButton(
                      child: Text(
                        "today",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        context.read<IndexTableViewBloc>().index = 0;
                      },
                    ),
                  ),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tight(Size(50, double.infinity)),
                    child: FlatButton(
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
            body: RefreshIndicator(
              onRefresh: () async {
                print("refresh");
              },
              child: ListView(
                children: [
                  Center(
                    child: FutureBuilder<Day>(
                      future: context.watch<AbsentsTableApiBloc>().dayTomorrow,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data.day["title"] != null) {
                            List _titleSplit =
                                snapshot.data.day["title"].split(" ");
                            return Text(
                              _titleSplit[1] +
                                  " " +
                                  _titleSplit[3] +
                                  " " +
                                  _titleSplit[2],
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            );
                          } else {
                            return Text(
                              "Weekend or Holidays",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return Text(
                            "Sever not reachable",
                            style: TextStyle(color: Colors.red),
                          );
                        }

                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      },
                    ),
                  ),
                  AbsentsTableFuture(
                      futureObject:
                          context.watch<AbsentsTableApiBloc>().dayTomorrow),
                ],
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: NestedScrollView(
            headerSliverBuilder: (sliverContext, innerBoxScrolled) => [
              SliverAppBar(
                elevation: 10,
                forceElevated: true,
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).primaryColor,
                stretch: true,
                toolbarHeight: 44,
                collapsedHeight: 45,
                expandedHeight: 100,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Days view',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )
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
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      context.read<IndexTableViewBloc>().index = 0;
                    }),
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
            ],
            body: RefreshIndicator(
              onRefresh: () async {
                print("refresh");
              },
              child: FutureBuilder<Days>(
                future: context.watch<AbsentsTableApiBloc>().days,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => tableViewItem(
                                      snapshot.data.days[i], context),
                                ),
                              );
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
            ),
          ),
        ),
      ],
    );
  }
}
