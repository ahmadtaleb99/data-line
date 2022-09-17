import 'package:equatable/equatable.dart';

class SyncFormProgress extends Equatable {
  final int submissionsChunksProgress;
  final bool requiresUploadProgress;
  final int submissionUploadProgress;

  const SyncFormProgress({
    required this.submissionsChunksProgress,
    required this.submissionUploadProgress,
    required this.requiresUploadProgress,
  });


  @override
  List<Object?> get props => [submissionsChunksProgress, submissionUploadProgress,requiresUploadProgress];

  SyncFormProgress copyWith({
    int? submissionsChunksProgress,
    int? submissionSyncPercent,
    bool? requiresUploadProgress,
  }) {
    return SyncFormProgress(
      submissionsChunksProgress:
          submissionsChunksProgress ?? this.submissionsChunksProgress,
      submissionUploadProgress:
          submissionSyncPercent ?? this.submissionUploadProgress,
      requiresUploadProgress:
      requiresUploadProgress ?? this.requiresUploadProgress,
    );
  }
}
