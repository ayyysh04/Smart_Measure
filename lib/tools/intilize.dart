import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

Future<FirebaseApp> initilizeFirebase(
    String apikey, appid, projid, msgsenderid) async {
  FirebaseOptions options = new FirebaseOptions(
    apiKey: apikey,
    appId: appid,
    projectId: projid,
    messagingSenderId: msgsenderid,
  );

  FirebaseApp firebase =
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
