// import 'dart:html';

// import 'dart:js';

import 'package:Kamadhenu/User/UI/decorations.dart';
import 'package:Kamadhenu/User/localization/localizationConstant.dart';
import 'package:Kamadhenu/User/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Forms/addInfo.dart' as A;
import 'package:Kamadhenu/User/screens/AnimalInfo.dart' as AI;
import 'package:Kamadhenu/User/screens/ImagePicker.dart' as IP;
import 'package:Kamadhenu/User/screens/ChangeOwnership.dart' as ChaO;

class CatPro extends StatelessWidget {
  final catID;
  CatPro({this.catID});

  getDate(date) {
    DateTime dOB = date.toDate();
    var formattedDate = DateFormat.yMMMd().format(dOB);
    return formattedDate;
  }

  Widget getList(BuildContext context, DocumentSnapshot document) {
    DateTime dOB = (document['Date']).toDate();
    var ldOB = DateFormat.yMMMd().format(dOB);

    print('Getting info for ${document['CattleID']} with  ${document['Note']}');

    return Container(
        child: ListTile(
      //title: Center(child: Text(document['Detail'],style: TextStyle(fontSize:17),)),
      isThreeLine: true,
      subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
                child: Row(children: <Widget>[
              Text(
                document['Detail'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                getDate(document['Date']),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ])),
            Text(getTranslated(context, "Other Details") + document['Note']),
          ]),
    ));
  }

  Future<void> _movement(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(getTranslated(context, "Choose option")),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(getTranslated(context, "Change Ownership")),
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.pushNamed(context, '/changeOwnership');
                    },
                  ),
                  Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    child: Text(getTranslated(context, "Mark as Dead")),
                  )
                ],
              ),
            ));
      },
    );
  }

  _buyInfo(DocumentSnapshot doc, BuildContext context) {
    if (!doc['OnSale']) {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: FlatButton(
            child: Text(
              getTranslated(context, "Sell"),
              textScaleFactor: 1.2,
            ),
            onPressed: () {
              IP.currID =
                  Firestore.instance.collection('cattles').document(catID);
              AI.breed = '${doc['Breed']}';
              AI.animal_id = '${doc['Species']}';
              AI.rfid = '${doc['RFID']}';
              Navigator.pushNamed(context, "/animalInfo");
            },
          ),
        ),
      );
    } else {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: FlatButton(
              highlightColor: Colors.blue[200],
              color: Colors.red[200],
              child: Text(
                getTranslated(context, "Remove from sale"),
                textScaleFactor: 1.2,
              ),
              onPressed: () {
                Firestore.instance
                    .collection('cattlesForSale')
                    .document(catID)
                    .delete();
                Firestore.instance
                    .collection('cattles')
                    .document(catID)
                    .setData({'OnSale': false}, merge: true);
              }),
        ),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Cattle Profile')),
        backgroundColor: Colors.blue.shade900,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('cattles')
                .document(catID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text(getTranslated(context, "Loading"));
              }
              var catDoc = snapshot.data;
              return Center(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      catDoc['RFID'] == 'NA'
                          ? Container(
                              width: double.infinity,
                              decoration: Deco().decoBox(Colors.red.shade200),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 5),
                                  Text(getTranslated(context,
                                      'RFID Registration of your cattle is remaining')),
                                  Text(getTranslated(context,
                                      'Please Contact AHD office near you')),
                                  SizedBox(height: 5),
                                ],
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              decoration: Deco().decoBox(Colors.blue.shade50),
                              child: Center(
                                child: Text(
                                  'RFID : ${catDoc['RFID']}',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 10),
                      Container(
                        decoration: Deco().decoBox(Colors.blue.shade50),
                        child: Column(children: <Widget>[
                          Deco().titleCon(
                              getTranslated(context, 'ANIMAL INFORMATION')),
                          SizedBox(height: 10),
                          Text(
                            getTranslated(context, 'Animal Type') +
                                ' : ${catDoc['Species']}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            getTranslated(context, 'Gender') +
                                ' : ${catDoc['Gender']}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            getTranslated(context, 'Animal Breed') +
                                ' : ${catDoc['Breed']}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            getTranslated(context, 'Birth Date') +
                                ' : ${getDate(catDoc['DOB'])}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: 20),
                      catDoc['Gender'] == 'Female'
                          ? Container(
                              decoration: Deco().decoBox(Colors.blue.shade50),
                              child: Column(children: <Widget>[
                                Deco().titleCon(getTranslated(
                                    context, 'PREGNENCY DETAILS')),
                                SizedBox(height: 10),
                                Text('Last Calving Date',
                                    style: TextStyle(
                                      fontSize: 17,
                                    )),
                                Text(
                                  '${getDate(catDoc['Calving_Dates'])}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Total Calvings : ${catDoc['Calvings']}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                                SizedBox(height: 10),
                              ]),
                            )
                          : SizedBox(height: 1),
                      SizedBox(height: 20),
                      Container(
                        decoration: Deco().decoBox(Colors.blue.shade50),
                        child: Column(children: <Widget>[
                          Deco().titleCon(
                              getTranslated(context, 'VACCINE DETAILS')),
                          StreamBuilder(
                            stream: Firestore.instance
                                .collection('Admin')
                                .document(catDoc['Region'])
                                .collection('vaccine_details')
                                .where('CattleID', isEqualTo: catID)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
                                return const Text("Loading...");
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => getList(
                                    context,
                                    snapshot.data.documents[
                                        index]), //pass index of every fetched document
                              );
                            },
                          ),
                        ]),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: Deco().decoBox(Colors.blue.shade50),
                        child: Column(children: <Widget>[
                          Deco().titleCon(
                              getTranslated(context, 'PREGNENCY HISTORY')),
                          StreamBuilder(
                            stream: Firestore.instance
                                .collection('Admin')
                                .document(catDoc['Region'])
                                .collection('pregnency_details')
                                .where('CattleID', isEqualTo: catID)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null)
                                return const Text("Loading...");
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context, index) => getList(
                                    context,
                                    snapshot.data.documents[
                                        index]), //pass index of every fetched document
                              );
                            },
                          ),
                        ]),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: FlatButton(
                                child: Container(
                                  child: Text(
                                    getTranslated(context, 'Add Info'),
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  A.gender=catDoc['Gendr'];
                                  A.catID = catID;
                                  A.region = catDoc['Region'];
                                  print(
                                      'Adding info for ${A.catID} in Region ${A.region}');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => A.MoreInfo()),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: FlatButton(
                                onPressed: () {
                                  ChaO.cattleID = catID;
                                  _movement(context);
                                },
                                child: Text(getTranslated(context, "Movement")),
                              ),
                            ),
                          ),
                          _buyInfo(catDoc, context),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
