import 'package:Get_Table_App/blocs/dropdownMenuBloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeekDropdownButton extends StatelessWidget {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50.0,
        child: DropdownButton<String>(
          icon: Icon(Icons.assignment),
          iconSize: 24,
          elevation: 16,
          value: context.watch<DropdownMenuBloc>().value,
          onChanged: (String newValue) {
            context.read<DropdownMenuBloc>().set(newValue);
          },
          items: <String>["A/B", 'A', 'B'] // TODO add new line for A or B below for same lesson to set differnet week
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}