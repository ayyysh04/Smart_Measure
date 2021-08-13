import 'package:flutter/material.dart';

import 'package:smart_measure/model/switch_map.dart';
import 'package:smart_measure/pages/button_Page.dart';
import 'package:smart_measure/widgets/modal_bottom_sheet.dart';
import 'package:velocity_x/velocity_x.dart';

class SwitchPage extends StatelessWidget {
  const SwitchPage({Key? key}) : super(key: key);
  // bool led = false;
  // void updateswitch() async {
  //   if (led == true)
  //     await database.update({'STATUS': "OFF"});
  //   else
  //     await database.update({'STATUS': "ON"});
  // }

  @override
  Widget build(BuildContext context) {
    // print(SwitchMap.switches);
    // database.child("/Devices").once().then((value) {
    //   // Map<String, Map<String, Map>> data = value.value;
    //   // SwitchMap.switches = data;
    //   print(value.value);
    //   // SwitchMap.frommap(value.value);
    // });
    return SafeArea(
        child: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            10.heightBox,
            Container(
              child: RoomListBuilderWidget(),
              // child: Column(
              //   children: [ButtonPage().expand()],
              // ).hPCT(context: context, heightPCT: 70.0),
            ).h(600),
            ButtonRow()
          ],
        ),
      ),
    ));
  }
}

class ButtonRow extends StatelessWidget {
  const ButtonRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: null,
          backgroundColor: Colors.black,
          onPressed: () async {
            showBottomsSheet(context, "Add");
            // setState(() {});
          },
          child: "Room".text.make(),
        ),
        10.widthBox,
        FloatingActionButton(
          heroTag: null,
          backgroundColor: Colors.black,
          onPressed: () async {
            showBottomsSheet(context, "Remove");
            // setState(() {});
          },
          child: Icon(Icons.remove),
        ),
      ],
    );
  }
}

class RoomListBuilderWidget extends StatelessWidget {
  const RoomListBuilderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VxState.watch(context, on: [AddNewRoom, RemoveRoom]);
    return ListView.separated(
      itemCount: SwitchMap.switches.length,
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
      itemBuilder: (BuildContext context, int index) {
        String roomname = SwitchMap.switches.keys.elementAt(index);
        return Container(
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            children: [
              roomname.text.make(),
              ButtonPage(
                roomname: roomname,
              ),
            ],
          ),
        ).pOnly(left: 20, right: 20);
      },
    );
  }
}



//Alert box - extra content
// showAlertDialog(BuildContext context) {
//   // Create button
//   Widget okButton = ElevatedButton(
//     child: Text("OK"),
//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//   );

//   // Create AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("Simple Alert"),
//     content: Text("This is an alert message."),
//     actions: [
//       okButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
