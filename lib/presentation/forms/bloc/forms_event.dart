part of 'forms_bloc.dart';

abstract class FormsEvent extends Equatable {
  const FormsEvent();
}


class FieldValueChanged extends FormsEvent {
  final String fieldName;
  final String value;

  const FieldValueChanged({
    required this.fieldName,
    required this.value,
  });


  @override
  List<Object?> get props => [fieldName,value];
}


class NewFormRequested extends FormsEvent {
  FormModel formModel;

  NewFormRequested(this.formModel,);

  @override
  List<Object?> get props => [formModel];

}


class FormSubmitted extends FormsEvent {
  FormModel formModel;

  FormSubmitted(this.formModel,);

  @override
  List<Object?> get props => [formModel];

}

class SubmissionUpdateRequested extends FormsEvent {
  FormModel formModel;
  Submission submission;
  SubmissionUpdateRequested(this.formModel,this.submission);

  @override
  List<Object?> get props => [formModel,submission];

}

class SubmissionsRequested extends FormsEvent {
  FormModel formModel;

  SubmissionsRequested(this.formModel,);

  @override
  List<Object?> get props => [formModel];

}

class SubmitCanceled extends FormsEvent {
  @override
  List<Object?> get props =>[];

}class SubmissionDeleted extends FormsEvent {
  Submission submission;


  SubmissionDeleted(this.submission);
  @override
  List<Object?> get props =>[submission];

}