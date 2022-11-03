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
}
