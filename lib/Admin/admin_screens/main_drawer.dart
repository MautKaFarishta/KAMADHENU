import 'package:Kamadhenu/Admin/Broadcast/broadcast.dart';
import 'package:Kamadhenu/Admin/admin_screens/Cattles/cattleRedirect.dart';
import 'package:Kamadhenu/Admin/admin_screens/Cattles/cattles.dart';
import 'package:Kamadhenu/Admin/admin_screens/Users/users.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';

import 'package:Kamadhenu/Admin/methods/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/main.dart';
import 'package:Kamadhenu/Admin/profile/profile_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  final AuthService _auth1 = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              ' Hello Regional Admin',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade500,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              //Navigator.of(context).pop(),
              Navigator.of(context).pop(),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePagea())),
              //Navigator.of(context).pushNamed('/cattles'),
            },
          ),
          ListTile(
            leading: Icon(Icons.pets),
            title: Text('Animals'),
            onTap: () => {
              //Navigator.of(context).pop(),
              Navigator.of(context).pop(),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CattleRedirect())),
              //Navigator.of(context).pushNamed('/cattles'),
            },
          ),
          ListTile(
            leading: Icon(Icons.group),
            title: Text('Users'),
            onTap: () => {
              //Navigator.of(context).push(MaterialPageRoute(
              //builder: (BuildContext context) => Users())),
              Navigator.of(context).pop(),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Users())),
            },
          ),
          ListTile(
            leading: Icon(Icons.account_box),
            title: Text('Profile'),
            onTap: () => {
              //Navigator.of(context).pop(),
              Navigator.of(context).pop(),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfileView())),
            },
          ),
          ListTile(
            leading: Icon(Icons.wifi_tethering),
            title: Text('Broadcast'),
            onTap: () => {
              //Navigator.of(context).pop(),
              Navigator.of(context).pop(),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Broadcast())),
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LogOut'),
            onTap: () async {
              await _auth1.signOut();
              // Navigator.of(context).push(MaterialPageRoute(
              //builder: (BuildContext context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

class ProfliePage {}

//for later use
//Navigator.of(context).pop()
