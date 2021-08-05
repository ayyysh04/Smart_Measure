import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_measure/model/firebase.dart';
import 'package:smart_measure/pages/add_devices.dart';
import 'package:velocity_x/velocity_x.dart';

class ButtonPage extends StatefulWidget {
  final DatabaseReference database = Database.database;
  ButtonPage({
    Key? key,
  }) : super(key: key);

  @override
  _ButtonPageState createState() => _ButtonPageState(database);
}

class _ButtonPageState extends State<ButtonPage> {
  List<bool> switchValues = [];
  final DatabaseReference database;

  _ButtonPageState(this.database);
  onchangedvalue({required int switchno}) async {
    // switchValues[switchno] = switchValues[switchno].toggle();

    int swtno = switchno + 1;
    if (switchValues[switchno] == true)
      await database.child("switch $swtno").set("OFF");
    else
      await database.child("switch $swtno").set("ON");
  }

  @override
  Widget build(BuildContext context) {
    addSwitch() async {
      dynamic result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddNewDevices(database: database)));
      setState(() {
        if (result != null && result["status"] == true) {
          switchValues.add(false);
          int switchno = switchValues.length;
          database.child("switch $switchno").set("OFF");
        }
      });
    }

    //--------------------
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // Room 1
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: Column(
                    children: [
                      "Room 1".text.xl2.make(),
                      ListView.separated(
                        itemCount: switchValues.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return StreamBuilder(
                            stream: database.onValue,
                            builder:
                                (BuildContext context, AsyncSnapshot snap) {
                              if (snap.hasData &&
                                  !snap.hasError &&
                                  snap.data!.snapshot.value != null) {
                                Map data = snap.data!.snapshot.value;
                                print(data);

                                var status = data["switch ${index + 1}"];
                                print(status);
                                if (status == "ON")
                                  switchValues[index] = true;
                                else
                                  switchValues[index] = false;
                                return Container(
                                  child: SwitchListTile(
                                    title: "switch ${index + 1}".text.make(),
                                    value: switchValues[index],
                                    onChanged: (val) {
                                      onchangedvalue(switchno: index);
                                    },
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
                      ).expand(),
                    ],
                  ),
                ).expand(),
              ],
            ),
          ).pOnly(left: 20, right: 20).expand(),
          FloatingActionButton(
            onPressed: () {
              addSwitch();
            },
            child: Icon(Icons.add),
          ).pOnly(bottom: 18)
        ],
      ),
    );
  }
}
