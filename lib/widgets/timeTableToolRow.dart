import 'package:get_table_app/blocs/timeTableItemsBlock.dart';
import 'package:get_table_app/blocs/userBloc.dart';
import 'package:get_table_app/services/timetableService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeTableToolRow extends StatefulWidget {
  TimeTableToolRow({Key key}) : super(key: key);

  @override
  _TimeTableToolRowState createState() => _TimeTableToolRowState();
}

class _TimeTableToolRowState extends State<TimeTableToolRow> {
  List<String> _years = ["5", "6", "7", "8", "9", "10", "11", "12", "13"];
  @override
  Widget build(BuildContext context) {
    String dropdownValue = context.watch<UserBloc>().year != null
        ? context.watch<UserBloc>().year
        : "5";
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        // TODO display A or B week here
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 102,
            child: Row(
              children: [
                Text("year:"),
                Container(
                  width: 30,
                  child: context.watch<TimeTableItemsBlock>().edit
                      ? DropdownButton<String>(
                          value: dropdownValue,
                          iconSize: 0,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: _years
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(child: Text(value)),
                            );
                          }).toList(),
                          selectedItemBuilder: (BuildContext context) {
                            return _years.map<Widget>((String value) {
                              return Container(
                                alignment: Alignment.centerRight,
                                width: 30,
                                child: Center(child: Text(value)),
                              );
                            }).toList();
                          },
                        )
                      : Text(context.watch<UserBloc>().year != null
                          ? context.watch<UserBloc>().year
                          : ""),
                )
              ],
            ),
          ),
          Text("A Woche/B Woche"),
          Container(
            width: 90,
            child: RaisedButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Icon(
                      context.watch<TimeTableItemsBlock>().edit
                          ? Icons.save
                          : Icons.edit,
                      size: 20,
                    ),
                  ),
                  Text(context.watch<TimeTableItemsBlock>().edit
                      ? "Save"
                      : "Edit")
                ],
              ),
              onPressed: context.watch<TimeTableItemsBlock>().edit
                  ? () async {
                      context.read<UserBloc>().timetable =
                          context.read<TimeTableItemsBlock>().copyTimeTable;
                      context.read<TimeTableItemsBlock>().edit = false;
                      context.read<TimeTableItemsBlock>().selectedElement =
                          null;
                      context.read<UserBloc>().year = dropdownValue;
                      if (await TimeTableService.saveTimeTable(context)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Success'),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('failed'),
                          ),
                        );
                      }
                    }
                  : () {
                      context.read<TimeTableItemsBlock>().copyTimeTable =
                          context.read<UserBloc>().timetable;
                      context.read<TimeTableItemsBlock>().edit = true;
                    },
            ),
          ),
        ],
      ),
    );
  }
}
