import 'package:Kamadhenu/Admin/UI/decorations.dart';
import 'package:Kamadhenu/Admin/admin_screens/Statistics/stat.dart';
import 'package:Kamadhenu/Admin/admin_screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Kamadhenu/Admin/admin_screens/login.dart';
import 'User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  User user = User("");
  bool _isAdmin = false;
  TextEditingController _userCountryController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _userAddressController = TextEditingController();
  TextEditingController _userContactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Admin Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              FutureBuilder(
                future: Firestore.instance.collection('Admin').getDocuments(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInformation(context, snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    //final authData = snapshot.data;

    return Column(
      children: <Widget>[
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${authData.displayName ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),*/
        /*Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Email: ${authData.email ?? 'Anonymous'}",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Created: ${DateFormat('MM/dd/yyyy').format(authData.metadata.creationTime)}",
            style: TextStyle(fontSize: 20),
          ),
        ),*/
        FutureBuilder(
            future: _getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // _userCountryController.text = '';
                // _isAdmin = user.admin ?? false;
                // _userNameController.text = user.Name;
                // _userContactController.text = user.Contact_no;
                // _userEmailController.text = user.Email;
                // _userAddressController.text = user.Address;
              }
              return Center(
                child: Container(
                  margin: EdgeInsets.all(7),
                  decoration: Deco().decoBox(Colors.blue.shade50),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Home Country:",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              user.homeCountry ?? 'null',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Name:",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.Name ?? 'null',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Contact:",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.Contact_no ?? 'null',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Address:",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.Address ?? 'null',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Email:",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user.Email ?? 'null',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blue.shade700),
                            ),
                          ),
                        ],
                      ),
                      adminFeature(),
                    ],
                  ),
                ),
              );
            }),
        //showSignOut(context, authData.isAnonymous),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
              color: Colors.blue[400],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: FlatButton(
            child: Text("Edit User"),
            onPressed: () {
              _userEditBottomSheet(context);
            },
          ),
        )
      ],
    );
  }

  _getProfileData() async {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    // var uid = Firestore.instance.collection('Admin').document(regn).firestore.runTransaction((transaction) => )
    await Firestore.instance
        .collection('Admin')
        .document(regn)
        .get()
        .then((result) {
      user.homeCountry = result.data['homeCountry'];
      user.admin = result.data['admin'];
      user.Name = result.data['Name'];
      user.Contact_no = result.data['Contact_no'];
      user.Address = result.data['Address'];
      user.Email = result.data['Email'];
    });
  }

  /*Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return RaisedButton(
        child: Text("Sign Out"),
        onPressed: () async {
          try {
            await Provider.of(context).auth.signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }
*/
  Widget adminFeature() {
    if (_isAdmin == true) {
      return Text("You are an admin");
    } else {
      return Container();
    }
  }

  void _userEditBottomSheet(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext bc) {
        return Dialog(
          child: SingleChildScrollView(
            child: Container(
              //height:
              //MediaQuery.of(context).size.height,
              //MediaQuery.of(context).size.height * .60,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Update Profile"),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.cancel),
                          color: Colors.orange,
                          iconSize: 25,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: TextField(
                              controller: _userCountryController,
                              decoration: InputDecoration(
                                helperText: "Home Country",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _userNameController,
                                  decoration: InputDecoration(
                                    helperText: "Name",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _userEmailController,
                                  decoration: InputDecoration(
                                    helperText: "Email",
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _userContactController,
                                  decoration: InputDecoration(
                                    helperText: "Mobile No.",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: TextField(
                                  controller: _userAddressController,
                                  decoration: InputDecoration(
                                    helperText: "Address",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text('Save'),
                          color: Colors.green,
                          textColor: Colors.white,
                          onPressed: () async {
                            user.homeCountry = _userCountryController.text;
                            user.Email = _userEmailController.text;
                            user.Address = _userAddressController.text;
                            user.Contact_no = _userContactController.text;
                            user.Name = _userNameController.text;
                            setState(() {
                              // _userCountryController.text = user.homeCountry;
                              // _userEmailController.text =  user.Email;
                              //_userAddressController.text = user.Address;
                              // _userContactController.text = user.Contact_no;
                              // _userNameController.text = user.Name;
                            });
                            //final uid =
                            //await Provider.of(context).auth.getCurrentUID();
                            await Firestore.instance
                                .collection('Admin')
                                .document(regn)
                                .updateData(user.toJson());
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
