import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_measure/model/switch_map.dart';
import 'package:smart_measure/pages/add_devices.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:smart_measure/model/firebase.dart';

class ButtonPage extends StatefulWidget {
  final String roomname;
  ButtonPage({
    Key? key,
    required this.roomname,
  }) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState(roomname);
}

class _ButtonPageState extends State<ButtonPage> {
  final String roomname;
  // List<bool> switchValues = [];
  final DatabaseReference database = Database.database;

  _ButtonPageState(this.roomname);
  onchangedvalue({required int switchno}) async {
    // switchValues[switchno] = switchValues[switchno].toggle();
    // if (switchValues[switchno] == true)
    //   await database.child("").set("OFF");
    // else
    //   await database.child("").set("ON");

    if (SwitchMap.switches[roomname]!.values.elementAt(switchno)["status"] ==
        "on")
      SwitchMap.switches[roomname]!.values.elementAt(switchno)["status"] =
          "off";
    else
      SwitchMap.switches[roomname]!.values.elementAt(switchno)["status"] = "on";
    setState(() {});
  }

  bool switchBoolValue(int switchno) {
    if (SwitchMap.switches[roomname]!.values.elementAt(switchno)["status"] ==
        "off")
      return false;
    else
      return true;
  }

  @override
  Widget build(BuildContext context) {
    // database.once().then((value) => print(value.value)); //for checking data

    // addSwitch() async {
    //   dynamic result = await Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => AddNewDevices()));
    //   setState(() {
    //     if (result != false) {
    //       switchValues.add(false);
    //       int switchno = switchValues.length;
    //       database.child("switch $switchno").set("OFF");
    //     }
    //   });
    // }

    //--------------------
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: ListView.separated(
            itemCount: SwitchMap.switches[roomname]!.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
            itemBuilder: (BuildContext context, int index) {
              return StreamBuilder(
                stream: database.child("Devices/$roomname").onValue,
                builder: (BuildContext context, AsyncSnapshot<Event> snap) {
                  if (true
                      // snap.hasData &&
                      //   !snap.hasError &&
                      //   snap.data!.snapshot.value != null
                      ) {
                    // Map data = snap.data!.snapshot.value;
                    // print(SwitchMap.switches);

                    // var status = data["switch ${index + 1}"];
                    // if (status == "ON")
                    //   switchValues[index] = true;
                    // else
                    //   switchValues[index] = false;
                    // print(SwitchMap.switches);
                    return Dismissible(
                      key: Key(SwitchMap.switches[roomname]!.values
                          .elementAt(index)["name"]),
                      onDismissed: (left) {
                        SwitchMap.removeSwitch(roomname, index);
                        setState(() {});
                        SwitchMap.switchNoReallocate(roomname);
                      },
                      child: Container(
                        child: SwitchListTile(
                          title:
                              "${SwitchMap.switches[roomname]!.values.elementAt(index)["name"]}"
                                  .text
                                  .make(),
                          // "${data.keys.elementAt(index)}".text.make(),
                          value: switchBoolValue(index),
                          onChanged: (val) {
                            onchangedvalue(switchno: index);
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text("NO DATA YET"),
                    );
                  }
                },
              );
            },
          ),
        ).expand(),
        FloatingActionButton(
          heroTag: null,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddNewDevices(roomname: roomname)));
          },
          child: Icon(Icons.add),
        ).pOnly(bottom: 18)
      ],
    ).hHalf(context);
  }
}
