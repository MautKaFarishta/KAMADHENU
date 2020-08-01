import 'package:Kamadhenu/Admin/admin_screens/Users/usercattle.dart';
import 'package:Kamadhenu/Admin/admin_screens/Users/userinfo.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final String userID;

  const UserDetails({Key key, this.userID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Colors.blue[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            UserInfo(id: userID),
            SizedBox(
              height: 10.0,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UserCatDetails(cat: userID)));
                },
                child: Text('User Cattles info'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
