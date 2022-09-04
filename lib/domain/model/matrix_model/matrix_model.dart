import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/matrix_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/responses/forms/enums.dart';


import 'package:form_builder_test/data/responses/forms/forms_response.dart';
import 'package:form_builder_test/presentation/form_widgets/number_text_field_widget/number_text_field_widget.dart';

import '../form_model.dart';

part 'matrix_model.g.dart';

@HiveType(typeId: 22)
class MatrixModel extends FormFieldModel with EquatableMixin{





  @HiveField(13)
  final int maxRecordsCount;


  @HiveField(14)
  final List<MatrixFieldModel> values;

  MatrixModel({
    required this.maxRecordsCount,
    required this.values,

    required String name,
    required String label,
    required FieldType type,
    required bool deactivate,
    required bool required,
    required bool isHidden,
    required bool isReadOnly,
    required bool showIfLogicCheckbox,
    required bool showIfIsRequired,
    required String showIfFieldName,
    required String showIfFieldValue,
    required bool requiredIfLogicCheckbox,
  }) : super(
      name: name,
      label: label,
      type: type,
      deactivate: deactivate,
      required: required,
      isHidden: isHidden,
      isReadOnly: isReadOnly,
      showIfFieldName: showIfFieldName,
      showIfFieldValue: showIfFieldValue,
      showIfLogicCheckbox: showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired,
      requiredIfLogicCheckbox: requiredIfLogicCheckbox);

  @override
  Widget toWidget (){
      return MatrixWidget(model: this);
  }

  @override
  List<Object?> get props => super.props..addAll([maxRecordsCount,values]);



  MatrixModel copyWith({

    Operator? operator,
    int? maxRecordsCount,
    List<MatrixFieldModel>? values,
    String? name,
    String? label,
    String? showIfFieldName,
    String? showIfFieldValue,
    FieldType? type,
    bool? deactivate,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    bool? showIfLogicCheckbox,
    bool? showIfIsRequired,
    bool? requiredIfLogicCheckbox,
  }) {
    return MatrixModel(

    maxRecordsCount: maxRecordsCount ?? this.maxRecordsCount,
      values: values ?? this.values.map((dynamic e) => e.copyWith()).toList().cast(),


      name: name ?? this.name,
      label: label ?? this.label,
      type: type ?? this.type,
      deactivate: deactivate ?? this.deactivate,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      showIfFieldName: showIfFieldName ?? this.showIfFieldName,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      showIfLogicCheckbox: showIfLogicCheckbox ?? this.showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      requiredIfLogicCheckbox:
      requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,

    );
  }
}





@HiveType(typeId: 21)
 class MatrixFieldModel with EquatableMixin {


  Widget toWidget() {
    return Text('asd');
  }

  @HiveField(1)
  final String fieldName;

  @HiveField(2)
  final String label;

  @HiveField(3)
  final FieldType type;





  @override
  List<Object?> get props => [
    fieldName,
    label,
    type,
  ];

  const MatrixFieldModel({
    required this.fieldName,
    required this.label,
    required this.type,
  });

  MatrixFieldModel copyWith({
    String? fieldName,
    String? label,
    FieldType? type,
  }) {
    return MatrixFieldModel(
      fieldName: fieldName ?? this.fieldName,
      label: label ?? this.label,
      type: type ?? this.type,
    );
  }
}


@HiveType(typeId: 23)
class MultipleOptionsModel  extends Equatable{

  @HiveField(1)
  final String label;

  @HiveField(2)
  final String value;



  const MultipleOptionsModel({
    required this.label,
    required this.value,
  });

  @override
  List<Object?> get props => [label,value];

  MultipleOptionsModel copyWith({
    String? label,
    String? value,

  }) {
    return MultipleOptionsModel(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }
}