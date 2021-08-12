import 'package:smart_measure/model/firebase_login.dart';
import 'package:smart_measure/model/home_info_data.dart';
import 'package:velocity_x/velocity_x.dart';

class Mystore extends VxStore {
  FirebaseLoginModel? firebaseLogindata;
  RoomInfoData? roomData;
//constructor ,We can also define them initially like done in above comments too
  Mystore() {
    firebaseLogindata = FirebaseLoginModel();
    roomData = RoomInfoData();
  }
}
