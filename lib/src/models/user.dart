// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/models/address_model.dart';
import 'package:pryvee/src/models/conversation.dart';

class UserData {
  AddressModel addressModel;
  String maritalStatus;
  bool isEmailValid;
  String uid;
  String nuid;
  String fullName;
  String firstName;
  String lastName;
  String createdAt;
  String updatedAt;
  String email;
  String gender;
  String phone;
  String birthDate;
  String picture;
  List<UserData> contacts;
  List<String> conversations;
  UserData(
      {this.addressModel,
      this.maritalStatus,
      this.isEmailValid,
      this.uid,
      this.nuid,
      this.fullName,
      this.firstName,
      this.lastName,
      this.createdAt,
      this.updatedAt,
      this.email,
      this.gender,
      this.phone,
      this.birthDate,
      this.picture,
      this.contacts,
      this.conversations});

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
        birthDate:
            (json['birthDate'] == null) ? '' : json['birthDate'].toString(),
        uid: (json['uid'] == null) ? '' : json['uid'].toString(),
        nuid: (json['nuid'] == null) ? '' : json['nuid'].toString(),
        email: (json['email'] == null) ? '' : json['email'].toString(),
        phone: (json['phone'] == null) ? '' : json['phone'].toString(),
        contacts: (json['contacts'] == null)
            ? []
            : (json['contacts'] as List<dynamic>)
                .map((e) => UserData.fromJson(e))
                .toList(),
        conversations: (((json['conversations'] == null)
                ? []
                : json['conversations'] as List<dynamic>)
            .map((e) => e.toString())
            .toList()),
      );

  UserData copyWith({
    AddressModel addressModel,
    String maritalStatus,
    bool isEmailValid,
    String uid,
    String nuid,
    String fullName,
    String firstName,
    String lastName,
    String createdAt,
    String updatedAt,
    String email,
    String gender,
    String phone,
    String birthDate,
    String picture,
    List<String> contacts,
    List<Conversation> conversations,
  }) {
    return UserData(
      addressModel: addressModel ?? this.addressModel,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      uid: uid ?? this.uid,
      nuid: nuid ?? this.nuid,
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      birthDate: birthDate ?? this.birthDate,
      picture: picture ?? this.picture,
      contacts: contacts ?? this.contacts,
      conversations: conversations ?? this.conversations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'addressModel': addressModel,
      'maritalStatus': maritalStatus,
      'isEmailValid': isEmailValid,
      'uid': uid,
      'nuid': nuid,
      'fullName': fullName,
      'firstName': firstName,
      'lastName': lastName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'email': email,
      'gender': gender,
      'phone': phone,
      'birthDate': birthDate,
      'picture': picture,
      'contacts': contacts.map((e) => e.toMap()).toList(),
      'conversations': conversations,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      addressModel:
          AddressModel.fromMap(map['addressModel'] as Map<String, dynamic>) ??
              AddressModel(),
      maritalStatus: map['maritalStatus'] as String,
      isEmailValid: map['isEmailValid'] as bool,
      uid: map['uid'] as String,
      nuid: map['nuid'] as String,
      fullName: map['fullName'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      phone: map['phone'] as String,
      birthDate: map['birthDate'] as String,
      picture: (map['picture'] as String) ?? DEFAULT_USER_PICTURE,
      contacts: List<UserData>.from(map['contacts'] as List<dynamic>),
      conversations: map['conversations'] as List<String>,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserData(addressModel: $addressModel, maritalStatus: $maritalStatus, isEmailValid: $isEmailValid, uid: $uid, fullName: $fullName, firstName: $firstName, lastName: $lastName, createdAt: $createdAt, updatedAt: $updatedAt, email: $email, gender: $gender, phone: $phone, birthDate: $birthDate, picture: $picture, contacts: $contacts)';
  }

  @override
  bool operator ==(covariant UserData other) {
    if (identical(this, other)) return true;

    return other.addressModel == addressModel &&
        other.maritalStatus == maritalStatus &&
        other.isEmailValid == isEmailValid &&
        other.uid == uid &&
        other.nuid == nuid &&
        other.fullName == fullName &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.email == email &&
        other.gender == gender &&
        other.phone == phone &&
        other.birthDate == birthDate &&
        other.picture == picture &&
        listEquals(other.contacts, contacts) &&
        listEquals(other.conversations, conversations);
  }

  @override
  int get hashCode {
    return addressModel.hashCode ^
        maritalStatus.hashCode ^
        isEmailValid.hashCode ^
        uid.hashCode ^
        nuid.hashCode ^
        fullName.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        birthDate.hashCode ^
        picture.hashCode ^
        contacts.hashCode ^
        conversations.hashCode;
  }
}
