import 'package:Kamadhenu/UI/decorations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:Kamadhenu/screens/home.dart' as home;

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

  Future<void> _requestSent() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green[50],
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.green[200],
              ),
              Text(
                "REQUEST SENT",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _showBuyRequestDialogue() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Row(children: <Widget>[
              Icon(
                Icons.info,
                color: Colors.blue[300],
              ),
              Text(" Information")
            ]),
            content: Column(
              children: <Widget>[
                Text(
                    "A request will be sent to the owner of the cattle, you need to contact the owner for exchage of money and Livestock, \n\n\nPress OK to continue."),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Firestore.instance
                        .collection('Users')
                        .document(userID)
                        .collection('BuyingRequest')
                        .document()
                        .setData({
                      'BuyerID': home.userID,
                      'Name': home.currentUser.name,
                      'AnimalID': cattlesID,
                      'Region': home.currentUser.district,
                    }).whenComplete(() {
                      _requestSent();
                    });
                  },
                  color: Colors.blue[100],
                  child: Text(
                    "OK",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
            ));
      },
    );
  }

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
              Container(
                decoration: Deco().decoBox(Colors.blue.shade50),
                child: Column(children: <Widget>[
                  Deco().titleCon('ANIMAL INFORMATION'),
                  SizedBox(height: 10),
                  Text(
                    'Animal Type : ${snapshot.data['Species']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Animal Breed : ${snapshot.data['Breed']}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Birth : ${DateFormat.yMMMd().format(snapshot.data['DOB'].toDate())}',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ]),
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
