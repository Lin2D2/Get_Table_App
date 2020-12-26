import 'package:Get_Table_App/blocs/timeTableItemsBlock.dart';
import 'package:Get_Table_App/blocs/userBloc.dart';
import 'package:Get_Table_App/services/timetableService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';

Widget timeTableToolRow(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
    child: Row(
      // TODO display A or B week here
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 25,
          width: 82,
          child: Row(
            children: [
              Text("year:"),
              Container(
                height: 15,
                width: 50,
                // TODO the value isn't set
                // child: TextField(
                //   autocorrect: false,
                //   enabled: context.watch<TimeTableItemsBlock>().edit,
                //   controller:
                //       context.watch<TimeTableItemsBlock>().yearController,
                //   onChanged: (value) {
                //     context.read<TimeTableItemsBlock>().year = value;
                //   },
                // ),
                child: context.watch<TimeTableItemsBlock>().edit
                    ? TextField(
                        autocorrect: false,
                        controller:
                            context.watch<TimeTableItemsBlock>().yearController,
                        onChanged: (value) {
                          context.read<TimeTableItemsBlock>().year = value;
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
                Text(
                    context.watch<TimeTableItemsBlock>().edit ? "Save" : "Edit")
              ],
            ),
            onPressed: context.watch<TimeTableItemsBlock>().edit
                ? () async {
                    context.read<UserBloc>().timetable =
                        context.read<TimeTableItemsBlock>().copyTimeTable;
                    context.read<TimeTableItemsBlock>().edit = false;
                    context.read<TimeTableItemsBlock>().selectedElement = null;
                    context.read<UserBloc>().year =
                        context.read<TimeTableItemsBlock>().year;
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
