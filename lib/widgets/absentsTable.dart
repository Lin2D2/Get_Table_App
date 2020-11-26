import 'package:flutter/material.dart';

// TODO add diffrent backgroiund color for chnages
Table createAbsentsTable(List header, List content,
    {String year, List<Map> courses}) {
  List<TableRow> rows = [];
  int index = 1;
  for (final List row in content) {
    if (year == null) {
      rows.add(TableRow(
        decoration: BoxDecoration(
          color: index.isEven
              ? Color.fromRGBO(250, 211, 166, 1)
              : Color.fromRGBO(253, 236, 217, 1),
        ),
        children: List.generate(
          row.length,
          (rowElement) => Center(
            child: Text(
              row[rowElement],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ));
    } else if (row[1].toString().contains(year)) {
      rows.add(TableRow(
        decoration: BoxDecoration(
          color: index.isEven
              ? Color.fromRGBO(250, 211, 166, 1)
              : Color.fromRGBO(253, 236, 217, 1),
        ),
        children: List.generate(
          row.length,
          (rowElement) => Center(
            child: Text(
              row[rowElement],
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ));
    }
    index++;
  }
  return Table(
      border: TableBorder.all(),
      children: List.generate(
            header.length,
            (row) => TableRow(
              decoration: BoxDecoration(
                color: Colors.grey[900],
              ),
              children: List.generate(
                header[row].length,
                // Demo Content
                (rowElement) => Center(
                  child: Text(
                    header[row][rowElement],
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ) +
          rows);
}
