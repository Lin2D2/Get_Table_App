import 'package:flutter/material.dart';

Card createDashboardCard(String title, Widget table) {
  return Card(
    color: Colors.white,
    elevation: 5.0,
    child: Column(
      children: [
        Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: table,
        ),
      ],
    ),
  );
}
