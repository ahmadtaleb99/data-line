part of 'forms_bloc.dart';

abstract class FormsEvent extends Equatable {
  const FormsEvent();
}


class DropDownValueChanged extends FormsEvent {
  final String fieldName;
  final String value;

  const DropDownValueChanged({
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

}class SubmitCanceled extends FormsEvent {
  @override
  List<Object?> get props =>[];

}