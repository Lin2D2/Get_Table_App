import 'package:flutter/material.dart';

TableRow timeTableEditHeaderRow() {
  return TableRow(
    decoration: BoxDecoration(
      color: Colors.grey[900],
    ),
    children: [
      Text(
        "week",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white),
      ),
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
    ],
  );
}