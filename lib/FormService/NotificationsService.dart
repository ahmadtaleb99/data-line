import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final MacOSInitializationSettings initializationSettingsMacOS =
      const MacOSInitializationSettings();


 static Future <void> init() async {
    await _flutterLocalNotificationsPlugin.initialize( InitializationSettings(android: initializationSettingsAndroid),
        onSelectNotification: _onSelectNotification);
  }

  static void _onSelectNotification(String? payload) {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  static const AndroidNotificationDetails _androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your channel id', 'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          showProgress: true,
          maxProgress: 24,
          ticker: 'ticker');

  static final NotificationDetails _platformChannelSpecifics =
      const NotificationDetails(android: _androidPlatformChannelSpecifics);

  static Future<void> showNotification(
      {required String title,
      required String body,
      required String payload}) async {
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, _platformChannelSpecifics, payload: payload);
  }
}


