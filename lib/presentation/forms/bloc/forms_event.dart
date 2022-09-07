part of 'forms_bloc.dart';

abstract class FormsEvent extends Equatable {
  const FormsEvent();
}
class AssignedFormsRequested extends FormsEvent{
  @override
  List<Object?> get props => [];

}

class AssignedFormsRefreshRequested extends FormsEvent{
  @override
  List<Object?> get props => [];

}

class FieldValueChanged extends FormsEvent {
  final String fieldName;
  final dynamic value;

  const FieldValueChanged({
    required this.fieldName,
    required this.value,
  });


  @override
  List<Object?> get props => [fieldName,value];
}
class MatrixFieldValueChanged extends FormsEvent {
  final String fieldName;
  final dynamic value;

  const MatrixFieldValueChanged({
    required this.fieldName,
    required this.value,
  });


  @override
  List<Object?> get props => [fieldName,value];
}

class MatrixCheckboxGroupValueChanged extends FormsEvent {
  final String fieldName;
  final bool isChecked;
  final String value;

  const MatrixCheckboxGroupValueChanged({
    required this.fieldName,
    required this.isChecked,
    required this.value,
  });


  @override
  List<Object?> get props => [fieldName,isChecked,value];
}

class NewMatrixRecordAddRequested extends FormsEvent {
  final int index;
  final String matrixName;
  @override
  List<Object?> get props => [index,matrixName];

  const NewMatrixRecordAddRequested({
    required this.index,
    required this.matrixName,
  });
}



class MatrixRecordAEditRequested extends FormsEvent {
  final int index;
  final String matrixName;
  @override
  List<Object?> get props => [index,matrixName];

  const MatrixRecordAEditRequested({
    required this.index,
    required this.matrixName,
  });
}
class MatrixRecordSubmitted extends FormsEvent {

  @override
  List<Object?> get props => [];

  const MatrixRecordSubmitted();
}
class MatrixRecordDeleted extends FormsEvent {
  final String matrixName;
  final int recordIndex;

  @override
  List<Object?> get props => [];

  const MatrixRecordDeleted({
    required this.matrixName,
    required this.recordIndex,
  });
}
class FilePickerPressed extends FormsEvent {
  final FilePickerModel model;

  const FilePickerPressed({
    required this.model,
  });


  @override
  List<Object?> get props => [model];
}
class FilePickerSaved extends FormsEvent {
  final FilePickerModel model;

  const FilePickerSaved({
    required this.model,
  });


  @override
  List<Object?> get props => [model];
}



class TextValueChanged extends FormsEvent {
  final String fieldName;
  final dynamic value;

  const TextValueChanged({
    required this.fieldName,
    required this.value,
  });


  @override
  List<Object?> get props => [fieldName,value];
}
class MatrixTextValueChanged extends FormsEvent {
  final String fieldName;
  final dynamic value;

  const MatrixTextValueChanged({
    required this.fieldName,
    required this.value,
  });


  @override
  List<Object?> get props => [fieldName,value];
}
class MultiDropDownValueTapped extends FormsEvent {
  final String fieldName;
  final String value;

  const MultiDropDownValueTapped({
    required this.fieldName,
    required this.value,
  });


  @override
  List<Object?> get props => [fieldName,value];
}

class DropDownValueChanged extends FormsEvent {
  final String fieldName;
  final String? value;

  const DropDownValueChanged({
    required this.fieldName,
    required this.value,
  });


  @override
  List<Object?> get props => [fieldName,value];
}

class MultiDropDownValueChanged extends FormsEvent {
  final String fieldName;
  final List<String> values;

  const MultiDropDownValueChanged({
    required this.fieldName,
    required this.values,
  });


  @override
  List<Object?> get props => [fieldName,values];
}
class CheckboxGroupValueChanged extends FormsEvent {
  final String fieldName;
  final bool isChecked;
  final String value;

  const CheckboxGroupValueChanged({
    required this.fieldName,
    required this.isChecked,
    required this.value,
  });


    @override
    List<Object?> get props => [fieldName,isChecked,value];
}

class RadioGroupValueChanged extends FormsEvent {
  final String fieldName;
  final String value;

  const RadioGroupValueChanged({
    required this.fieldName,
    required this.value,
  });


    @override
    List<Object?> get props => [fieldName,value];
}


class NewFormRequested extends FormsEvent {
  final FormModel formModel;

 const  NewFormRequested(this.formModel,);

  @override
  List<Object?> get props => [formModel];

}


class FormSubmitted extends FormsEvent {
  FormModel formModel;

  FormSubmitted(this.formModel,);

  @override
  List<Object?> get props => [formModel];

}


class SubmissionUpdated extends FormsEvent {
  FormModel formModel;
  Submission submission;


  SubmissionUpdated(this.formModel,this.submission);

  @override
  List<Object?> get props => [formModel,submission];


}

class SubmissionUpdateRequested extends FormsEvent {
  FormModel formModel;
  Submission submission;
  SubmissionUpdateRequested(this.formModel,this.submission);

  @override
  List<Object?> get props => [formModel,submission];

}
//
// class SubmissionsRequested extends FormsEvent {
//   FormModel formModel;
//
//   SubmissionsRequested(this.formModel,);
//
//   @override
//   List<Object?> get props => [formModel];
//
// }

class MatrixSubmitCanceled extends FormsEvent {
  final matrixName ;
  @override
  List<Object?> get props =>[matrixName];

  const MatrixSubmitCanceled({
    required this.matrixName,
  });
}

// class SubmissionDeleted extends FormsEvent {
//   Submission submission;
//
//
//   SubmissionDeleted(this.submission);
//   @override
//   List<Object?> get props =>[submission];
//
// }