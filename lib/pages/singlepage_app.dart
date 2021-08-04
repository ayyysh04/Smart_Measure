import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_measure/pages/add_devices.dart';
import 'package:smart_measure/pages/button_Page.dart';
import 'package:smart_measure/widgets/switch_widget.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:smart_measure/tools/intilize.dart';
import 'package:smart_measure/widgets/distance_widget.dart';

class SinglePageApp extends StatefulWidget {
  final DatabaseReference database;
  final FirebaseApp? firebase;
  @override
  const SinglePageApp({
    Key? key,
    required this.database,
    required this.firebase,
  }) : super(key: key);
  @override
  _SinglePageAppState createState() => _SinglePageAppState(database, firebase);
}

class _SinglePageAppState extends State<SinglePageApp>
    with SingleTickerProviderStateMixin {
  final DatabaseReference database;
  final FirebaseApp? firebase;

  late TabController _tabController;
  int _selectedTab = 0;
  late List _pageOptions;

  _SinglePageAppState(this.database, this.firebase) {
    _pageOptions = [
      DistancePage(database: database),
      SwitchPage(database: database)
    ];
  }

  //     FirebaseDatabase().reference();
  //database refrence

  // void getData() async {
  //   //to get the value if the database
  //   DataSnapshot data =
  //       await database.once(); //retrieve database once in datsnapshot

  //   //put the data in our local variables
  //   setState(() {
  //     led = data.value['STATUS'];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mainPage();
  }

  Widget mainPage() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Smart Measure"),
        bottom: TabBar(
          controller: _tabController,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          tabs: [
            Tab(
              icon: Icon(CupertinoIcons.chart_bar_square),
            ),
            Tab(
              icon: Icon(Icons.light),
            )
          ],
        ),
      ),
      body: _pageOptions[_selectedTab],
    );
  }
}
