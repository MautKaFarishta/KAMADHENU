import 'package:Kamadhenu/screens/create.dart';
import 'package:Kamadhenu/screens/home.dart';
import 'package:flutter/material.dart';
import 'screens/login.dart';

void main() {  //Main Function
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  
    Widget build(BuildContext context){
      return  MaterialApp(

        title:'Kamadhenu', //title of app shown  when we press 'recent apps' button on android
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
           '/': (context) => Formscreen(),
           '/login': (context) => LoginPage(),
           '/home': (context) => HomePage(),
         },        
      );
    }

}
