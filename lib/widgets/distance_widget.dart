import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class DistancePage extends StatefulWidget {
  final DatabaseReference database;
  const DistancePage({
    Key? key,
    required this.database,
  }) : super(key: key);

  @override
  _DistancePageState createState() => _DistancePageState(database);
}

class _DistancePageState extends State<DistancePage> {
  final DatabaseReference database;
  var distance;
  _DistancePageState(this.database);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stream.fromIterable(elements)
        // Stream.multi(() { })
        // Stream.fromFutures(futures)
        // Stream.fromFuture(future)
        StreamBuilder(
          stream:
              // database.onValue
              database
                  .child("")
                  .onValue //onValue:When value changes then this gets trigger

          ,
          builder: (context, AsyncSnapshot<Event> snap) {
            if (snap.hasData &&
                !snap.hasError &&
                snap.data!.snapshot.value != null) {
              Map data = snap.data!.snapshot.value;
              distance = data['cm'];

              return distanceWidget(distance);
            } else {
              return Center(
                child: Text("NO DATA YET"),
              );
            }
          },
        ).expand(),
      ],
    );
  }
}

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
