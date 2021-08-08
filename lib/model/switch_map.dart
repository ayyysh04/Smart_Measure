class SwitchMap {
  static Map<String, Map<String, Map>> switches = {
    // "Room 1": {
    //   "Switch 1": {
    //     "name": "Laptop",
    //     "status": "on",
    //     "pin": "12",
    //     "type": "button",
    //   },
    //   "Switch 2":
    //   {
    //     "name": "Mobile",
    //     "status": "on",
    //     "pin": "12",
    //     "type": "button",
    //   }
    // },
    // "Room 2": {
    //   "Switch 1": {
    //     "name": "Mobile",
    //     "status": "on",
    //     "pin": "12",
    //     "type": "button",

    //   }
    // },
  };

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
    print(newSwitches);
    switches[roomName]!.clear();
    switches[roomName] = newSwitches[roomName]!;

    newSwitches.clear();
  }

  static void addNewRoom(String roomName) {
    switches["$roomName"] = {};
  }

  static void addNewSwitch(String? name, String? status, String? pin,
      String? type, String roomName, int switchNo) {
    switches["$roomName"]!["Switch ${switchNo + 1}"] = {
      "name": name,
      "status": status,
      "pin": pin,
      "type": type,
    };
  }

  static void removeSwitch(String roomName, int index) {
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
