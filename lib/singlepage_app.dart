import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SinglePageApp extends StatefulWidget {
  @override
  _SinglePageAppState createState() => _SinglePageAppState();
}

class _SinglePageAppState extends State<SinglePageApp>
    with SingleTickerProviderStateMixin {
  bool led;
  var distance;
  TabController _tabController;
  int tabIndex = 0;
  DatabaseReference database = FirebaseDatabase().reference();
  void updateswitch() {
    if (led == true)
      database.update({'STATUS': "OFF"});
    else
      database.update({'STATUS': "ON"});
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
    return mainScaffold();
  }

  Widget mainScaffold() {
    return Scaffold(
      appBar: AppBar(
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
              icon: Icon(MaterialCommunityIcons.database),
            ),
            Tab(
              icon: Icon(MaterialCommunityIcons.toggle_switch),
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
                stream: database.child('').onValue,
                builder: (context, snap) {
                  if (snap.hasData &&
                      !snap.hasError &&
                      snap.data.snapshot.value != null) {
                    Map data = snap.data.snapshot.value;
                    distance = data['cm'];
                    var status = data['STATUS'];
                    if (status == "ON")
                      led = true;
                    else
                      led = false;
                    return IndexedStack(
                      index: tabIndex,
                      children: [distanceLayout(distance), switchLayout(led)],
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

  Widget distanceLayout(var distance) {
    return Center(
        child: Container(
            child: SfRadialGauge(axes: <RadialAxis>[
      RadialAxis(minimum: 0, maximum: 1000, ranges: <GaugeRange>[
        GaugeRange(startValue: 0, endValue: 200, color: Colors.green),
        GaugeRange(startValue: 200, endValue: 500, color: Colors.orange),
        GaugeRange(startValue: 500, endValue: 1000, color: Colors.red)
      ], pointers: <GaugePointer>[
        NeedlePointer(value: distance.toDouble())
      ], annotations: <GaugeAnnotation>[
        GaugeAnnotation(
            widget: Container(
                child: Text(distance.toString() + ' cm',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold))),
            angle: 90,
            positionFactor: 0.5)
      ])
    ])));
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
