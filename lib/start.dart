import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Start extends StatefulWidget {
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<Start> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Choose Your type"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                runApp(MyApp());
              },
              child: Text(
                "User",
                textScaleFactor: 2,
              ),
            ),
            RaisedButton(
              onPressed: () {
                runApp(MyAppAdmin());
              },
              child: Text(
                "Admin",
                textScaleFactor: 2,
              ),
            ),
          ],
        )));
  }
}
