import 'package:flutter/material.dart';

class App {
  BuildContext context;
  double height;
  double width;
  double heightPadding;
  double widthPadding;

  App(context) {
    this.context = context;
    MediaQueryData queryData = MediaQuery.of(this.context);
    height = (queryData.size.height / 100.0);
    width = (queryData.size.width / 100.0);
    heightPadding =
        height - ((queryData.padding.top + queryData.padding.bottom) / 100.0);
    widthPadding =
        width - (queryData.padding.left + queryData.padding.right) / 100.0;
  }

  double appHeight(double v) => height * v;

  double appWidth(double v) => width * v;

  double appVerticalPadding(double v) => heightPadding * v;

  double appHorizontalPadding(double v) => widthPadding * v;
}

class Colors {
  Color _mainColor = Color(0xFF000000);
  Color _secondColor = Color(0xFF000000);
  Color _accentColor = Color(0xFEEEEEEE);

  Color _mainDarkColor = Color(0xFFFFFFFF);
  Color _secondDarkColor = Color(0xFFFFFFFF);
  Color _accentDarkColor = Color(0xFF212121);

  Color mainColor(double opacity) => this._mainColor.withOpacity(opacity);

  Color secondColor(double opacity) => this._secondColor.withOpacity(opacity);

  Color accentColor(double opacity) => this._accentColor.withOpacity(opacity);

  Color mainDarkColor(double opacity) =>
      this._mainDarkColor.withOpacity(opacity);

  Color secondDarkColor(double opacity) =>
      this._secondDarkColor.withOpacity(opacity);

  Color accentDarkColor(double opacity) =>
      this._accentDarkColor.withOpacity(opacity);
}
