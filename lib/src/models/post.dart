// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pryvee/src/models/address_model.dart';
import 'package:pryvee/src/utils/date_utility.dart';

class Post {
  int notificationId;
  String pid;
  bool isLive;
  AddressModel datingAddress;
  String currentUserEmail;
  String trustedUserEmail;
  String carPlateNumber;
  DateTime dateTime;
  int checkInterval;
  int updatedAt;
  int createdAt;
  String transport;
  String fullName;
  String phoneNumber;
  String pictureUrl;
  String trustedUid;
  Post(
      {this.notificationId,
      this.pid,
      this.isLive,
      this.currentUserEmail,
      this.trustedUserEmail,
      this.carPlateNumber,
      this.datingAddress,
      this.checkInterval,
      this.createdAt,
      this.updatedAt,
      this.transport,
      this.dateTime,
      this.fullName,
      this.phoneNumber,
      this.pictureUrl,
      this.trustedUid});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        notificationId: (json['id'] == null) ? 0 : json['id'] as int,
        pid: (json['pid'] == null) ? "" : json['pid'].toString(),
        isLive: (json['id'] == null) ? false : json['isLive'] as bool,
        checkInterval:
            (json['checkInterval'] == null) ? 0 : json['checkInterval'] as int,
        datingAddress: (json['datingAddress'] == null)
            ? null
            : AddressModel.fromJson(json['datingAddress']),
        currentUserEmail: (json['currentUserEmail'] == null)
            ? ''
            : json['currentUserEmail'].toString(),
        trustedUserEmail: (json['trustedUserEmail'] == null)
            ? ''
            : json['trustedUserEmail'].toString(),
        dateTime: (json['dateTime'] == null)
            ? null
            : getDateFromString(json['dateTime'].toString()),
        carPlateNumber: (json['carPlateNumber'] == null)
            ? ''
            : json['carPlateNumber'].toString(),
        updatedAt: (json['updatedAt'] == null) ? 0 : json['updatedAt'] as int,
        createdAt: (json['createdAt'] == null) ? 0 : json['createdAt'] as int,
        transport:
            (json['transport'] == null) ? '' : json['transport'].toString(),
        fullName: (json['fullName'] == null) ? '' : json['fullName'].toString(),
        phoneNumber:
            (json['phoneNumber'] == null) ? '' : json['phoneNumber'].toString(),
        pictureUrl:
            (json['pictureUrl'] == null) ? '' : json['pictureUrl'].toString(),
        trustedUid:
            (json['trustedUid'] == null) ? '' : json['trustedUid'].toString(),
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': notificationId,
      'pid': pid,
      'isLive': isLive,
      'datingAddress': datingAddress.toMap(),
      'currentUserEmail': currentUserEmail,
      'trustedUserEmail': trustedUserEmail,
      'carPlateNumber': carPlateNumber,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'checkInterval': checkInterval,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'transport': transport,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'pictureUrl': pictureUrl,
      'trustedUid': trustedUid,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      notificationId: map['id'] as int,
      pid: map['pid'].toString(),
      isLive: map['isLive'] as bool,
      datingAddress:
          AddressModel.fromMap(map['datingAddress'] as Map<String, dynamic>),
      currentUserEmail: map['currentUserEmail'] as String,
      trustedUserEmail: map['trustedUserEmail'] as String,
      carPlateNumber: map['carPlateNumber'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      checkInterval: map['checkInterval'] as int,
      updatedAt: map['updatedAt'] as int,
      createdAt: map['createdAt'] as int,
      transport: map['transport'] as String,
      fullName: map['fullName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      pictureUrl: map['pictureUrl'] as String,
      trustedUid: map['trustedUid'] as String,
    );
  }

  String toJson() => json.encode(toMap());
}
