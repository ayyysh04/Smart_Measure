import 'package:flutter/material.dart';
import 'package:smart_measure/core/store.dart';
import 'package:smart_measure/model/firebase.dart';
import 'package:smart_measure/model/firebase_login.dart';
import 'package:smart_measure/pages/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    FirebaseLoginModel? firebaseLoginData =
        (VxState.store as Mystore).firebaseLogindata;
    String? apikey, appid, projid, msgsenderid;
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
                    LoginButtonWidget(
                            formkey: _formkey,
                            firebaseLoginData: firebaseLoginData,
                            apikey: apikey,
                            appid: appid,
                            msgsenderid: msgsenderid,
                            projid: projid)
                        .wh(100, 50),
                    10.heightBox,
                    DeleteButtonWidget(),
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

class DeleteButtonWidget extends StatelessWidget {
  const DeleteButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Firebaseapp? firebaseAppData = (VxState.store as Mystore).fireAppData;
    return ElevatedButton(
        onPressed: () {
          firebaseAppData!.deleteApp();
        },
        child: "LOGOUT PERMANENT".text.make());
  }
}

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({
    Key? key,
    required GlobalKey<FormState> formkey,
    required this.firebaseLoginData,
    required this.apikey,
    required this.appid,
    required this.msgsenderid,
    required this.projid,
  })  : _formkey = formkey,
        super(key: key);

  final GlobalKey<FormState> _formkey;
  final FirebaseLoginModel? firebaseLoginData;
  final String? apikey;
  final String? appid;
  final String? msgsenderid;
  final String? projid;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          if (_formkey.currentState!.validate()) {
            firebaseLoginData!.apiKey = apikey;
            firebaseLoginData!.appId = appid;

            firebaseLoginData!.messagingSenderId = msgsenderid;

            firebaseLoginData!.projectId = projid;

            // await Firebaseapp.initilizeFirebase(
            //     apikey, appid, projid, msgsenderid);
            Database? databaseData = (VxState.store as Mystore).databaseData;
            databaseData!.intitilizeDatabase();
            await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePageApp(),
                )..completed.then((_) async {
                    // Firebaseapp.deleteApp();
                  }));
          }
        },
        child: "Login".text.make());
  }
}
