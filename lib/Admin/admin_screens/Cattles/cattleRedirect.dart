import 'package:Kamadhenu/Admin/admin_screens/Cattles/registered.dart';
import 'package:Kamadhenu/Admin/admin_screens/Cattles/unRegistered.dart';

import 'package:flutter/material.dart';

class CattleRedirect extends StatefulWidget {
  @override
  _CattleRedirectState createState() => _CattleRedirectState();
}

class _CattleRedirectState extends State<CattleRedirect>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 0, length: 2);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cattles'),
        elevation: 0.7,
        backgroundColor: Colors.blue.shade900,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Text("Registered Cattles"),
            ),
            Tab(
                child: Text(
              "Unregistered Cattles",
            )),
          ],
          indicatorColor: Colors.deepOrange,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Registered(),
          UnRegistered(),
        ],
      ),
    );
  }
}
