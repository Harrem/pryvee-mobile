import 'package:flutter/material.dart';

class CommunSelectModel {
  String id = UniqueKey().toString();
  String name;
  bool selected;
  String key;
  CommunSelectModel(
    this.name,
    this.selected, {
    this.key,
  });
}
