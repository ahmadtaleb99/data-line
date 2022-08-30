part of 'submission_details_bloc.dart';

abstract class SubmissionDetailsEvent extends Equatable {
  const SubmissionDetailsEvent();
}


class FilePreviewRequested extends SubmissionDetailsEvent {
  final String filePath;

  const FilePreviewRequested({
    required this.filePath,
  });


  @override
  List<Object?> get props => [filePath];
}
