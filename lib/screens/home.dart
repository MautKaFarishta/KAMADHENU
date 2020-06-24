import 'package:flutter/material.dart';
import 'package:Kamadhenu/Forms.dart/add_animal.dart';

import 'main_drawer.dart';

class HomePage extends StatefulWidget {
  
  State<StatefulWidget> createState() => new _HomePageState(); //Define State
}

class _HomePageState extends State<HomePage> {
  
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddAnimal()), //Route to Create Acc PAge
          );
        },
        //icon:Icon(Icons.add),
        label: Text('REGISTER'),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
