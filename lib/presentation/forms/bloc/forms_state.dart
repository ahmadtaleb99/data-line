part of 'forms_bloc.dart';




class FormsState extends Equatable {
  final   FormModel? formModel;
  final Map<String,dynamic> submissionMap;
  @override
  List<Object> get props => [submissionMap];

  const FormsState({
    this.formModel,
    required this.submissionMap,
  });

  FormsState copyWith({
    FormModel? formModel,
    Map<String, dynamic>? submissionMap,
  }) {
    return FormsState(
      formModel: formModel ?? this.formModel,
      submissionMap: submissionMap ?? this.submissionMap,
    );
  }
}
