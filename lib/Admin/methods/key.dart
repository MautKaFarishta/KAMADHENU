import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/methods/getregn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/Admin/methods/auth.dart';
import 'package:Kamadhenu/Admin/methods/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String regn1;

class checkkey {
  static bool flag = false;
  String va;
  Future<bool> check(String region, String key) async {
    var fire = Firestore.instance.collection('Admin').document(region).get();
    await fire.then((value) async {
      if (value.data != null) {
        print(value.data['key']);
        //va = value.data['key'];
        if (value.data['key'].toString() == key) {
          regn1 = region;
          addStringToSF(region);

          flag = true;
        } else {
          flag = false;
        }
      } else {
        flag = false;
        print('err');
      }
    });
    //print(region);
    //print(key);
    //var doc;
    //dynamic data;

    //Future<dynamic> check(String region) async {

    //dynamic data;

    //final DocumentReference document =   Firestore.instance
    //.collection("Admin")
    // .document(region);

    //await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
    // data =snapshot.data;
    // print(data['key']);
    //  return data['key'];
    // });

// print('in fun');
// print('${fire}in' );
//return fire.toString();
    print(flag);
    return flag;
  }
}
