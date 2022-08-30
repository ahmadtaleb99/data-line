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
      MultiSelectWidget select;

      MultiSelectItemRemoved({
    required this.item,
    required this.selectName,
    required this.select,
  });
}
class FormsRequested extends ValidationEvent {



}

class NodeChanged extends ValidationEvent {

  Node node;

  NodeChanged(this.node);
}


class MatrixDatePickerChanged extends ValidationEvent {

    BuildContext context;
    MatrixDatePickerWidget matrixDatePickerWidget;
    MatrixDatePickerChanged({
    required this.context,
    required this.matrixDatePickerWidget,


  });
}
class FormRequested extends ValidationEvent {
  String formName;

  FormRequested({
    required this.formName,
  });

}

class RecordAdded extends ValidationEvent {


  String matrixName;
  BuildContext ?  context;
  RecordAdded({required this.matrixName,this.context});
}


class FilePickerSaved extends ValidationEvent {
   File file;
    oldFilePicker filePicker;
  FilePickerSaved({
    required this.file,
    required this.filePicker,
  });

}

class FileDownloadedNotification extends ValidationEvent {
   String path;

   FileDownloadedNotification({
    required this.path,
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


class oldFilePreviewRequested extends ValidationEvent {
    String path;
    oldFilePreviewRequested({required this.path});
}


class RecordRemoved extends ValidationEvent {
    String matrixName;
    MatrixRecordWidget matrixRecord;
    RecordRemoved({required this.matrixName,required this.matrixRecord});
}


class MatrixSubmitted extends ValidationEvent {
    String matrixName;
    BuildContext context;
    MatrixSubmitted({required this.matrixName,required this.context});
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


class oldFilePickerPressed extends ValidationEvent {

  oldFilePicker drawFilePicker;
  oldFilePickerPressed({required this.drawFilePicker});
}
class MultiSelectChanged extends ValidationEvent {

  FormElementWidget select ;
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

class Refresher extends ValidationEvent {

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

  OldDropDownWidget drawDropDownButton ;
  String parent;

  ParentDropListChanged({
    required this.drawDropDownButton,
    required this.parent,
  });
}


class StarRatingUpdated extends ValidationEvent {
double value;
String name;
StarRatingUpdated({
    required this.value,
    required this.name,

  });
}


class childDropDownChanged extends ValidationEvent {

  FormElementWidget childList ;
  String  ? value;

  childDropDownChanged({
    required this.childList,
    required this.value,
  });
}
