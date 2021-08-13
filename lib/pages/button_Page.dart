import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_measure/core/store.dart';
import 'package:smart_measure/model/switch_map.dart';
import 'package:smart_measure/pages/add_devices.dart';
import 'package:velocity_x/velocity_x.dart';

DatabaseReference? database = (VxState.store as Mystore).databaseData!.database;

class ButtonPage extends StatelessWidget {
  final String roomname;
  ButtonPage({
    Key? key,
    required this.roomname,
  }) : super(key: key);

  onchangedvalue({required int switchno}) async {
    // switchValues[switchno] = switchValues[switchno].toggle();
    // if (switchValues[switchno] == true)
    //   await database.child("").set("OFF");
    // else
    //   await database.child("").set("ON");

    if (SwitchMap.switches[roomname]!.values.elementAt(switchno)["status"] ==
        "on") {
      SwitchMap.switches[roomname]!.values.elementAt(switchno)["status"] =
          "off";
      database!
          .child("/Devices")
          .child(roomname)
          .child("Switch ${switchno + 1}")
          .child("status")
          .set("off");
    } else {
      SwitchMap.switches[roomname]!.values.elementAt(switchno)["status"] = "on";
      database!
          .child("/Devices")
          .child(roomname)
          .child("Switch ${switchno + 1}")
          .child("status")
          .set("on");
    }
    // setState(() {});
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
    VxState.watch(context, on: [AddNewSwitch, RemoveSwitch]);
    //for checking data

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
                stream: database!.child("Devices/$roomname").onValue,
                builder: (BuildContext context, AsyncSnapshot<Event> snap) {
                  if (snap.hasData &&
                      !snap.hasError &&
                      snap.data!.snapshot.value != null &&
                      SwitchMap.switches.length != 0) {
                    // Map data = snap.data!.snapshot.value;

                    // print(data);
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
                      onDismissed: (left) async {
                        RemoveSwitch(roomname, index);
                        // switchMapData!.removeSwitch(roomname, index);
                        // setState(() {});
                        SwitchNoReallocate(roomname);
                        // switchMapData.switchNoReallocate(roomname);
                      },
                      child: Container(
                        child: SwitchListTile(
                          title:
                              "${SwitchMap.switches[roomname]!.values.elementAt(index)["name"]}"
                                  .text
                                  .make(),
                          // "${data.keys.elementAt(index)}".text.make(),
                          value: switchBoolValue(index),
                          onChanged: (_) {
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
                    builder: (context) => AddNewDevices(roomname: roomname))
                  ..completed.then((_) async {
                    // setState(() {});
                  }));
          },
          child: Icon(Icons.add),
        ).pOnly(bottom: 18)
      ],
    ).hHalf(context);
  }
}
