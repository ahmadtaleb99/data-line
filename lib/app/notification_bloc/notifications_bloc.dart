import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path/path.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/services/notification/NotificationManager.dart';import 'package:open_file/open_file.dart';

import '../../presentation/resources/strings_manager.dart';
import '../../services/notification/NotificationsService.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  final NotificationService _localNotificationService;


  static const String _stopDownload = '_stopDownload';
  static const String _newFilePath = '_newFilePath';

  NotificationsBloc(this._localNotificationService) : super(NotificationsInitial()) {
   _init();
   _onNotificationTapped();
          on<FileDownloadingNotificationEvent>(_onFileDownloadingNotificationEvent);
          on<FileDownloadedNotificationEvent>(_onFileDownloadedNotificationEvent);

  }


  void _init(){
    _localNotificationService.initNotifications();

  }


  void _onNotificationTapped(){


    _localNotificationService.actionStream.listen((ReceivedAction receivedAction) {


      switch(receivedAction.category){


        case NotificationCategory.LocalSharing:
             OpenFile.open(receivedAction.payload![_newFilePath]);
          break;

        case NotificationCategory.Navigation:
          break;
        case NotificationCategory.Progress:

          break;

      }
      });
  }


  Future<void> _onFileDownloadingNotificationEvent(
      FileDownloadingNotificationEvent event, Emitter<NotificationsState> emit) async {

    String fileName = basename(event.paylaod);
    AwesomeNotifications().createNotification(
        actionButtons: [
          NotificationActionButton(key: _stopDownload, label: AppStrings.stopDownload)
        ],
        content: NotificationContent(

            id:  0,
            channelKey: NotificationManager.filesChannel,
            title: '${AppStrings.downloading}: $fileName',
            body: event.progress.toString(),
            progress: event.progress,
            locked: true,
            notificationLayout: NotificationLayout.ProgressBar,
            category: NotificationCategory.Progress,payload:{_newFilePath : event.paylaod} ));
  }



  Future<void> _onFileDownloadedNotificationEvent(
      FileDownloadedNotificationEvent event, Emitter<NotificationsState> emit) async {

    String fileName = basename(event.paylaod);
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id:  0,
            channelKey: NotificationManager.filesChannel,
            title: ' ${AppStrings.downloadFileComplete} $fileName',
            body: ' ${AppStrings.tapToPreview}',
            bigPicture: 'file://${event.paylaod}',
            notificationLayout: NotificationLayout.BigPicture,
            category: NotificationCategory.LocalSharing,payload:{_newFilePath :  event.paylaod} ));
  }
}
