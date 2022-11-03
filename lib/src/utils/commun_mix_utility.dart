import 'package:pryvee/data/data_source_const.dart';
import 'package:pryvee/src/utils/theme_utility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

bool isValidEmail(String string) => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(string);

bool isDouble(String string) => (string == null) ? false : double.tryParse(string) != null;

bool isInt(String string) => (string == null) ? false : int.tryParse(string) != null;

String getFormattedPrice(double value) => NumberFormat.currency(locale: "en_US", name: '\$', decimalDigits: 2).format(value);

String getStringThemeData(ThemeData themeData) => (themeData == darkTheme) ? "DARK" : "LIGHT";

String getCount(int count) => (count > 99) ? '99' : '$count';

String getStringCapitalized(String string) {
  if (string.isEmpty) return '';
  if (string.length == 1) return string.toUpperCase();
  return "${string.substring(0, 1).toUpperCase()}${string.substring(1, string.length).toLowerCase()}";
}

String getFormattedDouble(double value) {
  NumberFormat numberFormat = NumberFormat();
  numberFormat.minimumFractionDigits = 0;
  numberFormat.maximumFractionDigits = 2;
  return numberFormat.format(value);
}

List<String> getRolesListFromString(String string) {
  List<String> temp = [];
  string.split(",").asMap().forEach((key, value) => temp.add(value));
  return temp;
}

int getIntFromString(String string) => isInt(string) ? int.parse(string) : 0;

double getDoubleFromString(String string) => isDouble(string) ? double.parse(string) : 0.0;

ThemeData getThemeDataFromString(String string) => (string.toString().toUpperCase() == "DARK") ? darkTheme : lightTheme;

Locale getLocaleFromString(String string) => Locale(string.split("_").first.toLowerCase(), string.split("_").last.toUpperCase());

void exitTheFullScreen() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

void openTheKeyboard(BuildContext context, FocusNode focusNode) => FocusScope.of(context).requestFocus(focusNode);

void openUrl(String string) => launchUrl(Uri.parse(string), mode: LaunchMode.inAppWebView);

void setTheFullScreen() => SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

void closeTheKeyboard(BuildContext context) => FocusScope.of(context).unfocus();

void showToast(BuildContext context, String string, {int seconds}) {
  FToast fToast = FToast();
  fToast.init(context);
  fToast.showToast(
    toastDuration: Duration(seconds: seconds ?? 3),
    gravity: ToastGravity.TOP,
    child: Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: APP_COLOR,
      ),
      child: Text(
        string,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1.merge(
              TextStyle(
                color: Colors.white,
              ),
            ),
      ),
    ),
  );
}
