import 'package:smart_measure/model/firebase.dart';
import 'package:smart_measure/model/firebase_login.dart';
import 'package:smart_measure/model/switch_map.dart';
import 'package:velocity_x/velocity_x.dart';

class Mystore extends VxStore {
  FirebaseLoginModel? firebaseLogindata;
  SwitchMap? switchData;
  Firebaseapp? fireAppData;
  Database? databaseData;
//constructor ,We can also define them initially like done in above comments too
  Mystore() {
    firebaseLogindata = FirebaseLoginModel();
    switchData = SwitchMap();
    fireAppData = Firebaseapp();
    databaseData = Database();
  }
}
