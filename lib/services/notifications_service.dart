import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/app_global.dart';
import 'package:travel_guard/dialogs/loading_dialog.dart';
import 'package:travel_guard/dialogs/destination_reached_dialog.dart';
import 'package:travel_guard/state/map_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';

Future<String> getApiKey() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ),
  );

  await remoteConfig.fetchAndActivate();

  return remoteConfig.getString('geoCodeAPIKEY');
}

Future<Map<String, dynamic>> doFetching() async {
  BuildContext? currentContext = AppGlobal.navigatorKey.currentState?.context;

  if (currentContext == null || !currentContext.mounted) {
    debugPrint("Context is not valid. Skipping fetching.");
    return {};
  }

  final mapState = Provider.of<MapState>(currentContext, listen: false);
  final apiKey = await getApiKey();

  final geoPointStart = mapState.customMarker?.startingPosition;
  final geoPointEnd = mapState.customMarker?.centarPoint;

  if (geoPointStart == null || geoPointEnd == null) {
    debugPrint("Invalid geolocation data");
    return {};
  }

  try {
    final startinGeoPointResponse = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${geoPointStart.latitude},${geoPointStart.longitude}&key=$apiKey'));
    final endinGeoPointResponse = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${geoPointEnd.latitude},${geoPointEnd.longitude}&key=$apiKey'));

    if (startinGeoPointResponse.statusCode == 200 && endinGeoPointResponse.statusCode == 200) {
      final startinAdress = jsonDecode(startinGeoPointResponse.body)['results'][1]['formatted_address'];
      final endinAdress = jsonDecode(endinGeoPointResponse.body)['results'][1]['formatted_address'];

      return {
        'startinAdress': startinAdress,
        'endinAdress': endinAdress,
      };
    }
  } catch (e) {
    debugPrint("Error fetching geolocation data: $e");
  }

  return {};
}

void onDidRecieveNotifacation(NotificationResponse notificationResponse) async {
  if (FirebaseAuth.instance.currentUser == null) {
    return;
  }

  BuildContext? currentContext = AppGlobal.navigatorKey.currentState?.context;

  if (currentContext == null || !currentContext.mounted) {
    debugPrint("Context is not valid. Skipping notification action.");
    return;
  }

  final mapState = Provider.of<MapState>(currentContext, listen: false);
  mapState.setSendNotifications(false);

  Future.delayed(Duration.zero, () {
    if (currentContext.mounted) {
      showDialog(
        context: currentContext,
        barrierDismissible: false,
        builder: (context) {
          return LoadingDialog(message: 'Getting the current location...');
        },
      );
    }
  });

  doFetching().then((value) {
    if (value.isNotEmpty) {
      final String startinLocation = value['startinAdress'];
      final String endinLocation = value['endinAdress'];

      if (currentContext.mounted) {
        Navigator.pop(currentContext);
        showDialog(
          context: currentContext,
          builder: (context) {
            return DestinationReachedDialog(
              startinLocation: startinLocation,
              endinLocation: endinLocation,
            );
          },
        );
      }
    } else {
      debugPrint('Error fetching data');
      MapState.resetConfig();
    }
  });

  debugPrint('Background task executed');
}

class NotificationsService {
  static final notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    final initAndroidSettings = AndroidInitializationSettings('app_icon');

    final initIOSSettings = DarwinInitializationSettings();

    final initSettings = InitializationSettings(
      android: initAndroidSettings,
      iOS: initIOSSettings,
    );

    await notificationsPlugin.initialize(
      initSettings,
      onDidReceiveBackgroundNotificationResponse: onDidRecieveNotifacation,
      onDidReceiveNotificationResponse: onDidRecieveNotifacation,
    );

    await notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channel_id', 'channel_name', channelDescription: 'channel_description', importance: Importance.max, priority: Priority.high, color: Color.fromARGB(0, 255, 255, 255), sound: RawResourceAndroidNotificationSound('notification_sound')),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({int id = 0, String? title, String? body}) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
