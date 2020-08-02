import 'dart:async';
import 'dart:core';

import 'package:Kamadhenu/User/localization/demolocalization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).getTransValue(key);
}

//language code
const String English = 'en';
const String Hindi = 'hi';
const String Telgu = 'te';

//language code
const String Language_Code = 'languageCode';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(Language_Code, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale _temp;
  switch (languageCode) {
    case English:
      _temp = Locale(languageCode, 'US');
      break;
    case Hindi:
      _temp = Locale(languageCode, 'IN');
      break;
    case Telgu:
      _temp = Locale(languageCode, 'IN');
      break;
    default:
      _temp = Locale(English, 'US');
  }
  return _temp;
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(Language_Code) ?? 'en';
  return _locale(languageCode);
}
