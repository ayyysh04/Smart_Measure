import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  static late DatabaseReference database;

  static void intitilizeDatabase() {
    database = FirebaseDatabase(app: Firebaseapp.firebase).reference();
  }
}

class Firebaseapp {
  static late FirebaseApp firebase;

  static Future<void> initilizeFirebase(
      final String apikey, appid, projid, msgsenderid) async {
    FirebaseOptions options = new FirebaseOptions(
      apiKey: apikey,
      appId: appid,
      projectId: projid,
      messagingSenderId: msgsenderid,
    );

    firebase = await Firebase.initializeApp(options: options, name: "AppName");
  }

  static Future<void> deleteApp() async {
    await firebase.delete();
  }
}
