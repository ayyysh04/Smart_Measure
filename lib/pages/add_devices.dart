import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewDevices extends StatefulWidget {
  final DatabaseReference database;
  AddNewDevices({
    Key? key,
    required this.database,
  }) : super(key: key);

  @override
  _AddNewDevicesState createState() => _AddNewDevicesState(database);
}

class _AddNewDevicesState extends State<AddNewDevices> {
  final DatabaseReference database;
  String? deviceType;
  String? pinNo;
  String? deviceName;
  final _formKey = GlobalKey<FormState>();

  _AddNewDevicesState(this.database);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: "New Devices".text.make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            newDeviceHeader().pSymmetric(h: 20, v: 20),
            20.heightBox,
            Column(
              children: [
                deviceNameTextField(),
                20.heightBox,
                pinNoTextField(),
                20.heightBox,
                dropDownMenu(),
              ],
            ).pSymmetric(h: 30),
            20.heightBox,
            ElevatedButton(
              onPressed: () async {
                await database.child("status3").set("OFF");
                Navigator.pop(context, {
                  "status": true,
                  "deviceType": deviceType,
                  "pinNo": pinNo,
                  "deviceName": deviceName
                });
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
          hintText: "Enter Device name",
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
      ).pSymmetric(h: 30),
    );
  }

  Container pinNoTextField() {
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
          pinNo = value;
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
        onChanged: (String? value) {
          setState(() {
            deviceType = value;
          });
        },
      ).pSymmetric(h: 20),
    );
  }
}
