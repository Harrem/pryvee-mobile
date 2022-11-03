import 'package:pryvee/src/widgets/shared_inside/CustomInkWell.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommunChipWidget extends StatelessWidget {
  CommunChipWidget({
    Key key,
    @required this.borderRadiusGeometry,
    @required this.edgeInsetsGeometry,
    this.marginEdgeInsetsGeometry,
    @required this.color,
    this.onLongPress,
    this.textStyle,
    this.boxShadow,
    this.boxBorder,
    this.gradient,
    this.string,
    this.height,
    this.onTap,
    this.child,
    this.width,
  }) : super(key: key);
  EdgeInsetsGeometry marginEdgeInsetsGeometry;
  BorderRadiusGeometry borderRadiusGeometry;
  EdgeInsetsGeometry edgeInsetsGeometry;
  void Function() onLongPress;
  List<BoxShadow> boxShadow;
  void Function() onTap;
  TextStyle textStyle;
  BoxBorder boxBorder;
  Gradient gradient;
  double height;
  String string;
  Widget child;
  double width;
  Color color;

  @override
  Widget build(BuildContext context) => (this.onTap != null)
      ? CustomInkWell(onTap: this.onTap, child: communChipWidget())
      : (this.onLongPress is void Function())
          ? CustomInkWell(onTap: this.onTap, child: communChipWidget())
          : communChipWidget();

  Widget communChipWidget() => Container(
        height: this.height ?? null,
        width: this.width ?? null,
        padding: this.edgeInsetsGeometry,
        margin: this.marginEdgeInsetsGeometry ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          border: this.boxBorder ?? null,
          boxShadow: this.boxShadow ?? [],
          color: this.color,
          gradient: this.gradient ?? null,
          borderRadius: this.borderRadiusGeometry,
        ),
        child: child ??
            Text(
              this.string,
              textAlign: TextAlign.center,
              style: this.textStyle,
            ),
      );
}
