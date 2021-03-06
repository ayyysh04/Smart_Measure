import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_measure/core/store.dart';
import 'package:smart_measure/model/switch_map.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewDevices extends StatefulWidget {
  final String roomname;
  AddNewDevices({
    Key? key,
    required this.roomname,
  }) : super(key: key);

  @override
  _AddNewDevicesState createState() => _AddNewDevicesState(roomname);
}

class _AddNewDevicesState extends State<AddNewDevices> {
  SwitchMap? switchMapData = (VxState.store as Mystore).switchData;
  String roomname;
  final DatabaseReference? database =
      (VxState.store as Mystore).databaseData!.database;
  String? deviceType;
  int? pinNo;
  String? deviceName;
  final _formKey = GlobalKey<FormState>();
  _AddNewDevicesState(this.roomname);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: "New Devices".text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            newDeviceHeader().pSymmetric(h: 20, v: 20),
            20.heightBox,
            Form(
              key: _formKey,
              child: Column(
                children: [
                  deviceNameTextField(),
                  20.heightBox,
                  pinNoTextField(),
                  20.heightBox,
                  dropDownMenu(),
                ],
              ).pSymmetric(h: 30),
            ),
            20.heightBox,
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  int totalDevices = SwitchMap.switches[roomname]!.length;
                  AddNewSwitch(deviceName, "off", pinNo, deviceType, roomname,
                      totalDevices);
                  // switchMapData!.addNewSwitch(deviceName, "off", pinNo,
                  //     deviceType, roomname, totalDevices);
                  // await Database.database
                  //     .child("/Devices")
                  //     .child(roomname)
                  //     .child("Switch ${totalDevices + 1}")
                  //     .set(0);
                  Navigator.pop(context, true);
                }
              },
              child: "Add".text.make(),
            )
          ],
        ),
      ),
    );
  }

  Container newDeviceHeader() {
    return Container(
      child: "Add a New Device".text.color(Vx.yellow500).xl4.make().centered(),
    );
  }

  Container deviceNameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Vx.gray200,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: (deviceType == null) ? "Enter Device name" : deviceType,
          labelText: "Device name:",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Device name cannot be empty";
          }
          return null;
        },
        onChanged: (value) {
          deviceName = value;
        },
      ).pSymmetric(
        h: 30,
      ),
    );
  }

  Container pinNoTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Vx.gray200,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          disabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          hintText: "Enter Pin number used in board",
          labelText: "Pin no.:",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Pin number cannot be empty";
          }
          return null;
        },
        onChanged: (value) {
          pinNo = int.parse(value);
        },
      ).pSymmetric(h: 30),
    );
  }

  Container dropDownMenu() {
    return Container(
      decoration: BoxDecoration(
        color: Vx.gray200,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: DropdownButton<String>(
        focusColor: Colors.white,
        value: deviceType,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items: <String>[
          "Light Switch",
          "Fans Switch",
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: Text(
          "Enter Device type",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        onChanged: (value) {
          setState(() {
            deviceType = value!;
          });
        },
      ).pSymmetric(h: 20),
    );
  }
}
