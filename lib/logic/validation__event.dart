// ignore_for_file: must_be_immutable

part of 'validation__bloc.dart';

@immutable
abstract class ValidationEvent {}


class CheckboxGroupValueChanged extends ValidationEvent {
  String id;
  String value;
  String groupName;
  bool newIsChecked;

  CheckboxGroupValueChanged({
    required this.groupName,
    required this.id,
    required this.value,
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
class FormsRequested extends ValidationEvent {



}
class FormRequested extends ValidationEvent {
  String formName;

  FormRequested({
    required this.formName,
  });

}

class FormUpdateRequested extends ValidationEvent {
  String formName;
  int index;
  FormUpdateRequested({
    required this.formName,
    required this.index,
  });

}
class OtherRadioValueChanged extends ValidationEvent {
  String groupName;
  String value;
  OtherRadioValueChanged({
    required this.value,
    required this.groupName,
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


class FormUpdated extends ValidationEvent {
  String formName;
  int index;
  FormUpdated({required this.formName,required this.index});

}




class SubmittionsFormsRequested extends ValidationEvent {
  String formName;

  SubmittionsFormsRequested({
    required this.formName,
  });
}

class FormDeleted extends ValidationEvent {
  String formName;
  int index;
  FormDeleted({
    required this.formName,
    required this.index,
  });
}

class FormUpdatePageRequested extends ValidationEvent {
  String formName;
  int index;
  BuildContext context;

  FormUpdatePageRequested({
    required this.formName,
    required this.index,
    required this.context,
  });
}


class FilePickerPressed extends ValidationEvent {

  DrawFilePicker drawFilePicker;
  FilePickerPressed({required this.drawFilePicker});
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
