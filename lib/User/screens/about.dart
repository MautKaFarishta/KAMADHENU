import 'package:Kamadhenu/User/localization/localizationConstant.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Kamadhenu"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                ),
                width: double.infinity,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text(
                        getTranslated(context, 'app_Title'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                      Text(
                        getTranslated(context,
                            'Livestock Ownership Database Controlled and Managed by Team Kamadhenu'),
                        style: TextStyle(fontSize: 16, color: Colors.black38),
                      ),
                      Text(
                        getTranslated(context,
                            'For any queries contact us at -kamadhenu.helpdesk@gmail.com'),
                        style: TextStyle(fontSize: 16, color: Colors.black38),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
