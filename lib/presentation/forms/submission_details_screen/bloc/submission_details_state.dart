part of 'submission_details_bloc.dart';



class SubmissionDetailsState extends Equatable {

 final  Map<String,double> fileDownloadProgress;
  @override
  List<Object?> get props => [fileDownloadProgress];

  const SubmissionDetailsState({
    required  this.fileDownloadProgress,
  });

  SubmissionDetailsState copyWith({
    Map<String, double>? fileDownloadProgress,
  }) {
    return SubmissionDetailsState(
      fileDownloadProgress: fileDownloadProgress ?? this.fileDownloadProgress,
    );
  }
}
