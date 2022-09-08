import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:datalines/data/responses/forms/enums.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/presentation/form_widgets/matrix_widget/widgets/matrix_text_field_widget/matrix_text_field_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'matrix_text_field_model.g.dart';

@HiveType(typeId: 30)
class MatrixTextFieldModel extends MatrixFieldModel with EquatableMixin{


  MatrixTextFieldModel({
    required String fieldName,
    required String label,
    required FieldType type,
  }) : super(
    fieldName: fieldName,
    label: label,
    type: type,

  );

  MatrixTextFieldModel copyWith({

    String? fieldName,
    String? label,


    FieldType? type,

  }) {
    return MatrixTextFieldModel(

      fieldName: fieldName ?? this.fieldName,
      label: label ?? this.label,
      type: type ?? this.type,

    );
  }


  Widget toWidget (){
    return MatrixTextFieldWidget(model:  this,);
  }

  @override
  List<Object?> get props => super.props;

}
