import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool led = false;
  var distance;
  late TabController _tabController;
  int tabIndex = 0;

  _SinglePageAppState(this.database, this.firebase);

  //     FirebaseDatabase().reference();
  //database refrence
  void updateswitch() async {
    if (led == true)
      await database.update({'STATUS': "OFF"});
    else
      await database.update({'STATUS': "ON"});
  }

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
              tabIndex = index;
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
      body: Column(
        children: [
          Container(
            height: 30,
          ),
          Expanded(
            child: StreamBuilder(
                stream: database.onValue
                // database
                //     .child('')
                //     .onValue //onValue:When value changes then this gets trigger

                ,
                builder: (context, AsyncSnapshot<Event> snap) {
                  if (snap.hasData &&
                      !snap.hasError &&
                      snap.data!.snapshot.value != null) {
                    Map data = snap.data!.snapshot.value;
                    distance = data['cm'];
                    var status = data['STATUS'];
                    if (status == "ON")
                      led = true;
                    else
                      led = false;
                    return IndexedStack(
                      index: tabIndex,
                      children: [distanceWidget(distance), switchLayout(led)],
                    );
                  } else {
                    return Center(
                      child: Text("NO DATA YET"),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget switchLayout(bool led) {
    return Center(
        child: Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 80),
          child: Text(
            "POWER ON/OFF",
            style: led
                ? TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.amber)
                : TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(28.0),
          child: FloatingActionButton.extended(
            icon: led ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            backgroundColor: led ? Colors.amber : Colors.black,
            label: led ? Text("ON") : Text("OFF"),
            elevation: 30.00,
            onPressed: () {
              // onUpdate();
              updateswitch();
            },
          ),
        )
      ],
    ));
  }
}
