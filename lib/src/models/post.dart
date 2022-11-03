import 'package:pryvee/src/utils/commun_mix_utility.dart';
import 'package:pryvee/src/models/address_model.dart';
import 'package:pryvee/src/utils/date_utility.dart';
import 'package:pryvee/src/models/user.dart';

class Post {
  AddressModel datingAddress;
  String currentUserEmail;
  String trustedUserEmail;
  String carPlateNumber;
  DateTime dateTime;
  int checkInterval;
  String updatedAt;
  String createdAt;
  String transport;
  UserData datingUser;
  Post({
    this.currentUserEmail,
    this.trustedUserEmail,
    this.carPlateNumber,
    this.datingAddress,
    this.checkInterval,
    this.datingUser,
    this.createdAt,
    this.updatedAt,
    this.transport,
    this.dateTime,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        checkInterval: (json['checkInterval'] == null)
            ? 0
            : getIntFromString(json['checkInterval'].toString()),
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
        datingUser: (json['datingUser'] == null)
            ? null
            : UserData.fromJson(json['datingUser']),
        updatedAt:
            (json['updatedAt'] == null) ? '' : json['updatedAt'].toString(),
        createdAt:
            (json['createdAt'] == null) ? '' : json['createdAt'].toString(),
        transport:
            (json['transport'] == null) ? '' : json['transport'].toString(),
      );
}
