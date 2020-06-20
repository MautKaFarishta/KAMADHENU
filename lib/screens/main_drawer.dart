import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './about.dart';
import './profile.dart';
import 'home.dart';

class MainDrawer extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              ' Hello UserNameHere',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade500,
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('My Animals'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomePage()), //Route to Create Acc PAge
              ),},
          ),
          ListTile(
            leading: Icon(Icons.explore),
            title: Text('Buy/Sell Animal'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => {
              Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfilePage()), //Route to Create Acc PAge
              ),},
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () => {Navigator.of(context).pop(),
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        About()), //Route to Create Acc PAge
              ),},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('LogOut'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}

class ProfliePage {}
