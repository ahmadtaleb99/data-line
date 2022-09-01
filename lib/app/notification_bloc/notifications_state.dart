part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {
  @override
  List<Object> get props => [];
}

class FileDownloadedNotification extends NotificationsState {
  @override
  List<Object> get props => [];
}

class FileDownloadingNotification extends NotificationsState {
  @override
  List<Object> get props => [];
}
