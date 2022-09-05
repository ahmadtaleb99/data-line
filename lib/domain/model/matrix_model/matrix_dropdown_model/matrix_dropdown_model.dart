import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/data/responses/forms/enums.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/widgets/matrix_dropdown_widget/matrix_dropdown_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'matrix_dropdown_model.g.dart';

@HiveType(typeId: 27)
class MatrixDropDownModel extends MatrixFieldModel with EquatableMixin{




  @HiveField(4)
  final List<MultipleOptionsModel> values;

  MatrixDropDownModel({
    required this.values,
    required String fieldName,
    required String label,
    required FieldType type,
  }) : super(
    fieldName: fieldName,
    label: label,
    type: type,

  );

  MatrixDropDownModel copyWith({

    String? fieldName,
    String? label,


    FieldType? type,
    List<MultipleOptionsModel> ? values

  }) {
    return MatrixDropDownModel(

      fieldName: fieldName ?? this.fieldName,
      label: label ?? this.label,
      type: type ?? this.type,
      values: values ?? this.values,

    );
  }


  @override
  Widget toWidget (){
    return MatrixDropDownWidget(model: this);
  }

  @override
  List<Object?> get props => super.props..addAll([values]);

}
