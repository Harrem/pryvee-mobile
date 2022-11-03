import 'package:pryvee/config/app_config.dart' as appConfig;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final darkTheme = ThemeData(
    fontFamily: 'Nunito',
    primaryColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
        primary: Colors.white,
        primaryContainer: Colors.white,
        secondary: appConfig.Colors().mainDarkColor(1),
        secondaryContainer: Colors.white,
        error: Colors.red,
        onError: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black,
        background: Colors.white,
        onBackground: Colors.black,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        brightness: Brightness.dark),
    hintColor: appConfig.Colors().secondDarkColor(1.0),
    focusColor: appConfig.Colors().accentDarkColor(0.8),
    textTheme: TextTheme(
        button: TextStyle(color: Colors.white),
        headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: appConfig.Colors().mainDarkColor(1)),
        headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: appConfig.Colors().secondDarkColor(1)),
        headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: appConfig.Colors().secondDarkColor(1)),
        headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: appConfig.Colors().secondDarkColor(1)),
        headline6: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: appConfig.Colors().mainDarkColor(1)),
        bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: appConfig.Colors().secondDarkColor(1)),
        bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: appConfig.Colors().secondDarkColor(1)),
        caption: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: appConfig.Colors().secondDarkColor(0.5))));
final lightTheme = ThemeData(
    fontFamily: 'Nunito',
    primaryColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme(
        primary: Colors.black,
        primaryContainer: Colors.black,
        secondary: appConfig.Colors().mainColor(1),
        secondaryContainer: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white,
        background: Colors.black,
        onBackground: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        brightness: Brightness.light),
    hintColor: appConfig.Colors().secondColor(1.0),
    focusColor: appConfig.Colors().accentColor(0.8),
    textTheme: TextTheme(
        button: TextStyle(color: Colors.white),
        headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: appConfig.Colors().mainColor(1)),
        headline1: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400, color: appConfig.Colors().secondColor(1)),
        headline3: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: appConfig.Colors().secondColor(1)),
        headline4: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: appConfig.Colors().secondColor(1)),
        headline6: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400, color: appConfig.Colors().mainColor(1)),
        bodyText2: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w400, color: appConfig.Colors().secondColor(1)),
        bodyText1: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: appConfig.Colors().secondColor(1)),
        caption: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w500, color: appConfig.Colors().secondColor(0.5))));
