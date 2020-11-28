import 'package:flutter/material.dart';

// TODO add diffrent backgroiund color for chnages
// TODO maybe it's a better idea to handel removal of a Column after the table is generated and store the table global
Table createAbsentsTable(List header, List content,
    {String year,
    List<Map> courses,
    bool fullMatch = false,
    bool recursive = false}) {
  List boldList = [0, 2, 3, 4, 8];
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
                fontWeight: boldList.contains(rowElement.toInt())
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ));
    } else if (row[1].toString().contains(year) ||
        (row[1].toString().toString().contains(" ") &&
            !row[0].toString().toString().contains(" "))) {
      !fullMatch
          ? fullMatch = row[1].toString() == year
          : fullMatch = fullMatch;
      if (fullMatch && !recursive) {
        break;
      }
      List<Widget> rowElements = [];
      int lowerIndex = 0;
      for (final rowElement in row) {
        if ((year == null || year == "" || lowerIndex != 1) || !fullMatch) {
          rowElements.add(
            Center(
              child: Text(
                rowElement,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: boldList.contains(lowerIndex)
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          );
        }
        lowerIndex++;
      }
      rows.add(TableRow(
          decoration: BoxDecoration(
            color: index.isEven
                ? Color.fromRGBO(250, 211, 166, 1)
                : Color.fromRGBO(253, 236, 217, 1),
          ),
          children: rowElements));
    }
    index++;
  }
  if (!fullMatch ^ recursive) {
    List<Widget> headerElements = [];
    int headerIndex = 0;
    for (final headerElement in header[0]) {
      if ((year == null || year == "" || headerIndex != 1) || !fullMatch) {
        headerElements.add(
          Center(
            child: Text(
              headerElement,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        );
      }
      headerIndex++;
    }
    TableRow headerRow = TableRow(
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        children: headerElements);
    return Table(border: TableBorder.all(), children: [headerRow] + rows);
  } else {
    return createAbsentsTable(header, content,
        year: year, courses: courses, fullMatch: fullMatch, recursive: true);
  }
}
