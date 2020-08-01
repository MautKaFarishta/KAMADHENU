import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/permanent.dart' as P;

import 'User/Forms/create.dart';
import 'main.dart';
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
              onPressed: () async {
                userType = "User";
                P.addUserType(userType);
                runApp(MyApp());
              },
              child: Text(
                "User",
                textScaleFactor: 2,
              ),
            ),
            RaisedButton(
              onPressed: () async {
                userType = "Admin";
                P.addUserType(userType);
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
