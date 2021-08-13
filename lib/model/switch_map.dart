import 'package:velocity_x/velocity_x.dart';

import 'package:smart_measure/core/store.dart';
import 'package:smart_measure/model/firebase.dart';

Database? databaseData = (VxState.store as Mystore).databaseData;

class SwitchMap {
  static Map<String, Map<String, Map>> switches = {};

  void frommap(Map data) {
    for (int i = 0; i < data.length; i++) //rooms
    {
      String roomName = data.keys.elementAt(i).toString();
      // print(roomName);
      switches[roomName] = {}; //adding room
      for (int j = 0; j < data[roomName].length; j++) //np of switches
      {
        String switchName = data[roomName].keys.elementAt(j).toString();
        print(switchName);
        switches[roomName]![switchName] = data[roomName][switchName];
      }
    }
  }

  // void switchNoReallocate(String roomName) {
  //   Map<String, Map<String, Map>> newSwitches = {};

  //   for (int i = 0; i < switches.length; i++) //no of rooms
  //   {
  //     newSwitches["${switches.keys.elementAt(i)}"] = {};

  //     for (int j = 0;
  //         j < switches.values.elementAt(i).length;
  //         j++) //No .of switches
  //     {
  //       if (switches.values.elementAt(i).keys.elementAt(j) ==
  //           "Switch ${j + 1}") {
  //         {
  //           newSwitches["${newSwitches.keys.elementAt(i)}"]![
  //                   "${switches.values.elementAt(i).keys.elementAt(j)}"] =
  //               switches.values.elementAt(i).values.elementAt(j);
  //         }
  //       } else {
  //         newSwitches["${newSwitches.keys.elementAt(i)}"]!["Switch ${j + 1}"] =
  //             switches.values.elementAt(i).values.elementAt(j);
  //       }
  //     }
  //   }
  //   switches[roomName]!.clear();
  //   switches[roomName] = newSwitches[roomName]!;
  //   print(switches[roomName]);
  //   databaseData!.database!.child("/Devices").update(switches);
  //   newSwitches.clear();
  // }

  // void addNewRoom(String roomName) {
  //   switches["$roomName"] = {};
  // }

  // Future<void> addNewSwitch(String? name, String? status, String? pin,
  //     String? type, String roomName, int switchNo) async {
  //   switches["$roomName"]!["Switch ${switchNo + 1}"] = {
  //     "name": name,
  //     "status": status,
  //     "pin": pin,
  //     "type": type,
  //   };
  //   databaseData!.database!
  //       .child("/Devices")
  //       .child(roomName)
  //       .child("Switch ${switchNo + 1}")
  //       .child("name")
  //       .set(name);
  //   databaseData!.database!
  //       .child("/Devices")
  //       .child(roomName)
  //       .child("Switch ${switchNo + 1}")
  //       .child("status")
  //       .set(status);
  //   databaseData!.database!
  //       .child("/Devices")
  //       .child(roomName)
  //       .child("Switch ${switchNo + 1}")
  //       .child("pin")
  //       .set(pin);
  //   databaseData!.database!
  //       .child("/Devices")
  //       .child(roomName)
  //       .child("Switch ${switchNo + 1}")
  //       .child("type")
  //       .set(type);
  // }

  // void removeSwitch(String roomName, int index) async {
  //   databaseData!.database!
  //       .child("/Devices")
  //       .child(roomName)
  //       .child("Switch ${index + 1}")
  //       .remove();
  //   switches["$roomName"]!.remove(switches["$roomName"]!.keys.elementAt(index));
  // }

  // void removeRoom(String roomName) {
  //   switches.remove(roomName);
  // }
}

//Muations

class AddNewRoom extends VxMutation<Mystore> {
  String roomName;
  AddNewRoom(this.roomName);

  @override
  perform() {
    SwitchMap.switches["$roomName"] = {};
  }
}

class SwitchNoReallocate extends VxMutation<Mystore> {
  String roomName;
  SwitchNoReallocate(
    this.roomName,
  );

  @override
  perform() {
    Map<String, Map<String, Map>> newSwitches = {};

    for (int i = 0; i < SwitchMap.switches.length; i++) //no of rooms
    {
      newSwitches["${SwitchMap.switches.keys.elementAt(i)}"] = {};

      for (int j = 0;
          j < SwitchMap.switches.values.elementAt(i).length;
          j++) //No .of switches
      {
        if (SwitchMap.switches.values.elementAt(i).keys.elementAt(j) ==
            "Switch ${j + 1}") {
          {
            newSwitches["${newSwitches.keys.elementAt(i)}"]![
                    "${SwitchMap.switches.values.elementAt(i).keys.elementAt(j)}"] =
                SwitchMap.switches.values.elementAt(i).values.elementAt(j);
          }
        } else {
          newSwitches["${newSwitches.keys.elementAt(i)}"]!["Switch ${j + 1}"] =
              SwitchMap.switches.values.elementAt(i).values.elementAt(j);
        }
      }
    }
    SwitchMap.switches[roomName]!.clear();
    SwitchMap.switches[roomName] = newSwitches[roomName]!;
    print(SwitchMap.switches[roomName]);
    databaseData!.database!.child("/Devices").update(SwitchMap.switches);
    newSwitches.clear();
  }
}

class AddNewSwitch extends VxMutation<Mystore> {
  String? name;
  String? statusOfSwitch;
  int? pin;
  String? type;
  String roomName;
  int switchNo;
  AddNewSwitch(
    this.name,
    this.statusOfSwitch,
    this.pin,
    this.type,
    this.roomName,
    this.switchNo,
  );

  @override
  perform() {
    SwitchMap.switches["$roomName"]!["Switch ${switchNo + 1}"] = {
      "name": name,
      "status": statusOfSwitch,
      "pin": pin,
      "type": type,
    };
    databaseData!.database!
        .child("/Devices")
        .child(roomName)
        .child("Switch ${switchNo + 1}")
        .child("name")
        .set(name);
    databaseData!.database!
        .child("/Devices")
        .child(roomName)
        .child("Switch ${switchNo + 1}")
        .child("status")
        .set(statusOfSwitch);
    databaseData!.database!
        .child("/Devices")
        .child(roomName)
        .child("Switch ${switchNo + 1}")
        .child("pin")
        .set(pin);
    databaseData!.database!
        .child("/Devices")
        .child(roomName)
        .child("Switch ${switchNo + 1}")
        .child("type")
        .set(type);
  }
}

class RemoveRoom extends VxMutation<Mystore> {
  String roomName;
  RemoveRoom(this.roomName);

  @override
  perform() {
    SwitchMap.switches.remove(roomName);
  }
}

class RemoveSwitch extends VxMutation<Mystore> {
  String roomName;
  int index;

//constructor
  RemoveSwitch(this.roomName, this.index);

  @override
  perform() {
    store!.databaseData!.database!
        .child("/Devices")
        .child(roomName)
        .child("Switch ${index + 1}")
        .remove();
    SwitchMap.switches["$roomName"]!
        .remove(SwitchMap.switches["$roomName"]!.keys.elementAt(index));
  }
}
// switches["Room $number"]["$devicename"]["status"];//This can be used to get data of a partcilar switch
//switches.length //this will be the number of rooms
//switches["Room $number"].length //this will be no. of switches in that room
//------
// Map switchData = {
//   "name": "1",
//   "status": "on",
//   "pin": "12",
//   "type": "button"
// }; //stores a map of switch data

// List<String> roomdevices = ["Mobile", "Laptop"]; //stores list of switches    //useless
// List<String> rooms = ["Room 1", "Room 2"]; //Stores list of room

// rooms and roomdevices will be on childadded stream and data will be updated using .set()
//switchdata will be onvalue stream and its value will be updated using .update()
