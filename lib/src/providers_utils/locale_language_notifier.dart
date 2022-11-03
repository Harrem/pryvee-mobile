import 'package:flutter/material.dart';

class LocaleLanguageNotifier with ChangeNotifier {
  Locale _localLocaleLanguage;
  LocaleLanguageNotifier(this._localLocaleLanguage);

  Locale getLocalLocaleLanguage() => _localLocaleLanguage;

  setLocalLocaleLanguage(Locale localLocaleLanguage) {
    this._localLocaleLanguage = localLocaleLanguage;
    notifyListeners();
  }
}
