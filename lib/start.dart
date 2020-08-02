import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/permanent.dart' as P;

import 'User/Forms/create.dart';
import 'main.dart';
import 'main.dart';




class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  dem(String value) {
    userType = value;
    print(userType);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    P.getUserType().then((value) => dem(value));
    print(userType);
  }
  @override
  Widget build(BuildContext context) {
    String user = 'User';
    String admin = 'Admin';
    if(userType=='User'){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MyApp()));
    }
    else if(userType == 'Admin'){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => MyAppAdmin()));
    }
    else{return  Scaffold(
        appBar: AppBar(
          title: Text("Choose Your type"),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: ()  {
                    userType = user;
                    P.addUserType(userType);
                    runApp(MyApp());
                  },
                  child: Text(
                    "User",
                    textScaleFactor: 2,
                  ),
                ),
                RaisedButton(
                  onPressed: ()  {
                    userType = admin;
                    P.addUserType(userType);
                    runApp(MyAppAdmin());
                  },
                  child: Text(
                    "Admin",
                    textScaleFactor: 2,
                  ),
                ),
              ],
            )));}

  }
}







