import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:datalines/data/responses/forms/enums.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../presentation/form_widgets/matrix_widget/widgets/matrix_number_widget/matrix_number_widget.dart';
part 'matrix_number_model.g.dart';

@HiveType(typeId: 28)
class MatrixNumberModel extends MatrixFieldModel with EquatableMixin{


  MatrixNumberModel({
    required String fieldName,
    required String label,
    required FieldType type,
  }) : super(
    fieldName: fieldName,
    label: label,
    type: type,

  );

  MatrixNumberModel copyWith({

    String? fieldName,
    String? label,


    FieldType? type,

  }) {
    return MatrixNumberModel(

      fieldName: fieldName ?? this.fieldName,
      label: label ?? this.label,
      type: type ?? this.type,

    );
  }


  @override
  Widget toWidget (){
    return MatrixNumberWidget(model: this);
  }

  @override
  List<Object?> get props => super.props;

}
