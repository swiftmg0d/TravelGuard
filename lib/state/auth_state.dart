import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  bool isRegistered = false;
  bool isLogin = false;

  void register() {
    isRegistered = true;
    notifyListeners();
  }

  void unregister() {
    isRegistered = false;
    notifyListeners();
  }

  void login() {}
}
