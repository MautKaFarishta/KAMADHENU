import 'package:flutter/material.dart';

import 'screens/login.dart';

void main() {  //Main Function
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  
    Widget build(BuildContext context){
      return new MaterialApp(

        title:'FLutter Login',
        theme:new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new LoginPage()//Redirect To Login PAge
      );
    }

}