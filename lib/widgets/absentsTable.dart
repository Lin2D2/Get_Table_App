import 'package:flutter/material.dart';

// TODO add diffrent backgroiund color for chnages
// TODO maybe it's a better idea to handel removal of a Column after the table is generated and store the table global
Widget createAbsentsTable(List header, List content,
    {String year,
    List<Map> courses,
    bool fullMatch = false,
    bool recursive = false,
    bool smallScreen = false}) {
  if (content == null) {
    return Center(
      child: Text(
        "Keine Vertretung gefunden",
        style: TextStyle(fontSize: 15, color: Colors.red),
      ),
    );
  }
  List boldList = [0, 1, 2, 3, 4, 5];
  List<TableRow> rows = [];
  List addedIndexes = [];
  int index = 1;
  for (final List row in content) {
    if (year == null) {
      List<Widget> rowElements = [];
      int lowerIndex = 0;
      for (final rowElement in row) {
        if (smallScreen ? ![6, 7, 8].contains(lowerIndex) : true) {
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
      addedIndexes.add(index);
      rows.add(TableRow(
          decoration: BoxDecoration(
            color: addedIndexes.length.isOdd
                ? Color.fromRGBO(250, 211, 166, 1)
                : Color.fromRGBO(253, 236, 217, 1),
          ),
          children: rowElements));
    } else if (row[1].toString().contains(year) ||
        (row[1].toString().contains(" ") && !row[0].toString().contains(" ")) ||
        row[1].toString().contains("AG")) {
      // TODO check if this still works if because year is now 5 to 13 and not:
      // NOTE 12. Jg. or 13. Jg. or 5a or 10FL
      !fullMatch
          ? fullMatch = row[1].toString() == year
          : fullMatch = fullMatch;
      if (fullMatch && !recursive) {
        break;
      }
      List<Widget> rowElements = [];
      int lowerIndex = 0;
      for (final rowElement in row) {
        if ((year != null || year != "") &&
            (fullMatch ? lowerIndex != 1 : true) &&
            (smallScreen ? ![6, 7, 8].contains(lowerIndex) : true)) {
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
      addedIndexes.add(index);
      rows.add(TableRow(
          decoration: BoxDecoration(
            color: addedIndexes.length.isOdd
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
      if ((year != null || year != "") &&
          (fullMatch ? headerIndex != 1 : true) &&
          (smallScreen ? ![6, 7, 8].contains(headerIndex) : true)) {
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
    if (rows.length > 0) {
      return Table(
        border: TableBorder.all(),
        children: [headerRow] + rows,
        columnWidths:
            fullMatch ? {1: FlexColumnWidth(2)} : {2: FlexColumnWidth(2)},
      );
    } else {
      return Center(
        child: Text(
          "Keine Vertretung für den Jahrgang " + year.toString() + " gefunden",
          style: TextStyle(fontSize: 15),
        ),
      );
    }
  } else {
    return createAbsentsTable(header, content,
        year: year,
        courses: courses,
        fullMatch: fullMatch,
        recursive: true,
        smallScreen: smallScreen);
  }
}
