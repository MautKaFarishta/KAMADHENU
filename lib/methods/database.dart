import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Kamadhenu/models/user.dart';

class DataBaseService {
  final uid;
  DataBaseService({this.uid});

  final _firestore = Firestore.instance;

  UpdateUser(String name, String adhar, String mob, String cttls, String land,
      String dis, String stt, String regn,String uid) {
    print('updation');
    _firestore.collection('Users').add({
      'name': name,
      'mobile': mob,
      'adhar': adhar,
      'initial cattles': cttls,
      'land': land,
      'State': stt,
      'District': dis,
      'Region': regn,
      'uid': uid,
    });
  }

  UpdateCattle(String species, String breed, String gender, var dob,
      var lastcalf, String calvings, bool pregn) {
    if (breed == null) {
      breed = 'NA';
    }
    _firestore.collection('cattles').add({
      'Species': species,
      'Breed': breed,
      'Gender': gender,
      'DOB': dob,
      'Calvings': calvings,
      'Calving_Dates': lastcalf, //Later to be converted to Array
      'Pregnent': pregn,
      'uid': 'Demo',
      //Parents Details Remaining
    });
  }
}
