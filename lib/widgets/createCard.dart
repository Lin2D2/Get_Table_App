import 'package:flutter/material.dart';

Card createCard(BuildContext context, Widget object,
    {String title, String massage}) {
  // TODO fix message sever side
  if (massage == "Es gibt k") {
    massage = null;
  }
  return Card(
    color: Colors.white,
    elevation: 5.0,
    child: Column(
      children: massage != null
          ? (title != null
              ? [
                  Center(
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Text(
                    "Nachrichten zum Tag:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      massage,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: object,
                  ),
                ]
              : [
                  Text(
                    "Nachrichten zum Tag:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        decoration: TextDecoration.underline),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      massage,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: object,
                  ),
                ])
          : title != null
              ? [
                  Center(
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: object,
                  ),
                ]
              : [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: object,
                  ),
                ],
    ),
  );
}
