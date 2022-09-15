import 'package:equatable/equatable.dart';

class SyncFormProgress extends Equatable {
  final int submissionsChunksProgress;
  final int submissionSyncPercent;

  const SyncFormProgress({
    required this.submissionsChunksProgress,
    required this.submissionSyncPercent,
  });

  @override
  List<Object?> get props => [submissionsChunksProgress, submissionSyncPercent];

  SyncFormProgress copyWith({
    int? submissionsChunksProgress,
    int? submissionSyncPercent,
  }) {
    return SyncFormProgress(
      submissionsChunksProgress:
          submissionsChunksProgress ?? this.submissionsChunksProgress,
      submissionSyncPercent:
          submissionSyncPercent ?? this.submissionSyncPercent,
    );
  }
}
