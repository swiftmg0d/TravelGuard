import 'package:flutter/material.dart';
import 'package:travel_guard/models/user.dart';

class AuthState extends ChangeNotifier {
  bool _isAuthenticated = false;
  final List<User> _users = [
    User("admin", "admin")
  ];
  User? _user;

  User? get user => _user;

  bool get isAuthenticated => _isAuthenticated;

  void login(String email, String password) {
    if (_users.any((user) => user.email == email && user.password == password)) {
      _isAuthenticated = true;
      _user = _users.firstWhere((user) => user.email == email && user.password == password);
    } else {
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  void register(String email, String password) {
    _users.add(User(email, password));
    _isAuthenticated = true;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    _user = null;
    notifyListeners();
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }
}
