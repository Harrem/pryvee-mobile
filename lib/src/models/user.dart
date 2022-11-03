import 'package:pryvee/src/models/address_model.dart';
import 'package:pryvee/data/data_source_const.dart';

class UserData {
  AddressModel addressModel;
  String maritalStatus;
  bool isEmailValid;
  String firstName;
  String updatedAt;
  String createdAt;
  String fullName;
  String lastName;
  String password;
  String picture;
  String userId;
  String gender;
  String email;
  String phone;
  UserData({
    this.maritalStatus,
    this.isEmailValid,
    this.addressModel,
    this.firstName,
    this.updatedAt,
    this.createdAt,
    this.fullName,
    this.lastName,
    this.password,
    this.picture,
    this.userId,
    this.gender,
    this.email,
    this.phone,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        fullName: (json['firstName'] != null && json['lastName'] != null)
            ? ("${json['firstName'].toString()} ${json['lastName'].toString()}")
            : "",
        maritalStatus: (json['maritalStatus'] == null)
            ? 'PREFER_NOT_TO_SAY'
            : json['maritalStatus'].toString().toUpperCase(),
        gender: (json['gender'] == null)
            ? 'PREFER_NOT_TO_SAY'
            : json['gender'].toString().toUpperCase(),
        addressModel: (json['address'] == null)
            ? null
            : AddressModel.fromJson(json['address']),
        picture: (json['picture'] == null)
            ? DEFAULT_USER_PICTURE
            : json['picture'].toString(),
        isEmailValid: (json['isEmailValid'] == null)
            ? false
            : json['isEmailValid'] as bool,
        firstName:
            (json['firstName'] == null) ? '' : json['firstName'].toString(),
        updatedAt:
            (json['updatedAt'] == null) ? '' : json['updatedAt'].toString(),
        createdAt:
            (json['createdAt'] == null) ? '' : json['createdAt'].toString(),
        lastName: (json['lastName'] == null) ? '' : json['lastName'].toString(),
        password: (json['password'] == null) ? '' : json['password'].toString(),
        userId: (json['userId'] == null) ? '' : json['userId'].toString(),
        email: (json['email'] == null) ? '' : json['email'].toString(),
        phone: (json['phone'] == null) ? '' : json['phone'].toString(),
      );
}
