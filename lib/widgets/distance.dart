import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:smart_measure/core/store.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_fonts/google_fonts.dart';

class DistancePage extends StatefulWidget {
  const DistancePage({
    Key? key,
  }) : super(key: key);

  @override
  _DistancePageState createState() => _DistancePageState();
}

class _DistancePageState extends State<DistancePage> {
  _DistancePageState();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        "Welcome to the Smart Home".text.xl5.center.make().centered().expand(),
        "This is a Prototype app".text.align(TextAlign.end).make(),
        "Made by Ayush Yadav".text.align(TextAlign.end).make()
      ],
    );
  }
}
