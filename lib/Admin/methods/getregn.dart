import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> addStringToSF(String region) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('stringValue', region);
}

Future<String> getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('stringValue').toString();
  print(stringValue);
  return stringValue;
}
