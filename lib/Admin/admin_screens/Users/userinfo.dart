import 'dart:async';
import 'package:Kamadhenu/Admin/UI/showUserDetails.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfo extends StatelessWidget {
  final String id;

  const UserInfo({Key key, this.id}) : super(key: key);

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
          stream:
              Firestore.instance.collection('Users').document(id).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var catDoc = snapshot.data;

            return ShowUserDetails().DetailedUserInfo(catDoc);
          }),
    );
  }
}
