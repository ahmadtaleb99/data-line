part of 'form__bloc.dart';

@immutable
abstract class FormEvent {}

class sd extends FormEvent {
  int formId;

  sd({
    required this.formId,
  });


}

class CheckboxGroupValueChanged1 extends FormEvent {
  String id;
  String groupName;
  bool newIsChecked;

  CheckboxGroupValueChanged1({
    required this.groupName,
    required this.id,
    required this.newIsChecked,
  });

}



class RadioGroupValueChanged1 extends FormEvent{
  String value;
  String groupName;
  String id;

  RadioGroupValueChanged1({
    required this.value,
    required this.groupName,
    required this.id,
  });
}

class ParentDropListChanged1 extends FormEvent {

  DrawDropDown drawDropDownButton ;
  String parent;

  ParentDropListChanged1({
    required this.drawDropDownButton,
    required this.parent,
  });
}


class childDropDownChanged1 extends FormEvent {

  DrawChildList childList ;
  String value;

  childDropDownChanged1({
    required this.childList,
    required this.value,
  });
}
