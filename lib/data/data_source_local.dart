import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pryvee/src/providers_utils/locale_language_notifier.dart';
import 'package:pryvee/src/providers_utils/session_notifier.dart';
import 'package:pryvee/src/providers_utils/theme_notifier.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pryvee/src/providers_utils/user_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pryvee/src/utils/theme_utility.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

getLocalThemeFromSP() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("localTheme");
}

void addLocalThemeToSP(String localTheme) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("localTheme", localTheme);
}

getLocalUserIdFromSP() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("localUserId");
}

void addLocalUserIdToSP(String localUserId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("localUserId", localUserId);
}

getLocalEmailFromSP() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("localEmail");
}

void addLocalEmailToSP(String localEmail) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("localEmail", localEmail);
}

getLocalLocaleLanguageFromSP() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  return sharedPreferences.getString("localLocaleLanguage");
}

void addLocalLocaleLanguageToSP(String localLocaleLanguage) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("localLocaleLanguage", localLocaleLanguage);
}

void addOneSignalUserId(String nuid) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("nuid", nuid);
}

Future<String> getOneSignalUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs.getString('nuid');
  return stringValue;
}

Future<LatLng> getLocalLocationFromSP() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String string = sharedPreferences.getString("localLocation");
  return (string == null)
      ? LatLng(0.0, 0.0)
      : LatLng(double.parse(string.split("_").first),
          double.parse(string.split("_").last));
}

void addLocalLocationToSP(String localLocation) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("localLocation", localLocation);
}

void clearSharedPrefs() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
}

void clearSharedPrefsByKey(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.remove(key);
}

Future<void> pryveeSignOut(BuildContext context) async {
  context.read<UserProvider>().updateUserDataWithMap({'nuid': null});
  await AwesomeNotifications().cancelAll();
  FirebaseAuth.instance.signOut();
  // Provider.of<LocaleLanguageNotifier>(context, listen: false)
  //     .setLocalLocaleLanguage(Locale("fr", "FR"));
  // Provider.of<ThemeNotifier>(context, listen: false).setLocalTheme(lightTheme);
  // Provider.of<SessionNotifier>(context, listen: false).setLocalUserId("");
  clearSharedPrefs();
  Provider.of<UserProvider>(context, listen: false).signOut();
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  return;
}
