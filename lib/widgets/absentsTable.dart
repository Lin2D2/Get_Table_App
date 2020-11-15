import 'package:flutter/material.dart';

Table createAbsentsTable(List header, List content,
    {String year, List<Map> courses}) {
  List<TableRow> rows = [];
  for (final List row in content) {
    if (year == null) {
      rows.add(TableRow(
        children: List.generate(
          row.length,
          // Demo Content
              (rowElement) => Center(
            child: Text(
              row[rowElement],
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
      ));
    }
    else if (row[1] == year) {
      rows.add(TableRow(
        children: List.generate(
          row.length,
          // Demo Content
              (rowElement) => Center(
            child: Text(
              row[rowElement],
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
      ));
    }
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
        ) + rows
  );
}
