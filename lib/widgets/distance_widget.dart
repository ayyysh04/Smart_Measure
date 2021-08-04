import 'package:flutter/material.dart';

Widget distanceWidget(var distance) {
  return Center(
    child: Container(

        // child: SfRadialGauge(
        //   axes: <RadialAxis>[
        //     RadialAxis(minimum: 0, maximum: 1000, ranges: <GaugeRange>[
        //       GaugeRange(startValue: 0, endValue: 200, color: Colors.green),
        //       GaugeRange(startValue: 200, endValue: 500, color: Colors.orange),
        //       GaugeRange(startValue: 500, endValue: 1000, color: Colors.red)
        //     ], pointers: <GaugePointer>[
        //       NeedlePointer(value: distance.toDouble())
        //     ], annotations: <GaugeAnnotation>[
        //       GaugeAnnotation(
        //           widget: Container(
        //               child: Text(distance.toString() + ' cm',
        //                   style: TextStyle(
        //                       fontSize: 25, fontWeight: FontWeight.bold))),
        //           angle: 90,
        //           positionFactor: 0.5)
        //     ])
        //   ],
        // ),
        ),
  );
}
