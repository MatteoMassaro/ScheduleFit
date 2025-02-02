import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider with ChangeNotifier {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  static int _notificationId = 0;
  static bool _permissionsGranted = false;

  bool get permissionsGranted => _permissionsGranted;

  Future<void> init() async {
    if (!_isInitialized) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/launcher_icon');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      await _createNotificationChannel();

      _isInitialized = true;
      _permissionsGranted = await _requestNotificationsPermissions() ?? false;
    }
  }

  Future<bool?> _requestNotificationsPermissions() async {
    bool notificationsPermissionsGranted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;

    bool exactAlarmsPermissionGranted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;

    return notificationsPermissionsGranted && exactAlarmsPermissionGranted;
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      '1',
      'schedule_fit_notification_channel',
      description: 'Canale per notifiche ScheduleFit',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> showNotification(String title, String body) async {
    if (_permissionsGranted == true) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        '1',
        'schedule_fit_notification_channel',
        channelDescription: 'Canale per notifiche ScheduleFit',
        importance: Importance.high,
        priority: Priority.high,
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      _notificationId++;

      await flutterLocalNotificationsPlugin.show(
        _notificationId,
        title,
        body,
        platformChannelSpecifics,
      );
    }
  }
}
