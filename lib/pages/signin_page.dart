import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_measure/model/firebase.dart';
import 'package:smart_measure/pages/singlepage_app.dart';
import 'package:smart_measure/tools/intilize.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String apikey, appid, projid, msgsenderid;

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Container(child: "Login".text.xl5.make().centered())
                    .pSymmetric(v: 50),
                20.heightBox,
                Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter api key",
                          labelText: "Api key:",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          apikey = value;
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter app id",
                          labelText: "app id:",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          appid = value;
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter project id ",
                          labelText: "project id:",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          projid = value;
                        }),
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter messaging Sender Id",
                          labelText: "messaging Sender Id:",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username cannot be empty";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          msgsenderid = value;
                        }),
                    20.heightBox,
                    ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                await Firebaseapp.initilizeFirebase(
                                    apikey, appid, projid, msgsenderid);

                                Database.intitilizeDatabase();
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SinglePageApp(),
                                    )..completed.then((_) async {
                                        Firebaseapp.deleteApp();
                                      }));
                              }
                            },
                            child: "Login".text.make())
                        .wh(100, 50),
                  ],
                ).pSymmetric(h: 50)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
