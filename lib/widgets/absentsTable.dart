import 'package:flutter/material.dart';

Table createAbsentsTable(String header, Map content, {Map filter}) {
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
        List.generate(
          content.length,
          // Demo Content
          (row) => TableRow(
            children: List.generate(
              content[row].length,
              // Demo Content
              (rowElement) => Center(
                child: Text(
                  content[row][rowElement],
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ),
  );
}
