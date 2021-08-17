import 'dart:convert';

import 'package:flutter/material.dart';

// class HoomeDataModel {
//   UserInfoModel userInfoModel;
//   SwitchInfoModel switchInfoModel;
//   HoomeDataModel({
//     required this.userInfoModel,
//     required this.switchInfoModel,
//   });
// }

class UserInfoModel //User data model
{
  Image userImage;
  String userName;
  UserInfoModel({
    required this.userImage,
    required this.userName,
  });
}

class RoomInfoModel {
  String roomName;
  List<SwitchInfoModel>? switchesInfoModel;
  RoomInfoModel({
    this.switchesInfoModel,
    required this.roomName,
  });

  void addSwitch(SwitchInfoModel switchInfoModel) {
    switchesInfoModel!.add(switchInfoModel);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': roomName,
      'switchesInfoModel': switchesInfoModel!.map((x) => x.toMap()).toList(),
    };
  }

  factory RoomInfoModel.fromMap(Map<dynamic, dynamic> map) {
    return RoomInfoModel(
      roomName: map[""][""],
      switchesInfoModel: List<SwitchInfoModel>.from(
          map['Devices']?.map((x) => SwitchInfoModel.fromMap(x))),
    );
  }

//   factory RoomInfoModel.fromJson(Map<String, dynamic> json) {
//  List<Recording> recList = [];

//  List<dynamic>.from(json['recordings']).forEach((content) {
//       Recording recording = Recording.fromJson(jsonDecode(jsonEncode(content)));
//       recList.add(recording);
//    });
//  return new LocationRecordings(recordings: recList, state: json['state']);
// }

  String toJson() => json.encode(toMap());

  factory RoomInfoModel.fromJson(String source) =>
      RoomInfoModel.fromMap(json.decode(source));
}

class SwitchInfoModel {
  bool isActive;
  String switchName;
  IconData iconData;
  SwitchInfoModel({
    this.isActive = false,
    required this.switchName,
    required this.iconData,
  });
  void switchToggle() {
    isActive = !isActive;
  }

  Map<String, dynamic> toMap() {
    return {
      'isActive': isActive,
      'name': switchName,
      'iconData': iconData.codePoint,
    };
  }

  factory SwitchInfoModel.fromMap(Map<String, dynamic> map) {
    return SwitchInfoModel(
      isActive: map['isActive'],
      switchName: map['name'],
      iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
    );
  }

  String toJson() => json.encode(toMap());

  factory SwitchInfoModel.fromJson(String source) =>
      SwitchInfoModel.fromMap(json.decode(source));
}
