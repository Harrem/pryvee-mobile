import 'package:flutter/material.dart';

class SessionNotifier with ChangeNotifier {
  String _localUserId;

  SessionNotifier(this._localUserId);

  String getLocalUserId() => _localUserId;

  setLocalUserId(String localUserId) {
    this._localUserId = localUserId;
    notifyListeners();
  }
}
