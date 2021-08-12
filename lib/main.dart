import 'package:flutter/material.dart';

import 'package:smart_measure/pages/signin_page.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
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
        // "/addDevice": (context) => AddNewDevices(),
      },
    );
  }
}
