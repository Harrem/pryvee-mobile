import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomInkWell extends StatelessWidget {
  CustomInkWell({Key key, @required this.child, @required this.onTap, this.onLongPress, this.onDoubleTap}) : super(key: key);
  Widget child;
  void Function() onTap;
  void Function() onLongPress;
  void Function() onDoubleTap;
  @override
  Widget build(BuildContext context) => InkWell(
      focusColor: Colors.transparent, highlightColor: Colors.transparent, hoverColor: Colors.transparent, splashColor: Colors.transparent, onLongPress: this.onLongPress ?? null, onDoubleTap: this.onDoubleTap ?? null, onTap: this.onTap, child: child);
}
