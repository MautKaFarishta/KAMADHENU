import 'package:Kamadhenu/localization/localizationConstant.dart';
import 'package:Kamadhenu/screens/help.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './about.dart';
import 'package:Kamadhenu/methods/authservice.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text(getTranslated(context, 'My Animals')),
            onTap: () => {
              Navigator.of(context).pop(),
            },
          ),
          ListTile(
            leading: Icon(Icons.explore),
            title: Text(getTranslated(context, 'Buy/Sell Animal')),
            onTap: () => {Navigator.pushNamed(context, '/portal')},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(getTranslated(context, 'Help')),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Help()), //Route to Create Acc PAge
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(getTranslated(context, 'About Us')),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => About()), //Route to Create Acc PAge
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(getTranslated(context, 'LogOut')),
            onTap: () => {AuthService().signOut(), Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

class ProfliePage {}
