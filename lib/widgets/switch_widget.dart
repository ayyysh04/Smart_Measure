import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_measure/model/firebase.dart';
import 'package:smart_measure/pages/add_devices.dart';
import 'package:smart_measure/pages/button_Page.dart';
import 'package:velocity_x/velocity_x.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({
    Key? key,
  }) : super(key: key);

  @override
  _SwitchPageState createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  final DatabaseReference database = Database.database;
  bool led = false;
  void updateswitch() async {
    if (led == true)
      await database.update({'STATUS': "OFF"});
    else
      await database.update({'STATUS': "ON"});
  }

  _SwitchPageState();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          StreamBuilder(
              stream:
                  // database.onValue
                  database
                      .child("")
                      .onValue //onValue:When value changes then this gets trigger

              ,
              builder: (context, AsyncSnapshot<Event> snap) {
                if (snap.hasData &&
                    !snap.hasError &&
                    snap.data!.snapshot.value != null) {
                  Map data = snap.data!.snapshot.value;
                  var status = data['STATUS'];
                  if (status == "ON")
                    led = true;
                  else
                    led = false;
                  return switchWidget(led);
                } else {
                  return Center(
                    child: Text("NO DATA YET"),
                  );
                }
              }).expand(),
        ],
      ),
    );
  }

  Widget switchWidget(bool led) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
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
                      icon: led
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      backgroundColor: led ? Colors.amber : Colors.black,
                      label: led ? Text("ON") : Text("OFF"),
                      elevation: 30.00,
                      onPressed: () {
                        // onUpdate();
                        updateswitch();
                      },
                    ),
                  ),
                  ButtonPage().expand()
                ],
              ).hPCT(context: context, heightPCT: 70.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddNewDevices(database: database)));
                  },
                  child: Icon(Icons.add),
                ),
                10.widthBox,
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.black,
                  onPressed: () {
                    // database.child("status2").set("ON");
                    database.child("status3").remove();
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
