

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NotificationPanel extends StatelessWidget {
  String region;
  NotificationPanel({this.region});
  DateTime today_date = DateTime.now();
  

  @override
  Widget build(BuildContext context) {

    getDate(date){

    DateTime dOB = date.toDate();
    var formattedDate=DateFormat.yMMMd().format(dOB);
    return formattedDate;

  }
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              print(today_date);
              Navigator.pop(context);
            }),
        backgroundColor: Colors.blue.shade900,
        title: Text("All Notifications"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Admin')
            .document(region)
            .collection('Broadcast')
            .where('Ending Date', isGreaterThan: today_date)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              return new ListView(
                shrinkWrap: true,
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                    var endDate = document['Starting Date'].toDate();
                    var diff =today_date.difference(endDate).inDays;

                  return FlatButton(
                    onPressed: () {
                      print("${document.documentID} Button Pressed");
                      print(today_date);
                    },
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 7),
                        new Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              border:
                                  Border.all(width: 1.0, color: Colors.black38),
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  '${document['Title']}',
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  '${document['Content']}',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                    'End Date:${getDate(document['Ending Date'])}'),
                                Text('$diff days ago',style: TextStyle(fontSize:12,fontStyle: FontStyle.italic),),
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
    );
  }
}