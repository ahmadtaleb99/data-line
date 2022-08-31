import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class NotificationManager {

    static const String filesChannel = 'filesChannel';
    static const String basicChannel = 'basicChannel';
static  List<NotificationChannel> channels =   [
    NotificationChannel(
        channelGroupKey: filesChannel,
        channelKey: filesChannel,
        channelName: AppStrings.fileChannel,
        channelDescription: AppStrings.fileChannelDescription,
        importance: NotificationImportance.Max,

        ledColor: Colors.white),  NotificationChannel(
        channelGroupKey: basicChannel,
        channelKey: basicChannel,
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        importance: NotificationImportance.Max,

        ledColor: Colors.white),

  ];
}

