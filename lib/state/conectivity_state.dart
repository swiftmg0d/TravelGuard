import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/app_global.dart';

class ConnectivityProvider with ChangeNotifier {
  InternetStatus? _connectionStatus;
  late StreamSubscription<InternetStatus> _subscription;
  ConnectivityProvider() {
    _subscription = InternetConnection().onStatusChange.listen((status) {
      _connectionStatus = status;
      if (status == InternetStatus.connected) {
      } else if (status == InternetStatus.disconnected) {
        String? currentRoute = ModalRoute.of(AppGlobal.navigatorKey.currentContext!)?.settings.name;
        if (currentRoute == '/error') return;

        Provider.of(AppGlobal.navigatorKey.currentContext!, listen: false).pushReplacementNamed('/error', arguments: currentRoute);

        debugPrint('No network connection');
      }
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
