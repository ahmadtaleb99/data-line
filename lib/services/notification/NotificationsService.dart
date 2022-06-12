import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
 static  StreamController<String> _streamController = StreamController();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

 static  Stream<String> get stream => _streamController.stream;
  static const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final MacOSInitializationSettings initializationSettingsMacOS =
      const MacOSInitializationSettings();

  Future<void> init() async {
    await _flutterLocalNotificationsPlugin.initialize(
        InitializationSettings(android: initializationSettingsAndroid),
        onSelectNotification: (payload) {
      _streamController.add(payload!);
    });
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

          ticker: 'ticker');

  static final NotificationDetails _platformChannelSpecifics =
      const NotificationDetails(android: _androidPlatformChannelSpecifics);

  static Future<void> showNotification(
      {required String title,
      required String body,
      void Function(String?)? onSelect,
      required String payload}) async {
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, _platformChannelSpecifics, payload: payload);
  }
    // Stream listen (){
    // return _streamController.stream;
    // }
}
