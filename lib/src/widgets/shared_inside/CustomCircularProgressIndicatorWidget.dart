import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pryvee/data/data_source_const.dart';
import 'dart:io';

// ignore: must_be_immutable
class CustomCircularProgressIndicatorWidget extends StatelessWidget {
  CustomCircularProgressIndicatorWidget({Key key, @required this.alignmentGeometry, @required this.edgeInsetsGeometry}) : super(key: key);
  AlignmentGeometry alignmentGeometry;
  EdgeInsetsGeometry edgeInsetsGeometry;

  @override
  Widget build(BuildContext context) => Align(
        alignment: this.alignmentGeometry,
        child: Padding(
          padding: this.edgeInsetsGeometry,
          child: SizedBox(
            width: 20.0,
            height: 20.0,
            child: (Platform.isIOS)
                ? CupertinoActivityIndicator(animating: true)
                : CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(APP_COLOR),
                    backgroundColor: Theme.of(context).focusColor.withOpacity(0.5),
                    strokeWidth: 1.0,
                  ),
          ),
        ),
      );
}
