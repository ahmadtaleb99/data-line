part of 'form__bloc.dart';

@immutable
abstract class FormEvent {}

class FormRequested extends FormEvent{}


class CheckboxGroupValueChanged extends FormEvent { DrawCheckbox

drawCheckbox;

CheckboxGroupValueChanged(this.drawCheckbox);
}
