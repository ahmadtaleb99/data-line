import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/app/notification_bloc/notifications_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/services/io/FileCachingService.dart';
import 'package:form_builder_test/services/notification/NotificationManager.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'submission_details_event.dart';
part 'submission_details_state.dart';

class SubmissionDetailsBloc extends Bloc<SubmissionDetailsEvent, SubmissionDetailsState> {
  final _ioService = getIT<FileCachingService>();
  SubmissionDetailsBloc() : super(SubmissionDetailsState()) {




    on<FilePreviewRequested>(_onFilePreviewRequested);
  }

  Future<void> _onFilePreviewRequested(
      FilePreviewRequested event, Emitter<SubmissionDetailsState> emit) async {
    File cachedFile = File(event.filePath);
    String fileName = basename(cachedFile.path);
    String ?  newFilePath = await _ioService.copyToDownloads(cachedFile);

    int progress  = 0 ;
    if( await cachedFile.length() / 1000000 > 50) {
      await for (var event in _ioService.copyProgress) {
        log('progress');
        progress = event.toInt();

      }
    }
    getIT<NotificationsBloc>().add(FileDownloadingNotificationEvent(
        paylaod: newFilePath.toString(), progress: progress));


    getIT<NotificationsBloc>().add(FileDownloadedNotificationEvent(paylaod: newFilePath.toString()));

    // AwesomeNotifications().createNotification(
    //     actionButtons: [
    //       NotificationActionButton(key: _stopDownload, label: AppStrings.stopDownload)
    //     ],
    //     content: NotificationContent(
    //
    //         id:  1,
    //         channelKey: NotificationManager.filesChannel,
    //         title: '${AppStrings.downloading}: $fileName',
    //         body: '$progress',
    //         progress: progress,
    //         locked: true,
    //         notificationLayout: NotificationLayout.ProgressBar,
    //         category: NotificationCategory.Progress,payload:{'value' : newFilePath!} ));
    // if (mimi != defaultExtensionMap['jpg']){
    //   print(mimi);
    //   kza =     await AwesomeNotifications().createNotification(
    //       content: NotificationContent(
    //           id:  1,
    //           channelKey: 'second',
    //           title: ' download complete for file $fileName',
    //           body: ' tap to preview',
    //           notificationLayout: NotificationLayout.Default,
    //           category: NotificationCategory.Event,payload:{'value' : newFilePath} ));
    //   AwesomeNotifications().createNotification(
    //       content: NotificationContent(
    //           id:  8,
    //           channelKey: 'second',
    //           title: ' download complete for file',
    //           body: ' tap to preview',
    //           category: NotificationCategory.Event,payload:{'value' : newFilePath} ));
    //   print('second note should be done :: $kza');
    // }

    // await AwesomeNotifications().createNotification(
    //     content: NotificationContent(
    //         id:  1,
    //         channelKey: NotificationManager.filesChannel,
    //         title: ' ${AppStrings.downloadFileComplete} $fileName',
    //         body: ' ${AppStrings.tapToPreview}',
    //         bigPicture: 'file://$newFilePath',
    //         notificationLayout: NotificationLayout.BigPicture,
    //         category: NotificationCategory.LocalSharing,payload:{'value' : newFilePath} ));



  }
@override
  Future<void> close() {
  log('******* bloc closed submission details bloc  *********');

  _ioService.dispose();
    return super.close();
  }
}
