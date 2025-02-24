import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/app_global.dart';
import 'package:travel_guard/services/markers_service.dart';
import 'package:travel_guard/state/map_state.dart';

void onDidRecieveNotifacation(NotificationResponse notificationResponse) async {
  if (FirebaseAuth.instance.currentUser == null) {
    return;
  }

  BuildContext currentContext = AppGlobal.navigatorKey.currentState!.context;
  final mapState = Provider.of<MapState>(currentContext, listen: false);
  mapState.setSendNotifications(false);

  showDialog(
      context: currentContext,
      builder: (currentContext) => AlertDialog(title: const Text('Notification'), content: const Text('You are in the radius of the infected person'), actions: [
            TextButton(
                onPressed: () async {
                  if (mapState.customMarker != null) {
                    await MarkersService.removeMarker(mapState.customMarker!);
                    await Provider.of<MapState>(currentContext, listen: false).controller.removeMarker(mapState.customMarker!.markerInfo.point);
                    await Provider.of<MapState>(currentContext, listen: false).controller.removeCircle(mapState.customMarker!.circleInfo.centerPoint.toString());

                    mapState.setInRadius(false);
                    mapState.setCustomMarker(null);
                    mapState.setSendNotifications(true);
                  }
                  Navigator.pop(currentContext);
                },
                child: const Text('Remove'))
          ]));

  print('Background task');
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
