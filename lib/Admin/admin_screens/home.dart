import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/Users/details.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:Kamadhenu/Admin/methods/auth.dart';
import 'package:Kamadhenu/Admin/methods/getregn.dart';
import 'package:Kamadhenu/Admin/methods/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'main_drawer.dart';

String regn;
final AuthService _auth = AuthService();

class HomePagea extends StatefulWidget {
  State<StatefulWidget> createState() => new _HomePageaState(); //Define State
}

class _HomePageaState extends State<HomePagea> {
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

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to Logout'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () async{
              Navigator.of(context).pop();
              await _auth.signOut();},
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  _onBackPressed,
      child: Scaffold(
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
      ),
    );
  }
}
