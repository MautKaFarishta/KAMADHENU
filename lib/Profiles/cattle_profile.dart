import 'package:Kamadhenu/UI/decorations.dart';
import 'package:Kamadhenu/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Forms/addInfo.dart' as A;
import 'package:Kamadhenu/screens/AnimalInfo.dart' as AI;

class CatPro extends StatelessWidget {
  final String catID;
  final String regn;
  CatPro({this.catID, this.regn});

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
              child: Row(
                children: <Widget>[
                  Text(
                    document['Detail'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    ldOB,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text("Other Details : " + document['Note']),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    print('cattle profile of $catID in region $regn');
    return Scaffold(
      appBar: AppBar(
        title: Text('Cattle Profile'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection('cattles')
                .document(catID)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var catDoc = snapshot.data;
              DateTime dOB = (catDoc['DOB']).toDate();
              var ldOB = DateFormat.yMMMd().format(dOB);
              DateTime dOC = (catDoc['DOB']).toDate();
              var ldOC = DateFormat.yMMMd().format(dOC);
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
                                  Text(
                                      'RFID Registration of your cattle is remaining'),
                                  Text('Please Contact AHD office near you'),
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
                          Deco().titleCon('ANIMAL INFORMATION'),
                          SizedBox(height: 10),
                          Text(
                            'Animal Type : ${catDoc['Species']}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Animal Breed : ${catDoc['Breed']}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Birth : $ldOB',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: Deco().decoBox(Colors.blue.shade50),
                        child: Column(children: <Widget>[
                          Deco().titleCon('PREGNENCY DETAILS'),
                          SizedBox(height: 10),
                          Text(
                            'Last Calving Date',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            '$ldOC',
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
                      ),
                      SizedBox(height: 20),
                      Container(
                        decoration: Deco().decoBox(Colors.blue.shade50),
                        child: Column(children: <Widget>[
                          Deco().titleCon('VACCINE DETAILS'),
                          StreamBuilder(
                            stream: Firestore.instance
                                .collection('Admin')
                                .document(regn)
                                .collection('vaccine_details')
                                .where('CattleID', isEqualTo: catID)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData)
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
                      Container(
                        decoration: Deco().decoBox(Colors.blue.shade50),
                        child: Column(children: <Widget>[
                          Deco().titleCon('PREGNENCY HISTORY'),
                          StreamBuilder(
                            stream: Firestore.instance
                                .collection('Admin')
                                .document(regn)
                                .collection('pregnency_details')
                                .where('CattleID', isEqualTo: catID)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null)
                                return Text(
                                  "No Details are Added.",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                );
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: FlatButton(
                          child: Container(
                            child: Text(
                              ' Add Info. ',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          onPressed: () {
                            A.catID = catID.toString();
                            A.region = regn;
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
                      RaisedButton(
                        highlightColor: Colors.blue[200],
                        color: Colors.green[200],
                        child: Text(
                          "Sell",
                          textScaleFactor: 1.2,
                        ),
                        onPressed: () {
                          AI.breed = '${catDoc['Breed']}';
                          AI.animal_id = '${catDoc['Species']}';
                          Navigator.pushNamed(context, "/animalInfo");
                        },
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
