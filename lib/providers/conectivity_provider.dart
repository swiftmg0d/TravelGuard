import 'package:flutter/material.dart';
import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class ConnectivityState with ChangeNotifier {
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;
  ConnectivityState() {
    _subscription = InternetConnection().onStatusChange.listen((status) {
      _connectionStatus = status;

      notifyListeners();
    });
  }

  InternetStatus? get connectionStatus => _connectionStatus;

  bool? getStatus() {
    if (_connectionStatus == InternetStatus.connected) {
      debugPrint('Connected to network');
      return true;
    } else if (_connectionStatus == InternetStatus.disconnected) {
      debugPrint('No network connection');
      return false;
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
