<<<<<<< HEAD
import 'package:Kamadhenu/Forms.dart/create.dart';
import 'package:Kamadhenu/screens/Portal.dart';
import 'package:Kamadhenu/screens/buySell.dart';
=======
import 'package:Kamadhenu/methods/authservice.dart';
import 'package:Kamadhenu/Forms/create.dart';
import 'package:Kamadhenu/Forms/create.dart';
>>>>>>> af3e7ff11ac13a5a74e2f4ecd70812f772818055
import 'package:Kamadhenu/screens/home.dart';
import 'package:Kamadhenu/screens/profile.dart';
import 'package:flutter/material.dart';
import 'screens/Portal.dart';
import 'screens/home.dart';
<<<<<<< HEAD
import 'Forms.dart/login.dart';
import 'screens/buySell.dart';
=======
import 'Forms/login.dart';

>>>>>>> af3e7ff11ac13a5a74e2f4ecd70812f772818055

void main() {
  //Main Function
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
<<<<<<< HEAD
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
=======

  
    Widget build(BuildContext context){
      return  MaterialApp(

        title:'Kamadhenu', //title of app shown  when we press 'recent apps' button on android
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:AuthService().handleAuth(),
        //ProfilePage(),
        //HomePage(),
      );
    }

>>>>>>> af3e7ff11ac13a5a74e2f4ecd70812f772818055
}
