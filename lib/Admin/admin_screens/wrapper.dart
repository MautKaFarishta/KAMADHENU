import 'package:Kamadhenu/Admin/Broadcast/broadcast.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:Kamadhenu/Admin/methods/getregn.dart';
import 'package:Kamadhenu/Admin/methods/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Kamadhenu/Admin/methods/auth.dart';
import 'package:Kamadhenu/Admin/admin_screens/main_drawer.dart';
import 'package:Kamadhenu/Admin/methods/key.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  void demo1(String val) {
    //val1 = val;
    regn = val ?? regn1;
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getStringValuesSF().then((value) => demo1(value));
  }

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    getStringValuesSF().then((value) => demo1(value));

    //return either Home or Authentication widget

    if (user == null) {
      return LoginPage();
    } else {
      return HomePage();
    }
  }
}
