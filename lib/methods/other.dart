import 'package:cloud_firestore/cloud_firestore.dart';

class OtherMeth{

  bool flag;

  bool CheckNum(String mob){
    Firestore.instance
        .collection('Users')
        .where('mobile', isEqualTo:mob)
        .getDocuments().then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        print('User Found!');
        flag =true;
      }
      else{
        print('User Not Found!');
        print(mob);
        flag= false;
      }
    });
    return flag;
  }
  
}