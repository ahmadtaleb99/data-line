import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:datalines/data/responses/forms/enums.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../presentation/form_widgets/matrix_widget/widgets/matrix_checkbox_widget/matrix_checkbox_widget.dart';
part 'matrix_checkbox_model.g.dart';

@HiveType(typeId: 25)
class MatrixCheckboxModel extends MatrixFieldModel with EquatableMixin{


  MatrixCheckboxModel({
    required String fieldName,
    required String label,
    required FieldType type,
  }) : super(
    fieldName: fieldName,
    label: label,
    type: type,

  );

  MatrixCheckboxModel copyWith({

    String? fieldName,
    String? label,


    FieldType? type,

  }) {
    return MatrixCheckboxModel(

      fieldName: fieldName ?? this.fieldName,
      label: label ?? this.label,
      type: type ?? this.type,

    );
  }


  @override
  Widget toWidget (){
    return MatrixCheckboxWidget(model: this);
  }

  @override
  List<Object?> get props => super.props;

}
