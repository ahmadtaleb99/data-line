import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationManager {


static  List<NotificationChannel> channels =   [
    NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'first',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white)
  ];
}

