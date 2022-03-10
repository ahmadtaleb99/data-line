part of 'form__bloc.dart';

@immutable
abstract class BlocFormState {}

class FormInitial extends BlocFormState {}

class FormLoading extends BlocFormState { }


class FormLoaded extends BlocFormState {
  List<Widget> formElements;

  FormLoaded({required this.formElements});
}

