import 'package:flutter/painting.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void onDidRecieveNotifacation(NotificationResponse notificationResponse) async {
  // Your background task code here
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
