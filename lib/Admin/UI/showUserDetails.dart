import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Kamadhenu/Admin/UI/decorations.dart';

class ShowUserDetails {
  UserCard(var document) {
    return Column(
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
                  document['name'] ?? null,
                  style: TextStyle(fontSize: 20),
                ),
                Text('Region : ${document['Region']}' ?? 'Aadhar : null'),
                //Text('Birth :${document['DOB'].toDate().toString()}'),
                SizedBox(height: 10),
              ],
            )),
      ],
    );
  }

  DetailedUserInfo(var catDoc) {
    return Center(
        child: Container(
            margin: EdgeInsets.all(10),
            child: Column(children: <Widget>[
              SizedBox(height: 10),
              Container(
                decoration: Deco().decoBox(Colors.lightBlue.shade100),
                child: Column(children: <Widget>[
                  Deco().titleCon('PERSONAL INFO.'),
                  SizedBox(height: 10),
                  Text(
                        'Name : ${catDoc['name']}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ) ??
                      Text(
                        'null',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                  SizedBox(height: 10),
                  Text(
                    'Aadhar : ${catDoc['adhar']}',
                    style: TextStyle(
                          fontSize: 17,
                        ) ??
                        Text(
                          'null',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                  ),
                  SizedBox(height: 10),
                  Text(
                        'Mobile No. : ${catDoc['mobile']}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ) ??
                      Text(
                        'null',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                ]),
              ),
              SizedBox(height: 20),
              Container(
                decoration: Deco().decoBox(Colors.lightBlue.shade100),
                child: Column(children: <Widget>[
                  Deco().titleCon('CATTLES'),
                  SizedBox(height: 10),
                  Text(
                    'Initial Cattles ',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                        '${catDoc['initial cattles']}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ) ??
                      Text(
                        'null',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                  SizedBox(height: 10),
                ]),
              ),
              SizedBox(height: 20),
              Container(
                decoration: Deco().decoBox(Colors.lightBlue.shade100),
                child: Column(children: <Widget>[
                  Deco().titleCon('RESIDENCE'),
                  Text(
                        '${catDoc['District']}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ) ??
                      Text(
                        'null',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                  Text(
                        '${catDoc['Region']}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ) ??
                      Text(
                        'null',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                  Text(
                        '${catDoc['State']}',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ) ??
                      Text(
                        'null',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                ]),
              ),
              SizedBox(height: 20),
            ])));
  }
}
