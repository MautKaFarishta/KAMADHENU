import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/Users/details.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:Kamadhenu/Admin/methods/getregn.dart';
import 'package:Kamadhenu/Admin/methods/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main_drawer.dart';

String regn;

class HomePage extends StatefulWidget {
  State<StatefulWidget> createState() => new _HomePageState(); //Define State
}

class _HomePageState extends State<HomePage> {
  void demo1(String val) {
    // val1 = val;
    setState(() {
      regn = val;
    });
    // regn = val;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getStringValuesSF().then((value) => demo1(value));
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    addStringToSF(regn);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blue[900],
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final DocumentSnapshot result = await showSearch(
                  context: context,
                  delegate: nameSearch(),
                );
                //print(result.documentID);
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(result.data['name'] ?? 'null')));

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        UserDetails(userID: result.documentID)));
              },
            ),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Stat(),
    );
  }
}
