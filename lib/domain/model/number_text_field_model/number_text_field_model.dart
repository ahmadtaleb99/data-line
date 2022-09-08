// ignore_for_file: unused_import

import 'package:equatable/equatable.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/presentation/form_widgets/number_text_field_widget/number_text_field_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/responses/forms/enums.dart';
import '../form_model.dart';

part 'number_text_field_model.g.dart';

@HiveType(typeId: 7)
class NumberFieldModel extends FormFieldModel with EquatableMixin{





  @HiveField(13)
  final Operator? operator;

  @HiveField(14)
  final int? expressionsValue;

  @HiveField(15)
  final int? expressionsValue2;

  NumberFieldModel({
    required this.operator,
    required this.expressionsValue,
    required this.expressionsValue2,
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

  NumberFieldModel copyWith({
    Operator? operator,
    int? expressionsValue,
    int? expressionsValue2,
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
    return NumberFieldModel(

      operator: operator ?? this.operator,
      expressionsValue: expressionsValue ?? this.expressionsValue,
      expressionsValue2: expressionsValue2 ?? this.expressionsValue2,
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


  NumberTextFieldWidget toWidget (){
    return NumberTextFieldWidget(numberFieldModel: this,

    );
  }

  @override
  List<Object?> get props => super.props..addAll([operator,expressionsValue]);

}
