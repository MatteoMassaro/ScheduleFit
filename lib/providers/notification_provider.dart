import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:schedule_fit/l10n/app_localizations.dart';
import 'package:schedule_fit/providers/stopwatch_provider.dart';

class NotificationProvider with ChangeNotifier {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  static bool _permissionsGranted = false;
  static bool _isStopActionPressed = false;
  static bool _isPauseResumeActionPressed = false;

  VoidCallback? _stopwatchListener;

  bool get permissionsGranted => _permissionsGranted;

  bool get isStopActionPressed => _isStopActionPressed;

  bool get isPauseResumeActionPressed => _isPauseResumeActionPressed;

  Future<void> init() async {
    if (!_isInitialized) {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/launcher_icon');
      const InitializationSettings initializationSettings =
          InitializationSettings(android: initializationSettingsAndroid);
      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          switch (response.actionId) {
            case 'stop_action':
              _isStopActionPressed = true;
              notifyListeners();
              break;
            case 'pause_resume_action':
              _isPauseResumeActionPressed = !_isPauseResumeActionPressed;
              notifyListeners();
              break;
          }
        },
      );

      await _createNotificationChannel();

      _isInitialized = true;
      _permissionsGranted = await _requestNotificationsPermissions() ?? false;
    }
  }

  /// Request Notifications Permissions
  Future<bool?> _requestNotificationsPermissions() async {
    bool notificationsPermissionsGranted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission() ??
        false;

    bool fullIntentNotificationsPermissionsGranted =
        await flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                    AndroidFlutterLocalNotificationsPlugin>()
                ?.requestFullScreenIntentPermission() ??
            false;

    bool exactAlarmsPermissionGranted = await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestExactAlarmsPermission() ??
        false;

    return notificationsPermissionsGranted &&
        fullIntentNotificationsPermissionsGranted &&
        exactAlarmsPermissionGranted;
  }

  /// Create Notification Channel
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

  /// Show Training Notification
  Future<void> showTrainingNotification(
      BuildContext context,
      String nomeEsercizio,
      String categoriaEsercizio,
      StopwatchProvider stopwatchProvider) async {
    if (!_permissionsGranted) return;

    int lastUpdatedSeconds = -1;

    if (_stopwatchListener != null) {
      stopwatchProvider.removeListener(_stopwatchListener!);
      _stopwatchListener = null;
    }

    _stopwatchListener = () async {
      int currentSeconds = stopwatchProvider.seconds;

      if (currentSeconds != lastUpdatedSeconds) {
        lastUpdatedSeconds = currentSeconds;

        String formattedCategoria =
            convertToUnderscoreFormat(categoriaEsercizio);
        String timeString = _formatTime(stopwatchProvider.milliseconds);

        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
          '1',
          'schedule_fit_notification_channel',
          channelDescription: 'Canale per notifiche ScheduleFit',
          importance: Importance.high,
          priority: Priority.high,
          ongoing: true,
          autoCancel: false,
          largeIcon: DrawableResourceAndroidBitmap(formattedCategoria),
          silent: true,
          subText: AppLocalizations.of(context)?.allenamentoInCorso ?? '',
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction(
              'pause_resume_action',
              stopwatchProvider.isRunning
                  ? AppLocalizations.of(context)?.sospendi ?? ''
                  : AppLocalizations.of(context)?.riprendi ?? '',
              showsUserInterface: true,
              cancelNotification: false,
            ),
            AndroidNotificationAction(
              'stop_action',
              AppLocalizations.of(context)?.termina ?? '',
              showsUserInterface: true,
              cancelNotification: true,
            ),
          ],
        );

        NotificationDetails notificationDetails =
            NotificationDetails(android: androidNotificationDetails);

        await flutterLocalNotificationsPlugin.show(
          1,
          nomeEsercizio,
          timeString,
          notificationDetails,
        );
      }
    };

    stopwatchProvider.addListener(_stopwatchListener!);
  }

  ///Update Training Notification
  updateTrainingNotification(BuildContext context, String nomeEsercizio,
      String categoriaEsercizio, StopwatchProvider stopwatchProvider) async {
    String formattedCategoria = convertToUnderscoreFormat(categoriaEsercizio);
    String timeString = _formatTime(stopwatchProvider.milliseconds);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '1',
      'schedule_fit_notification_channel',
      channelDescription: 'Canale per notifiche ScheduleFit',
      importance: Importance.high,
      priority: Priority.high,
      ongoing: true,
      autoCancel: false,
      largeIcon: DrawableResourceAndroidBitmap(formattedCategoria),
      silent: true,
      subText: AppLocalizations.of(context)?.allenamentoInCorso ?? '',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          'pause_resume_action',
          stopwatchProvider.isRunning
              ? AppLocalizations.of(context)?.sospendi ?? ''
              : AppLocalizations.of(context)?.riprendi ?? '',
          showsUserInterface: true,
          cancelNotification: false,
        ),
        AndroidNotificationAction(
          'stop_action',
          AppLocalizations.of(context)?.termina ?? '',
          showsUserInterface: true,
          cancelNotification: true,
        ),
      ],
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      1,
      nomeEsercizio,
      timeString,
      notificationDetails,
    );
  }

  /// Cancel Training Notification
  void cancelTrainingNotification(StopwatchProvider stopwatchProvider) {
    flutterLocalNotificationsPlugin.cancel(1);
    if (_stopwatchListener != null) {
      stopwatchProvider.removeListener(_stopwatchListener!);
      _stopwatchListener = null;
    }
  }

  /// Convert To Underscore Format
  String convertToUnderscoreFormat(String input) {
    return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
      return '${match.group(1)}_${match.group(2)!.toLowerCase()}';
    });
  }

  ///Format Time
  String _formatTime(int milliseconds) {
    int totalSeconds = milliseconds ~/ 1000;
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds ~/ 60) % 60;
    int hours = totalSeconds ~/ 3600;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
