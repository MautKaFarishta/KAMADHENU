import 'package:Kamadhenu/Forms/create.dart';
import 'package:Kamadhenu/screens/Portal.dart';
import 'package:Kamadhenu/screens/buySell.dart';
import 'package:Kamadhenu/methods/authservice.dart';
import 'package:Kamadhenu/Forms/create.dart';
import 'package:Kamadhenu/Forms/create.dart';
import 'package:Kamadhenu/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/Portal.dart';
import 'screens/home.dart';
import 'Forms/login.dart';
import 'screens/buySell.dart';
import 'Forms/login.dart';


void main() {
  //Main Function
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Kamadhenu', //title of app shown  when we press 'recent apps' button on android
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        // '/home': (context) => HomePage(),
        '/Buysell': (BuildContext ctx) => Buysell(),
        '/portal': (BuildContext ctx) => Portal(),
      },
    );
  }
}
