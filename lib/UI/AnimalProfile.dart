import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String cattlesID;
String imageUrl;
String userID;

class AnimalProfile extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _AnimalProfile();
  }
}

class _AnimalProfile extends State<AnimalProfile> {
  final cattleData = Firestore.instance.collection("cattles");
  final userData = Firestore.instance.collection('Users');
  _showBuyRequestDialogue() {}
  Widget build(context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showBuyRequestDialogue();
          },
          child: Icon(Icons.shopping_cart),
          elevation: 5.5,
        ),
        appBar: AppBar(
          title: Text("animal Profile"),
        ),
        body: StreamBuilder(
          stream: getData(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
                child: Column(children: <Widget>[
              Card(
                child: Center(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                margin: EdgeInsets.all(5),
                borderOnForeground: true,
                color: Colors.blue[100],
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Species: ",
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['Species'],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Breed: ",
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['Breed'],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Gender: ",
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['Gender'],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Region: ",
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      snapshot.data['Region'],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Seller's Contact: ",
                      textScaleFactor: 1.2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userID,
                    ),
                  ],
                ),
              ),
            ]));
          },
        ));
  }

  Stream<DocumentSnapshot> getData() {
    return Firestore.instance
        .collection('cattles')
        .document(cattlesID)
        .snapshots();
  }
}
