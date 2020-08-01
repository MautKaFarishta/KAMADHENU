// import 'dart:js';

import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:Kamadhenu/User/Forms/create.dart';
import 'package:Kamadhenu/User/Forms/login.dart';
import 'package:Kamadhenu/User/screens/AnimalInfo.dart';
import 'package:Kamadhenu/User/screens/ChangeOwnership.dart';
import 'package:Kamadhenu/User/screens/ImagePicker.dart';
import 'package:Kamadhenu/User/screens/Portal.dart';
import 'package:Kamadhenu/User/screens/buySell.dart';
import 'package:Kamadhenu/User/methods/authservice.dart' as Uauth;
import 'package:Kamadhenu/User/screens/home.dart' as uhome;
import 'package:Kamadhenu/start.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/User/UI/AnimalProfile.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:Kamadhenu/User/localization/demolocalization.dart';
import 'package:provider/provider.dart';
import 'Admin/admin_screens/Cattles/cattles.dart';
import 'Admin/admin_screens/Users/users.dart';
import 'Admin/admin_screens/wrapper.dart';
import 'Admin/main1.dart';
import 'package:Kamadhenu/User/localization/localizationConstant.dart';
import 'Admin/main1.dart' as M;
import 'Admin/methods/user.dart';
import 'package:Kamadhenu/Admin/Broadcast/broadcast.dart';
import 'package:Kamadhenu/Admin/admin_screens/Cattles/cattles.dart';
import 'package:Kamadhenu/Admin/admin_screens/Users/users.dart' as Auser;
import 'package:Kamadhenu/Admin/admin_screens/wrapper.dart';
import 'package:Kamadhenu/Admin/methods/auth.dart';
import 'package:Kamadhenu/Admin/methods/user.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'package:provider/provider.dart';
import 'permanent.dart';

String userType;
assignValue(String value) {
  userType = value;
  print(userType);
}


void main() {
  //getUserType().then((value) => assignValue(value)
  //);
  print(userType);
  //if (userType == 'User') {
  //  runApp(MyApp());
  //} else if (userType == 'Admin') {
  //  runApp(MyAppAdmin());
  //} else {
  //  runApp(StartApp());
  //}
  runApp(StartApp());
}



// _homepage(String userType) {
//   if (userType == 'Admin')
//     return MyAppAdmin();
//   else if (userType == 'User')
//     return Uauth.AuthService().handleAuth();
//   else
//     return LoginPageUser();
// }

class StartApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Choose ",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    if (_locale == null) {
      return Container(
          child: Center(
        child: CircularProgressIndicator(),
      ));
    } else {
      return MaterialApp(
          title:
              'Kamadhenu', //title of app shown  when we press 'recent apps' button on android
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          locale: _locale,
          home: Uauth.AuthService().handleAuth(),
          routes: {
            // '/': (BuildContext ctx) => AuthService().handleAuth(),
            '/home': (BuildContext ctx) => uhome.HomePage(),
            '/portal': (BuildContext ctx) => Portal(),
            '/ImagePicker': (BuildContext ctx) => ImagePicker(),
            '/animalProfile': (BuildContext ctx) => AnimalProfile(),
            '/animalInfo': (BuildContext ctx) => AnimalInfo(),
            '/changeOwnership': (BuildContext ctx) => ChangeOwnership(),
          },
          supportedLocales: [
            Locale('en', 'US'),
            Locale('hi', 'IN'),
          ],
          localizationsDelegates: [
            DemoLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }

            return supportedLocales.first;
          });
    }
  }
}

class MyAppAdmin extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: new MaterialApp(
        title: 'Kamadhenu Administrator',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        //new HomePage()//Redirect To Login PAge
        routes: {
          '/': (BuildContext context) => Wrapper(),
          //'/': (BuildContext context) => BroadCast(),
          '/cattles': (BuildContext context) => Cattles(),
          '/home': (BuildContext context) => HomePage(),
          '/Users': (BuildContext ctx) => Users(),
          //'/Users' : (BuildContext ctx) => AddAnimal(),
        },
      ),
    );
  }
}
