import 'package:flutter/material.dart';

class MapState extends ChangeNotifier {
  bool isLoaded = false;

  void load() {
    isLoaded = true;
    notifyListeners();
  }

  void unload() {
    isLoaded = false;
    notifyListeners();
  }
}
