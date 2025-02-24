import 'package:flutter/material.dart';

class MapState extends ChangeNotifier {
  bool isLoaded = false;
  bool inRadius = false;
  bool sendNotifications = false;

  void load() {
    isLoaded = true;
    notifyListeners();
  }

  void unload() {
    isLoaded = false;
    notifyListeners();
  }

  void setInRadius(bool value) {
    inRadius = value;
    notifyListeners();
  }

  void setSendNotifications(bool value) {
    sendNotifications = value;
    notifyListeners();
  }
}
