import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunTextButtonWidget extends StatelessWidget {
  CommunTextButtonWidget({
    Key key,
    @required this.onPressed,
    @required this.color,
    @required this.shape,
    @required this.child,
  }) : super(key: key);
  void Function() onPressed;
  ShapeBorder shape;
  Widget child;
  Color color;
  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: this.onPressed,
          child: this.child,
          style: TextButton.styleFrom(
            backgroundColor: this.onPressed == null ? this.color.withOpacity(0.6) : this.color,
            textStyle: Theme.of(context).textTheme.bodyText1,
            padding: EdgeInsets.all(12.0),
            shape: this.shape,
          ),
        ),
      );
}
