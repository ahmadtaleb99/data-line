part of 'form__bloc.dart';

@immutable
abstract class FormEvent {}

class FormRequested extends FormEvent {
  int formId;

  FormRequested({
    required this.formId,
  });
}

