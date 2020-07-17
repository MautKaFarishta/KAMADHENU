import 'package:cloud_firestore/cloud_firestore.dart';

class OtherMeth{

  static bool flag=false;


  bool CheckNum(String mob){
    
    Firestore.instance
        .collection('Users')
        .where('mobile', isEqualTo:mob)
        .getDocuments().then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        print('User Found! $mob');
        flag =true;
      }
      else{
        print('User Not Found! $mob');
        flag= false;
      }
    });
    print(flag);
    return flag;
  }
  
}