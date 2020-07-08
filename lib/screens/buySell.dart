import 'package:Kamadhenu/Forms.dart/create.dart';
import 'package:flutter/material.dart';
import 'Portal.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';

class Buysell extends StatefulWidget {
  State<StatefulWidget> createState() {
    return BuySellPortal();
  }
}

class BuySellPortal extends State<Buysell> {
  @override
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Select Category"),
          backgroundColor: Colors.blue.shade900,
        ),
        body: ListView(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Cow"),
                leading: ClipRRect(child: Image.asset('assets/images/cow.jpg')),
                onTap: () => {
                  p.species_name = "Cow", //Which animal is to be fetched
                  Navigator.pushNamed(context, '/portal')
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text("Buffalo"),
                leading: ClipRRect(
                  child: Image.asset('assets/images/buffalo.jpg'),
                ),
                onTap: () => {
                  p.species_name = "Buffalo",
                  Navigator.pushNamed(context, '/portal')
                },
              ),
            )
          ],
        ));
  }
}
