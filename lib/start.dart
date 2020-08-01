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
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                runApp(MyApp());
              },
              child: Text("User"),
            ),
            RaisedButton(
              onPressed: () {
                runApp(MyAppAdmin());
              },
              child: Text("Admin"),
            ),
          ],
        ));
  }
}
