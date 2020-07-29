import 'package:Kamadhenu/Profiles/cattle_profile.dart';
import 'package:Kamadhenu/UI/decorations.dart';
import 'package:Kamadhenu/methods/authservice.dart';
import 'package:Kamadhenu/models/user.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/Forms/add_animal.dart' as A;
import 'package:Kamadhenu/Forms/add_animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_drawer.dart';
import 'notifications.dart';

final userRef = Firestore.instance.collection('Users');
KamadhenuUser currentUser = new KamadhenuUser(name: 'NotYet');
String userID;
String regn;

class HomePage extends StatefulWidget {
  State<StatefulWidget> createState() => new _HomePageState(); //Define State
}

class _HomePageState extends State<HomePage> {
  // StreamSubscription _subscription;

  KamadhenuUser getid(String foo) {
    userID = foo;
    setState(() {
      userID = foo;
    });
    print(userID);
    currentUser = getUser(userID);
  }

  getUser(String userID) {
    userRef.document(userID.toString()).get().then((DocumentSnapshot doc) {
      setState(() {
        currentUser = new KamadhenuUser(
            adhar: doc['adhar'],
            phoneNo: doc['mobile'],
            name: doc['name'],
            district: doc['District']);
      });
    });
  }

  @override
  void initState() {
    AuthService().getCurrentUID().then((value) => getid(value));
    super.initState();

  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          A.regn = currentUser.district;
          A.ownerID = currentUser.phoneNo;
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddAnimal()), //Route to Create Acc PAge
          );
        },
        //icon:Icon(Icons.add),
        label: Text('REGISTER'),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NotificationPanel(region: currentUser.district),
                        ),
                      );
                    })
              ],
              backgroundColor: Colors.blue.shade900,
              titleSpacing: 50,
              title: Center(
                child: Text(
                  'Kamadhenu',
                  style: TextStyle(fontSize: 28),
                ),
              ),
              expandedHeight: 170.0,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                background: currentUser.name == 'NotYet'
                    ? CircularProgressIndicator()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30),
                          Text(
                            '${currentUser.name}',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${currentUser.phoneNo}',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${currentUser.district}',
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            Deco().titleCon('Your Cattles',),
            Center(
              child: ListPage(),
            ),
          ],
        ),
      ),
    );
  }
}

class ListPage extends StatefulWidget {
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('Users')
              .document(userID.toString())
              .collection('cattles')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                return new ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return FlatButton(
                      onPressed: () {
                        
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CatPro(
                                  catID: document.documentID.toString(),
                                )));
                      },
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 7),
                          
                          new Container(
                                //width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue.shade200,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  border: Border.all(
                                      width: 1.0, color: Colors.black38),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width:5.0),
                                    CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/tileimages/${document['Species']}.jpg"),
                                      radius: 30.0,
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          'RFID:${document['RFID']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          '${document['Gender']}  ${document['Species']}',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          document['Breed'],
                                        ),
                                        Text(
                                            'Birth :${document['DOB'].toDate().toString()}'),
                                        SizedBox(height: 10),
                                      ],
                                    ),
                                    SizedBox(width:20.0),
                                    Icon(Icons.chevron_right,color:Colors.black38,size:40.0),
                                  ],
                                )),
                        ],
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
