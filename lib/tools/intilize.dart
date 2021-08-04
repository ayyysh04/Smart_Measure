import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

Future<FirebaseApp> initilizeFirebase(
    final String apikey, appid, projid, msgsenderid) async {
  FirebaseOptions options = new FirebaseOptions(
    // apiKey: "AIzaSyDFGYHFRFbVXwmFHlQjG1fgYplrGDoDn6g",
    // appId: "1:75572556145:android:23fce3e8df464504d5c6d0",
    // projectId: "smart-measure-e0ced",
    // messagingSenderId: '75572556145',
    apiKey: apikey,
    appId: appid,
    projectId: projid,
    messagingSenderId: msgsenderid,
    // databaseURL: "https://smart-measure-e0ced-default-rtdb.firebaseio.com",
    // storageBucket: "smart-measure-e0ced.appspot.com",
    // androidClientId:
    //     "75572556145-t3eh0ufj9qid7b7a5qf7i13s7cafekh3.apps.googleusercontent.com"
  );

  final FirebaseApp firebase =
      await Firebase.initializeApp(options: options, name: "AppName");

  return firebase;
}

String getRandomString(int length) {
  const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

DatabaseReference intitilizeDatabase(FirebaseApp? firebase) {
  DatabaseReference database = FirebaseDatabase(app: firebase).reference();
  return database;
}

Future<void> deleteApp(FirebaseApp? firebase) async {
  await firebase!.delete();
}
