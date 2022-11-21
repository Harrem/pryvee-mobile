// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class AddressModel {
  String id = UniqueKey().toString();
  String postCode;
  String address;
  String country;
  String city;
  AddressModel({
    this.postCode,
    this.address,
    this.country,
    this.city,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        postCode: (json['postCode'] == null) ? '' : json['postCode'].toString(),
        address: (json['address'] == null) ? '' : json['address'].toString(),
        country: (json['country'] == null) ? '' : json['country'].toString(),
        city: (json['city'] == null) ? '' : json['city'].toString(),
      );

  AddressModel copyWith({
    String postCode,
    String address,
    String country,
    String city,
  }) {
    return AddressModel(
      postCode: postCode ?? this.postCode,
      address: address ?? this.address,
      country: country ?? this.country,
      city: city ?? this.city,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postCode': postCode,
      'address': address,
      'country': country,
      'city': city,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      postCode: map['postCode'] as String,
      address: map['address'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '$address, $city, $country';
  }

  @override
  bool operator ==(covariant AddressModel other) {
    if (identical(this, other)) return true;

    return other.postCode == postCode &&
        other.address == address &&
        other.country == country &&
        other.city == city;
  }

  @override
  int get hashCode {
    return postCode.hashCode ^
        address.hashCode ^
        country.hashCode ^
        city.hashCode;
  }
}
