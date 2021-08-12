import 'package:smart_measure/model/firebase.dart';

class SwitchMap {
  static Map<String, Map<String, Map>> switches = {};

  static void frommap(Map data) {
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

  static void switchNoReallocate(String roomName) {
    Map<String, Map<String, Map>> newSwitches = {};

    for (int i = 0; i < switches.length; i++) //no of rooms
    {
      newSwitches["${switches.keys.elementAt(i)}"] = {};

      for (int j = 0;
          j < SwitchMap.switches.values.elementAt(i).length;
          j++) //No .of switches
      {
        if (switches.values.elementAt(i).keys.elementAt(j) ==
            "Switch ${j + 1}") {
          {
            newSwitches["${newSwitches.keys.elementAt(i)}"]![
                    "${switches.values.elementAt(i).keys.elementAt(j)}"] =
                switches.values.elementAt(i).values.elementAt(j);
          }
        } else {
          newSwitches["${newSwitches.keys.elementAt(i)}"]!["Switch ${j + 1}"] =
              switches.values.elementAt(i).values.elementAt(j);
        }
      }
    }
    switches[roomName]!.clear();
    switches[roomName] = newSwitches[roomName]!;
    print(switches[roomName]);
    Database.database.child("/Devices").update(switches);
    newSwitches.clear();
  }

  static void addNewRoom(String roomName) {
    switches["$roomName"] = {};
  }

  static Future<void> addNewSwitch(String? name, String? status, String? pin,
      String? type, String roomName, int switchNo) async {
    switches["$roomName"]!["Switch ${switchNo + 1}"] = {
      "name": name,
      "status": status,
      "pin": pin,
      "type": type,
    };
    Database.database
        .child("/Devices")
        .child(roomName)
        .child("Switch ${switchNo + 1}")
        .child("name")
        .set(name);
    Database.database
        .child("/Devices")
        .child(roomName)
        .child("Switch ${switchNo + 1}")
        .child("status")
        .set(status);
    Database.database
        .child("/Devices")
        .child(roomName)
        .child("Switch ${switchNo + 1}")
        .child("pin")
        .set(pin);
    Database.database
        .child("/Devices")
        .child(roomName)
        .child("Switch ${switchNo + 1}")
        .child("type")
        .set(type);
  }

  static void removeSwitch(String roomName, int index) async {
    Database.database
        .child("/Devices")
        .child(roomName)
        .child("Switch ${index + 1}")
        .remove();
    switches["$roomName"]!.remove(switches["$roomName"]!.keys.elementAt(index));
  }

  static void removeRoom(String roomName) {
    switches.remove(roomName);
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
