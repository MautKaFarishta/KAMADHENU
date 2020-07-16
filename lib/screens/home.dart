import 'package:Kamadhenu/Profiles/cattle_profile.dart';
import 'package:Kamadhenu/methods/database.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/Forms/add_animal.dart';
import 'package:Kamadhenu/screens/AnimalInfo.dart' as AI;
import 'package:cloud_firestore/cloud_firestore.dart';
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
        body: ListPage());
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('cattles').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return FlatButton(
                      onPressed: () {
                        print("${document.documentID} Button Pressed");
                        AI.animal_id = "${document.documentID}";
                        AI.breed = document["Breed"];
                        AI.sell = true;
                        Navigator.pushNamed(context, "/AnimalInfo");
                      },
                      child: new Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            border: Border(
                              top:
                                  BorderSide(width: 1.0, color: Colors.black38),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Text(
                                'ID:${document.documentID}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                document['Species'].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                document['Breed'],
                              ),
                              Text(
                                  'Birth :${document['DOB'].toDate().toString()}'),
                              SizedBox(height: 20),
                            ],
                          )),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
