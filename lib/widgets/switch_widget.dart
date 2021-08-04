import 'package:flutter/material.dart';

Widget switchLayout(bool led) {
  return Center(
      child: Column(
    children: [
      Container(
        padding: const EdgeInsets.only(top: 80),
        child: Text(
          "POWER ON/OFF",
          style: led
              ? TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.amber)
              : TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.black),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(28.0),
        child: FloatingActionButton.extended(
          icon: led ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
          backgroundColor: led ? Colors.amber : Colors.black,
          label: led ? Text("ON") : Text("OFF"),
          elevation: 30.00,
          onPressed: () {
            // onUpdate();
            // updateswitch();
          },
        ),
      )
    ],
  ));
}
