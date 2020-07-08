import 'dart:async';

import 'package:Kamadhenu/Profiles/cattle_profile.dart';
import 'package:Kamadhenu/methods/authservice.dart';
import 'package:Kamadhenu/methods/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/Forms/add_animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_drawer.dart';

class HomePage extends StatefulWidget {
  State<StatefulWidget> createState() => new _HomePageState(); //Define State
}

class _HomePageState extends State<HomePage> {
  String userID;

  Widget build(BuildContext context) {
    void getid(String foo) {
      userID = foo;
    }

    AuthService().getCurrentUID().then((value) => getid(value));

    return Scaffold(
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.blue.shade900,
              titleSpacing: 70,
              title: Text('Kamadhenu'),
              expandedHeight: 170.0,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                background: StreamBuilder<DocumentSnapshot>(
                  stream: Firestore.instance
                      .collection('Users')
                      .document(userID)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                        var userData = snapshot.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30),
                            Text(
                              '${userData['name']}',
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${userData['mobile']}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${userData['State']}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${userData['District']}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                    }
                  },
                ),
              ),
            ),
          ];
        },
        body: Center(
          child: ListPage(),
        ),
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String userID;
  Widget build(BuildContext context) {
    void getid(String foo) {
      userID = foo;
    }

    AuthService().getCurrentUID().then((value) => getid(value));

    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<QuerySnapshot>(
          //Error  SOlved HEre!
          stream: Firestore.instance
              .collection('Users')
              .document(userID)
              .collection('cattles')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return FlatButton(
                      onPressed: () {
                        print("${document['Species']} Button Pressed");
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CatPro(catID: document.documentID)));
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 7),
                          new Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    width: 1.0, color: Colors.black38),
                              ),
                              child: Column(
                                children: <Widget>[
                                  
                                  Text(
                                    'ID:${document.documentID}',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    document['Species'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    document['Breed'],
                                  ),
                                  Text(
                                      'Birth :${document['DOB'].toDate().toString()}'),
                                  SizedBox(height: 10),
                                ],
                              )),
                        ],
                      ),
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
