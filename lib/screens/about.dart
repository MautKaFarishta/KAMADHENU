import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 100,),
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
                        'Kamadhenu',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                      Text(
                        'Livestock Ownership Database Controlled and Managed by Team Kamadhenu',
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
