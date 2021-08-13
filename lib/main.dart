import 'package:flutter/material.dart';
import 'package:smart_measure/core/store.dart';

import 'package:smart_measure/pages/signin_page.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    VxState(
      store: Mystore(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: AddNewDevices(),
      // SinglePageApp(),
      theme: ThemeData(
          primaryColor: Colors.amber, primarySwatch: Colors.deepOrange),
      darkTheme: ThemeData.dark(),
      routes: {
        "/": (context) => LoginPage(),
      },
    );
  }
}
