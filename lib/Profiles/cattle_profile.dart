import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CatPro extends StatelessWidget {
  final String catID;
  CatPro({this.catID});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cattle Profile'),
        backgroundColor: Colors.blue.shade900,  
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('cattles')
              .document(catID)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var catDoc = snapshot.data;
            return Center(
              child: Container(
                margin: EdgeInsets.all(14),
                child: Column(
                  children: <Widget>[
                    catDoc['RFID']==null ?
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:Colors.red.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 1.0, color: Colors.red.shade900,
                        ),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height:5),
                          Text('RFID Registration of your cattle is remaining'),
                          Text('Please Contact AHD office near you'),
                          SizedBox(height:5),
                        ],
                      ),
                    ):
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:Colors.blue.shade200,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child:Center(
                        child: Text('RFID : ${catDoc['RFID']}',
                          style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height:10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 1.0, color: Colors.blue.shade300,
                        ),  
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                'ANIMAL INFORMATION',
                                style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                          Text('Animal Type : ${catDoc['Species']}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height:10),
                          Text('Animal Breed : ${catDoc['Breed']}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height:10),
                          Text('Birth : ${catDoc['DOB'].toDate().toString()}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height:20),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 1.0, color: Colors.blue.shade300,
                        ),  
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[200],
                              borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: Text(
                                'PREGNENCY DETAILS',
                                style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          SizedBox(height:10),
                          Text('Last Calving Date',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          Text('${catDoc['Calving_Dates'].toDate().toString()}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height:10),
                          Text('Total Calvings : ${catDoc['Calvings']}',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(height:10),
                        ]
                      ),
                    ),
                    SizedBox(height:10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius:
                          BorderRadius.all(Radius.circular(10)),
                      ),
                      child: FlatButton(
                        child: Container(
                          child: Text(' Edit ',
                            style:TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        onPressed: (){
                          print('Button');
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
