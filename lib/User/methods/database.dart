import 'dart:ui';

import 'package:Kamadhenu/User/Forms/addInfo.dart';
import 'package:Kamadhenu/User/Forms/add_animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class DataBaseService {
  final uid;
  DataBaseService({this.uid});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _firestore = Firestore.instance;

  updateUser(String name, String adhar, String mob, String cttls, String land,
      String dis, String stt, String regn) {
    print('updation');
    _firestore.collection('Users').document(mob).setData({
      'name': name,
      'mobile': mob,
      'adhar': adhar,
      'initial cattles': cttls,
      'land': land,
      'State': stt,
      'District': dis,
      'Region': regn,
    });
  }

  updateCattle(
      String species,
      String breed,
      String gender,
      var dob,
      var lastcalf,
      String calvings,
      bool pregn,
      String region,
      String ownerID,
      String note) async {
    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.phoneNumber.toString();
    print(uid);

    var uuid = Uuid();

    catID = uuid.v1();
    print(catID);

    if (breed == null) {
      breed = 'NA';
    }
    if (gender == 'M') {
      pregn = false;
      calvings = 'Not Applicable';
      lastcalf = null;
    }
    if (note == null) {
      note = 'No additional Information Added';
    }
    print(ownerID);
    _firestore.collection('cattles').document(catID.toString()).setData({
      'RFID': 'NA',
      'Species': species,
      'Breed': breed,
      'Gender': gender,
      'DOB': dob,
      'Calvings': calvings,
      'Calving_Dates': lastcalf,
      'Pregnent': pregn,
      'Region': regn,
      'OnSale': false,
      'OwnerId': ownerID,
      'more_details': note,
    });
    _firestore
        .collection('Users')
        .document(uid)
        .collection('cattles')
        .document(catID)
        .setData({
      'RFID': 'NA',
      'Species': species,
      'Breed': breed,
      'Gender': gender,
      'DOB': dob,
    });
    _firestore
        .collection('Admin')
        .document(region)
        .collection('cattles')
        .document(catID)
        .setData({
      'RFID': 'NA',
      'Species': species,
      'Breed': breed,
      'Gender': gender,
      'DOB': dob,
    });
    _firestore.collection('Admin').document(region).updateData({
      'ByApp_Reg': FieldValue.increment(1),
    });
  }

  updateEvent(String region, String catID, String detailType,
      String specificDetail, var detailDate, String note) {
    String totalCount;

    if (note == null) {
      note = 'No Details Added';
    }

    _firestore
        .collection('Admin')
        .document(region)
        .collection(detailType)
        .document()
        .setData({
      'CattleID': catID.toString(),
      'DetailType': detailType,
      'Detail': specificDetail,
      'Date': detailDate,
      'Note': note,
    });

    if (detailType == 'vaccine_details') {
      totalCount = 'TotalVaccines';
    } else {
      if (specificDetail == 'newBorn') {
        totalCount = 'PregnencyCount';
      } else if (specificDetail == 'AI' || specificDetail == 'PD') {
        totalCount = 'PregnencyDiagnosis';
      }
    }

    _firestore.collection('Admin').document(region).updateData({
      totalCount: FieldValue.increment(1),
      specificDetail: FieldValue.increment(1),
    });
  }
}
