part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class FileDownloadingNotificationEvent extends NotificationsEvent{
  final String paylaod;
  final int progress;

  const FileDownloadingNotificationEvent({
    required this.paylaod,
    required this.progress,
  });

  @override
  List<Object?> get props => [paylaod,progress];
}


class FileDownloadedNotificationEvent extends NotificationsEvent{
  final String paylaod;

  const FileDownloadedNotificationEvent({
    required this.paylaod,
  });

  @override
  List<Object?> get props => [paylaod];
}
