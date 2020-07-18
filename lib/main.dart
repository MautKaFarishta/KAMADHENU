import 'package:Kamadhenu/Forms/create.dart';
import 'package:Kamadhenu/screens/AnimalInfo.dart';
import 'package:Kamadhenu/screens/ImagePicker.dart';
import 'package:Kamadhenu/screens/Portal.dart';
import 'package:Kamadhenu/screens/buySell.dart';
import 'package:Kamadhenu/methods/authservice.dart';
import 'package:flutter/material.dart';

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
      home: AuthService().handleAuth(),
      routes: {
         '/Buysell': (BuildContext ctx) => Buysell(),
         '/portal': (BuildContext ctx) => Portal(),
         '/AnimalInfo': (BuildContext ctx) => AnimalInfo(),
         '/ImagePicker': (BuildContext ctx) => ImagePicker(),
       },
    );
  }
}
