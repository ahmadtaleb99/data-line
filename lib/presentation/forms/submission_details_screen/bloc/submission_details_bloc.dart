import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/services/io/FileCachingService.dart';
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
    // var mimi = lookupMimeType(cachedFile.path);

    await for (var event in _ioService.copyProgress) {
      progress = event.toInt();

    }
    AwesomeNotifications().createNotification(
        actionButtons: [
          NotificationActionButton(key: 'stopDownload', label: 'Stop Download')
        ],
        content: NotificationContent(

            id:  1,
            channelKey: 'second',
            title: 'downloading: $fileName',
            body: '$progress',
            progress: progress,
            locked: true,
            notificationLayout: NotificationLayout.ProgressBar,
            category: NotificationCategory.Progress,payload:{'value' : newFilePath!} ));
    print('first noti is done ');
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

    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id:  1,
            channelKey: 'second',
            title: ' download complete for file $fileName',
            body: ' tap to preview',
            bigPicture: 'file://$newFilePath',
            notificationLayout: NotificationLayout.BigPicture,
            category: NotificationCategory.Event,payload:{'value' : newFilePath} ));



  }

}
