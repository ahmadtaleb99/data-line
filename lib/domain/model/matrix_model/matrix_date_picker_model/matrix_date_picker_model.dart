import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/data/responses/forms/enums.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../presentation/form_widgets/matrix_widget/widgets/matrix_date_picker_widget/matrix_date_picker_widget.dart';
part 'matrix_date_picker_model.g.dart';

@HiveType(typeId: 26)
class MatrixDatePickerModel extends MatrixFieldModel with EquatableMixin{


  MatrixDatePickerModel({
    required String fieldName,
    required String label,
    required FieldType type,
  }) : super(
    fieldName: fieldName,
    label: label,
    type: type,

  );

  MatrixDatePickerModel copyWith({

    String? fieldName,
    String? label,


    FieldType? type,

  }) {
    return MatrixDatePickerModel(

      fieldName: fieldName ?? this.fieldName,
      label: label ?? this.label,
      type: type ?? this.type,

    );
  }


  @override
  Widget toWidget (){
    return MatrixDatePickerWidget(model: this);
  }

  @override
  List<Object?> get props => super.props;

}
