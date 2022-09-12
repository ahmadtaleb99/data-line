import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/app/notification_bloc/notifications_bloc.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/services/io/FileCachingService.dart';
import 'package:datalines/services/notification/NotificationManager.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


part 'submission_details_event.dart';
part 'submission_details_state.dart';

class SubmissionDetailsBloc extends Bloc<SubmissionDetailsEvent, SubmissionDetailsState> {
  final _ioService = getIt<FileCachingService>();
  int prog = 0;
  SubmissionDetailsBloc() : super(SubmissionDetailsState(fileDownloadProgress: {})) {



    on<FilePreviewRequested>(_onFilePreviewRequested);
  }

  Future<void> _onFilePreviewRequested(
      FilePreviewRequested event, Emitter<SubmissionDetailsState> emit) async {
    File cachedFile = File(event.filePath);
    if(!await cachedFile.exists()) {
      log('file dosnt exist ');
     return;
    }
    String fileName = basename(cachedFile.path);
    String ?  newFilePath = await _ioService.copyToDownloads(cachedFile);

    int progress  = 0 ;

    Map<String,double> map = Map.from(state.fileDownloadProgress);

    //show progress notification if file is large
    if( await cachedFile.length() / 1000000 > 20) {

      await for (var progress in _ioService.copyProgress) {

        int intProgress = progress.toInt();
        map[event.filePath] = progress;
        emit(state.copyWith(fileDownloadProgress: Map.from(map)));
      }
      map[event.filePath] = -1;
      emit(state.copyWith(fileDownloadProgress: Map.from(map)));


      getIt<NotificationsBloc>().add(FileDownloadedNotificationEvent(paylaod: newFilePath.toString()));


    }

    getIt<NotificationsBloc>().add(FileDownloadedNotificationEvent(paylaod: newFilePath.toString()));



  }
@override
  Future<void> close() {
  log('******* bloc closed submission details bloc  *********');
  _ioService.dispose();
    return super.close();
  }
}
