import 'package:Kamadhenu/Admin/UI/decorations.dart';
import 'package:Kamadhenu/Admin/admin_screens/Statistics/DetailStat.dart';
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
  Widget getElNewAgain(String txt, int stat) {
    if (stat == null) {
      stat = 0;
    }
    return Container(
      width: MediaQuery.of(context).size.width*0.15,
      child: Column(
        children: <Widget>[
          Text(
            txt,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            stat.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  getBar(Color col,int total,int fothis){
    double factor;
    if(fothis==null){
      factor=0;
    }else{
      factor=fothis/total;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        Container(
                              height:20,
                              color: col,
                              width: MediaQuery.of(context).size.width*0.80*factor,
                            ),
      ],
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
                        Icon(Icons.group),
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
                          child: Deco().titleConNew('Cattle Registrations'),
                        ),
                        Icon(Icons.pets),
                        Row(
                          children: <Widget>[
                            getElNewAgain('App', stat['ByApp_Reg']),
                            getBar(Colors.red.shade500,stat['ByApp_Reg']+stat['RFID_Reg'],stat['ByApp_Reg']),
                          ],
                        ),
                        
                        SizedBox(height:10),
                        
                        Row(
                          children: <Widget>[
                            getElNewAgain('RFID', stat['RFID_Reg']),
                            getBar(Colors.green,stat['ByApp_Reg']+stat['RFID_Reg'],stat['RFID_Reg']),
                          ],
                        ),
                        SizedBox(height:15)
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
                        Icon(Icons.healing),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => DetailStat(collection: 'vaccine_details',)));
                              },
                              child:getEl('Total Vaccinations', stat['TotalVaccines']),
                            ),
                          ],
                        ),
                        Divider(thickness: 2),
                        Row(
                          children: <Widget>[
                            getElNewAgain('FMD', stat['FMD']),
                            getBar(Colors.green,stat['TotalVaccines'],stat['FMD']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            getElNewAgain('HS', stat['HS']),
                            getBar(Colors.green,stat['TotalVaccines'],stat['HS']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            getElNewAgain('BQ', stat['BQ']),
                            getBar(Colors.green,stat['TotalVaccines'],stat['BQ']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            getElNewAgain('Theileriosis', stat['Theileriosis']),
                            getBar(Colors.green,stat['TotalVaccines'],stat['Theileriosis']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            getElNewAgain('Rabies', stat['Rabies']),
                            getBar(Colors.green,stat['TotalVaccines'],stat['Rabies']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            getElNewAgain('Brucellosis', stat['Brucellosis']),
                            getBar(Colors.green,stat['TotalVaccines'],stat['Brucellosis']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            getElNewAgain('Anthrax', stat['Anthrax']),
                            getBar(Colors.green,stat['TotalVaccines'],stat['Athrax']),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            getElNewAgain('IBR', stat['IBR']),
                            getBar(Colors.green,stat['TotalVaccines'],stat['IBR']),
                          ],
                        ),
                        
                        SizedBox(height: 10),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => DetailStat(collection: 'pregnency_details',detail: 'newBorn',)));
                              },
                              child:getEl('Total New Born', stat['newBorn']),)
                          ],
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Row(
                          children: <Widget>[
                            FlatButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => DetailStat(collection: 'pregnency_details',detail: 'AI',)));
                              },
                              child:getElNew('AI', stat['AI']),),
                            FlatButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => DetailStat(collection: 'pregnency_details',detail: 'PD',)));
                              },
                              child:getElNew('PD', stat['PD']),),
                          ],
                        ),
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
