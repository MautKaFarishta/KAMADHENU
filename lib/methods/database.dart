import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Kamadhenu/methods/authservice.dart';

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

  updateCattle(String species, String breed, String gender, var dob,
      var lastcalf, String calvings, bool pregn) async{

    final FirebaseUser user = await _auth.currentUser();
    final String uid = user.phoneNumber.toString();
    print(uid);

    if (breed == null) {
      breed = 'NA';
    }
    if (gender == 'M') {
      pregn = false;
    }
    _firestore.collection('cattles').document(dob.toString()).setData({
      'RFID':'NA',
      'Species': species,
      'Breed': breed,
      'Gender': gender,
      'DOB': dob,
      'Calvings': calvings,
      'Calving_Dates': lastcalf, 
      'Pregnent': pregn,
    });
    _firestore.collection('Users').document(uid).collection('cattles').document(dob.toString()).setData({
      'RFID':'NA',
      'Species': species,
      'Breed': breed,
      'Gender': gender,
      'DOB': dob,
    });
  }

  updateEvent(String document,String detailType,String specificDetail,var detailDate,String note){

    _firestore.collection('cattles').document(document).collection(detailType).document().setData({
      'DetailType':detailType,
      'Detail':specificDetail,
      'Date':detailDate,
      'Note':note,
    });
  }

}
