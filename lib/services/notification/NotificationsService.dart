import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:form_builder_test/services/notification/NotificationManager.dart';

class NotificationService {
      final _awesomeNotifications =   AwesomeNotifications();

  void initNotifications() {
    _awesomeNotifications.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        _awesomeNotifications.requestPermissionToSendNotifications();
      }
    });
    _awesomeNotifications.initialize(
      // senullt the icon to null if you want to use the default app icon
        null,
        NotificationManager.channels,
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupkey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: false
    );
  }



      Stream<ReceivedAction> get actionStream => _awesomeNotifications.actionStream;
      Stream<ReceivedAction> get dismissedStream => _awesomeNotifications.dismissedStream;
      Stream<ReceivedNotification> get createdStream => _awesomeNotifications.createdStream;
      Stream<ReceivedNotification> get displayedStream => _awesomeNotifications.displayedStream;

}
