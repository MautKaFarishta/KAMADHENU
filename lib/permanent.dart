import 'package:shared_preferences/shared_preferences.dart';

Future<String> addUserType(String usertype) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userValue', usertype);
}

Future<String> getUserType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('userValue').toString();
  print(stringValue);
  return stringValue;
}
