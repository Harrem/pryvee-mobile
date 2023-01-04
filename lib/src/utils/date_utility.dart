import 'package:pryvee/src/providers_utils/locale_language_notifier.dart';
import 'package:pryvee/src/utils/navigation_service.dart';
import 'package:pryvee/src/utils/locator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'commun_mix_utility.dart';
import 'package:intl/intl.dart';

String getYMMMMEEEEd(String value) {
  NavigationService navigationService = locator<NavigationService>();
  BuildContext context = navigationService.navigatorKey.currentContext;
  return getStringCapitalized(DateFormat.yMMMMEEEEd(
          Provider.of<LocaleLanguageNotifier>(context)
              .getLocalLocaleLanguage()
              .languageCode)
      .format(DateTime.parse(value)));
}

String getYMEd(String value) {
  NavigationService navigationService = locator<NavigationService>();
  BuildContext context = navigationService.navigatorKey.currentContext;
  return getStringCapitalized(DateFormat.yMEd(
          Provider.of<LocaleLanguageNotifier>(context)
              .getLocalLocaleLanguage()
              .languageCode)
      .format(DateTime.parse(value)));
}

String getJm(String value) => DateFormat.jm().format(getDateFromString(value));

DateTime getDateFromString(String value) =>
    DateTime.fromMicrosecondsSinceEpoch(int.parse(value));

String getEEEE(String date) {
  NavigationService navigationService = locator<NavigationService>();
  BuildContext context = navigationService.navigatorKey.currentContext;
  return getStringCapitalized(DateFormat.EEEE(
          Provider.of<LocaleLanguageNotifier>(context)
              .getLocalLocaleLanguage()
              .languageCode)
      .format(getDateFromString(date)));
}

String getMMM(String date) {
  NavigationService navigationService = locator<NavigationService>();
  BuildContext context = navigationService.navigatorKey.currentContext;
  return getStringCapitalized(DateFormat.MMM(
          Provider.of<LocaleLanguageNotifier>(context)
              .getLocalLocaleLanguage()
              .languageCode)
      .format(getDateFromString(date)));
}

String getDateFormetted(DateTime dateTime) {
  var duration = DateTime.now().difference(dateTime);
  if (duration.inHours <= 24) {
    return DateFormat.Hm().format(dateTime);
  } else if (duration.inHours > 24 && duration.inDays <= 7) {
    return DateFormat.E().format(dateTime);
  } else if (duration.inDays > 7 && duration.inDays < 31) {
    return DateFormat.MMMd().format(dateTime);
  } else {
    return DateFormat.yMMMd().format(dateTime);
  }
}

bool isCurrrentDay(String value) =>
    value.toLowerCase() == getEEEE(DateTime.now().toString()).toLowerCase();
