import 'dart:collection';

class Devices //Stores all data
{
  List<Room> rooms = [];

  Devices.fromMap(Map data) {
    data.forEach //iterate every room
        (
      (key, value) {
        rooms.add(Room.fromMap(data[key]));
      },
    );
  }
}

class Room {
  // String roomName;
  List<Switch> switches;
  Room({
    required this.switches,
  });

  factory Room.fromMap(Map data) {
    List<Switch> temp = [];
    SplayTreeMap newdata =
        SplayTreeMap<String, dynamic>.from(data, (a, b) => a.compareTo(b));
    newdata.forEach((key, value) //iterate all switches and add them in a list
        {
      temp.add(Switch.fromMap(newdata[key]));
    });
    return Room(switches: temp);
  }
}

class Switch {
  String name;
  int pin;
  String type;
  String status;
  Switch({
    required this.name,
    required this.pin,
    required this.type,
    required this.status,
  });

  factory Switch.fromMap(Map data) {
    return Switch(
      name: data["name"],
      pin: data["pin"],
      type: data["type"],
      status: data["status"],
    );
  }
}
