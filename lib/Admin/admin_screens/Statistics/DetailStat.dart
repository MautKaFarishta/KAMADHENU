

import 'package:Kamadhenu/Admin/admin_screens/Statistics/Pie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../home.dart';

class DetailStat extends StatelessWidget {

  String collection;
  String detail;
  DetailStat({this.collection,this.detail});

  getDate(date) {
    DateTime dOB = date.toDate();
    var formattedDate = DateFormat.yMMMd().format(dOB);
    return formattedDate;
  }

  detailCard(var document) {
    return document['CattleID']==null?
    Container(
      child: Text('No data Available',style: TextStyle(fontSize:20),),
    ):
    Column(
      children: <Widget>[
        SizedBox(height: 4),
        new Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade200,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(width: 1.0, color: Colors.black38),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  document['CattleID'],
                  style: TextStyle(fontSize: 13),
                ),
                Text(
                  document['Detail'],
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  document['Note'],
                  style: TextStyle(fontSize: 14),
                ),
                //Text('${document['Name']}' ?? 'Aadhar : null'),
                Text(getDate(document['Date'])),
                //Text('Birth :${document['DOB'].toDate().toString()}'),
                SizedBox(height: 10),
              ],
            )),
      ],
    );
  }


  
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(collection),
      ),
      body:SingleChildScrollView(
              child: Center(
          child: Column(
            children: <Widget>[
              
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: StreamBuilder<QuerySnapshot>(
                  //Error  SOlved HEre!
                  stream: Firestore.instance
                      .collection('Admin')
                      .document(regn)
                      .collection(collection)
                      .where('Detail',isEqualTo: detail)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator();
                      default:
                        return Column(
                          children: <Widget>[
                            new ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: snapshot.data.documents
                                  .map((DocumentSnapshot document) {
                                return FlatButton(
                                  onPressed: () {
                                    print(" Button Pressed");
                                    
                                  },
                                  child: detailCard(document),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}