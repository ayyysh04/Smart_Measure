import 'package:flutter/material.dart';
import 'package:smart_measure/model/firebase.dart';
import 'package:smart_measure/model/switch_map.dart';
import 'package:velocity_x/velocity_x.dart';

showBottomsSheet(BuildContext context, String use) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: use == "Add"
              ? addBottomSheetContainer(context)
              : removeBottomSheetContainer(context),
        );
      });
}

removeBottomSheetContainer(BuildContext context) {
  final _formkey = GlobalKey<FormState>();
  late String roomname;
  return Container(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(child: "Room Name".text.xl2.make().centered())
              .pSymmetric(v: 5),
          5.heightBox,
          TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Enter Room Name",
                labelText: "Room Name:",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username cannot be empty";
                }
                return null;
              },
              onChanged: (value) {
                roomname = value;
              }),
          ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  SwitchMap.removeRoom(roomname);
                  Navigator.pop(context);
                  Database.database.child("/Devices").child(roomname).remove();
                }
              },
              child: "Remove".text.make()),
        ],
      ),
    ),
  ).pSymmetric(h: 20, v: 10);
}

Widget addBottomSheetContainer(BuildContext context) {
  final _formkey = GlobalKey<FormState>();
  late String roomname;
  return Container(
    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
    child: Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(child: "Room Name".text.xl2.make().centered())
              .pSymmetric(v: 5),
          5.heightBox,
          TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Enter Room Name",
                labelText: "Room Name:",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Username cannot be empty";
                }
                return null;
              },
              onChanged: (value) {
                roomname = value;
              }),
          ElevatedButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  SwitchMap.addNewRoom(roomname);
                  Database.database.child("/Devices").child(roomname).set(0);
                  Navigator.pop(context);
                }
              },
              child: "Create".text.make()),
        ],
      ),
    ),
  ).pSymmetric(h: 20, v: 10);
}
