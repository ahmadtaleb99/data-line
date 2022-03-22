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

  DrawDropDownButton drawDropDownButton ;
  String parent;

  ParentDropListChanged({
    required this.drawDropDownButton,
    required this.parent,
  });
}


class childDropDownChanged extends ValidationEvent {

  DrawChildList childList ;
  String value;

  childDropDownChanged({
    required this.childList,
    required this.value,
  });
}
