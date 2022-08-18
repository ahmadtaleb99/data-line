part of 'submissions_bloc.dart';


class SubmissionsState extends Equatable {

  final FlowState flowState;
  final  List<Submission> submissions;

  @override
  List<Object> get props => [submissions,flowState];

  const SubmissionsState({
    required this.flowState,
    required this.submissions,
  });

  SubmissionsState copyWith({
    FlowState? flowState,
    List<Submission>? submissions,
  }) {
    return SubmissionsState(
      flowState: flowState ?? this.flowState,
      submissions: submissions ?? this.submissions,
    );
  }
}
