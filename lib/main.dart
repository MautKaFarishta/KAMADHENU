// import 'dart:js';

import 'package:Kamadhenu/Forms/create.dart';
import 'package:Kamadhenu/screens/AnimalInfo.dart';
import 'package:Kamadhenu/screens/ChangeOwnership.dart';
import 'package:Kamadhenu/screens/ImagePicker.dart';
import 'package:Kamadhenu/screens/Portal.dart';
import 'package:Kamadhenu/screens/buySell.dart';
import 'package:Kamadhenu/methods/authservice.dart';
import 'package:Kamadhenu/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/UI/AnimalProfile.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:Kamadhenu/localization/demolocalization.dart';

import 'localization/localizationConstant.dart';

// void main() {
//   //Main Function
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   static void setLocale(BuildContext context, Locale locale) {
//     _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
//     state.setLocale(locale);
//   }

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Locale _locale;

//   void setLocale(Locale locale) {
//     setState(() {
//       _locale = locale;
//     });
//   }

//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title:
//             'Kamadhenu', //title of app shown  when we press 'recent apps' button on android
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: AuthService().handleAuth(),
//         routes: {
//           // '/': (BuildContext ctx) => AuthService().handleAuth(),
//           '/home': (BuildContext ctx) => HomePage(),
//           '/portal': (BuildContext ctx) => Portal(),
//           '/ImagePicker': (BuildContext ctx) => ImagePicker(),
//           '/animalProfile': (BuildContext ctx) => AnimalProfile(),
//           '/animalInfo': (BuildContext ctx) => AnimalInfo(),
//           '/changeOwnership': (BuildContext ctx) => ChangeOwnership(),
//         },
//         supportedLocales: [
//           Locale('en', 'US'),
//           Locale('hi', 'IN'),
//         ],
//         localizationsDelegates: [
//           // ... app-specific localization delegate[s] here
//           GlobalMaterialLocalizations.delegate,
//           GlobalWidgetsLocalizations.delegate,
//           GlobalCupertinoLocalizations.delegate,
//           DemoLocalization.delegate,
//         ],
//         localeListResolutionCallback: (deviceLocale, supportedLocales) {
//           // for (var locale in supportedLocales) {
//           //   if (locale.languageCode == deviceLocale.languageCode &&
//           //       locale.countryCode == deviceLocale.countryCode) {
//           //     return deviceLocale;
//           //   }
//           // }

//           return supportedLocales.first;
//         });
//   }
// }
void main() {
  //Main Function
  runApp(MyApp());
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
          home: AuthService().handleAuth(),
          routes: {
            // '/': (BuildContext ctx) => AuthService().handleAuth(),
            '/home': (BuildContext ctx) => HomePage(),
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
