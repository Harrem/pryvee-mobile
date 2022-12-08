import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool isLoading = false;

  void start() {
    isLoading = true;
    notifyListeners();
  }

  void stop() {
    isLoading = false;
    notifyListeners();
  }
}
