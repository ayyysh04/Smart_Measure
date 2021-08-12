import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_measure/widgets/switch.dart';
import 'package:smart_measure/widgets/distance.dart';

class SinglePageApp extends StatefulWidget {
  @override
  const SinglePageApp({
    Key? key,
  }) : super(key: key);
  @override
  _SinglePageAppState createState() => _SinglePageAppState();
}

class _SinglePageAppState extends State<SinglePageApp>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;
  List _pageOptions = [DistancePage(), SwitchPage()];

  _SinglePageAppState();

  // FirebaseDatabase().reference();
  // database refrence

  // void getData() async {
  //   //to get the value if the database
  //   DataSnapshot data =
  //       await database.once(); //retrieve database once in datsnapshot

  //   //put the data in our local variables
  //   setState(() {
  //     led = data.value['STATUS'];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return mainPage();
  }

  Widget mainPage() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Smart Measure"),
        bottom: TabBar(
          controller: _tabController,
          onTap: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          tabs: [
            Tab(
              icon: Icon(CupertinoIcons.chart_bar_square),
            ),
            Tab(
              icon: Icon(Icons.light),
            )
          ],
        ),
      ),
      body: _pageOptions[_selectedTab],
    );
  }
}
