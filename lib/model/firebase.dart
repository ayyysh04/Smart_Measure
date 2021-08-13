import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_measure/core/store.dart';
import 'package:smart_measure/model/switch_map.dart';
import 'package:velocity_x/velocity_x.dart';

class Database {
  DatabaseReference? database;

  intitilizeDatabase() async {
    FirebaseDatabase base = FirebaseDatabase(
        // app: Firebaseapp.firebase
        );

    database = base.reference();
    base.setPersistenceEnabled(true);

    base.setPersistenceCacheSizeBytes(10000000);

    await database!.child("/Devices").once().then((value) {
      print(value.value);
      if (value.value == null)
        return;
      else {
        SwitchMap? switchMapData = (VxState.store as Mystore).switchData;
        switchMapData!.frommap(value.value);
      }
      database!.keepSynced(true);
    });
  }
}

class Firebaseapp {
  FirebaseApp? firebase;

  Future<void> initilizeFirebase(
      final String? apikey, appid, projid, msgsenderid) async {
    // FirebaseOptions options = new FirebaseOptions(
    //   apiKey: apikey!,
    //   appId: appid,
    //   projectId: projid,
    //   messagingSenderId: msgsenderid,
    // );
    // if (Firebase.apps.length == 0)
    // firebase = await Firebase.initializeApp(
    //     options: options, name: "defaultFirebaseAppName");
    firebase = await Firebase.initializeApp();
  }

  Future<void> deleteApp() async {
    await firebase!.delete();
  }
}
