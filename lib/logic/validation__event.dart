// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable
abstract class ValidationEvent {}


class CheckboxGroupValueChanged extends ValidationEvent {
  String id;
  String groupName;
  bool newIsChecked;

  CheckboxGroupValueChanged({
    required this.groupName,
    required this.id,
    required this.newIsChecked,
  });

}

class MultiSelectItemRemoved extends ValidationEvent {
      String item;
      String selectName;
      DrawMultiSelect select;

      MultiSelectItemRemoved({
    required this.item,
    required this.selectName,
    required this.select,
  });
}
class StateFormRequested extends ValidationEvent {



}
class FormRequested extends ValidationEvent {
  String formName;

  FormRequested({
    required this.formName,
  });

}

class FormsRequestedFromLocal extends ValidationEvent {
}
class FormSubmitted extends ValidationEvent {
  String formName;
  FormSubmitted({required this.formName});
}

class ServiceRegistered extends ValidationEvent {
}
class MultiSelectChanged extends ValidationEvent {

  FormElement select ;
  List<String> value;

  MultiSelectChanged({
    required this.select,
    required this.value,
  });
}

class TextFieldValueChanged extends ValidationEvent {
  String textFieldName;
  String value;
  TextFieldValueChanged(this.value,{required this.textFieldName});
}


class RadioGroupValueChanged extends ValidationEvent{
  String value;
  String groupName;
  String id;

  RadioGroupValueChanged({
    required this.value,
    required this.groupName,
    required this.id,
  });
}

class ParentDropListChanged extends ValidationEvent {

  DrawDropDown drawDropDownButton ;
  String parent;

  ParentDropListChanged({
    required this.drawDropDownButton,
    required this.parent,
  });
}


class childDropDownChanged extends ValidationEvent {

  FormElement childList ;
  String value;

  childDropDownChanged({
    required this.childList,
    required this.value,
  });
}
