// ignore_for_file: must_be_immutable

part of 'form__bloc.dart';

@immutable
abstract class BlocFormState {}

class FormInitial extends BlocFormState {}

class FormLoading extends BlocFormState {}


class FormLoaded extends BlocFormState {
  List<Widget> formElements;

  FormLoaded({
    required this.formElements,
  });

  FormLoaded copyWith({
    List<Widget>? formElements,
    List<DrawCheckboxGroup>? group,
  }) {
    return FormLoaded(
      formElements: formElements ?? this.formElements,
    );
  }
}

