import 'package:Kamadhenu/Admin/UI/decorations.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/Admin/methods/getregn.dart';

class Stat extends StatefulWidget {
  @override
  _StatState createState() => _StatState();
}

class _StatState extends State<Stat> {
  String val1;

  Widget getEl(String txt, int stat) {
    if (stat == null) {
      stat = 0;
    }
    return Expanded(
      child: Column(
        children: <Widget>[
          Text(
            txt,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            stat.toString(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget getElNew(String txt, int stat) {
    if (stat == null) {
      stat = 0;
    }
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        children: <Widget>[
          Text(
            txt,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            stat.toString(),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        //Error  SOlved HEre!
        stream:
            Firestore.instance.collection('Admin').document(regn).snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            default:
              var stat = snapshot.data;
              return new ListView(
                shrinkWrap: true,
                children: <Widget>[
                  //Text(regn ?? 'null'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    //margin: EdgeInsets.all(7),
                    decoration: Deco().decoBoxNew(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Deco().titleConNew('User Registrations'),
                        ),
                        Row(
                          children: <Widget>[
                            getEl('Total User Registrations', stat['user_Reg']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    //margin: EdgeInsets.all(7),
                    decoration: Deco().decoBoxNew(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Deco().titleConNew('Registration'),
                        ),
                        Row(
                          children: <Widget>[
                            getEl('App Registrations', stat['ByApp_Reg']),
                            Divider(),
                            getEl('RFID Registrations', stat['RFID_Reg']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    //margin: EdgeInsets.all(7),
                    decoration: Deco().decoBoxNew(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Deco().titleConNew('Reproduction'),
                        ),
                        Row(
                          children: <Widget>[
                            getEl('Total New Born', stat['newBorn']),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Row(
                          children: <Widget>[
                            getEl('AI', stat['AI']),
                            getEl('PD', stat['PD']),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    //margin: EdgeInsets.all(7),
                    decoration: Deco().decoBoxNew(),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Deco().titleConNew('Vaccination'),
                        ),
                        Row(
                          children: <Widget>[
                            getEl('Total Vaccinations', stat['TotalVaccines']),
                          ],
                        ),
                        Divider(thickness: 2),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              getElNew('FMD', stat['FMD']),
                              Container(
                                  height: 80,
                                  child: VerticalDivider(color: Colors.black)),
                              getElNew('HS', stat['HS']),
                              Container(
                                  height: 80,
                                  child: VerticalDivider(color: Colors.black)),
                              getElNew('BQ', stat['BQ']),
                              Container(
                                  height: 80,
                                  child: VerticalDivider(color: Colors.black)),
                              getElNew('Theiriolisis', stat['Theileriosis']),
                              Container(
                                  height: 80,
                                  child: VerticalDivider(color: Colors.black)),
                              getElNew('Rabies', stat['Rabies']),
                              Container(
                                  height: 80,
                                  child: VerticalDivider(color: Colors.black)),
                              getElNew('Brucellosis', stat['Brucellosis']),
                              Container(
                                  height: 80,
                                  child: VerticalDivider(color: Colors.black)),
                              getElNew('Anthrax', stat['Anthrax']),
                              Container(
                                  height: 80,
                                  child: VerticalDivider(color: Colors.black)),
                              getElNew('IBR', stat['IBR']),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),

                  // getStat('Total Pregnency', stat['PregnencyCount'].toString()),
                  // getStat('Total Pregnency Diagnosis', stat['PregnencyDiagnosis'].toString()),
                  // getStat('Total AI', stat['AI'].toString()),
                  // getStat('Total PD', stat['PD'].toString()),
                  // getStat('Total Vaccination', stat['TotalVaccines'].toString()),
                ],
              );
          }
        },
      ),
    );
  }
}
