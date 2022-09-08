import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:datalines/data/responses/forms/enums.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../presentation/form_widgets/matrix_widget/widgets/matrix_radio_group_widget/matrix_radio_group_widget.dart';

part 'matrix_radio_group_model.g.dart';

@HiveType(typeId: 29)
class MatrixRadioGroupModel extends MatrixFieldModel with EquatableMixin{




  @HiveField(4)
  final List<MultipleOptionsModel> values;

  MatrixRadioGroupModel({
    required this.values,
    required String fieldName,
    required String label,
    required FieldType type,
  }) : super(
    fieldName: fieldName,
    label: label,
    type: type,

  );

  MatrixRadioGroupModel copyWith({

    String? fieldName,
    String? label,


    FieldType? type,
    List<MultipleOptionsModel> ? values

  }) {
    return MatrixRadioGroupModel(

      fieldName: fieldName ?? this.fieldName,
      label: label ?? this.label,
      type: type ?? this.type,
      values: values ?? this.values,

    );
  }


  @override
  Widget toWidget (){
    return MatrixRadioGroupWidget(model:  this);
  }

  @override
  List<Object?> get props => super.props..addAll([values]);

}
