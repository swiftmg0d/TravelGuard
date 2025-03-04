import 'package:flutter/material.dart';

class ImageState with ChangeNotifier {
  String _startingImagePath = '';
  String _endingImagePath = '';

  String get startingImagePath => _startingImagePath;
  String get endingImagePath => _endingImagePath;

  void setStartingImagePath(String path) {
    _startingImagePath = path;
    notifyListeners();
  }

  void setEndingImagePath(String path) {
    _endingImagePath = path;
    notifyListeners();
  }
}
