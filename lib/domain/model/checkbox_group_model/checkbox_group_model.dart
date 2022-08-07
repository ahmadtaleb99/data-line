import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../checkbox_group_item_model/checkbox_group_item_model.dart';
import '../form_model.dart';

class CheckboxGroupModel extends FormFieldModel with EquatableMixin{
  final bool other;
  final bool minMaxCheckbox;
  final int checkboxMinValue;
  final int checkboxMaxValue;
  List<CheckboxGroupItemModel> values;
  CheckboxGroupModel({
    required this.other,
    required this.values,
    required this.minMaxCheckbox,
    required this.checkboxMinValue,
    required this.checkboxMaxValue,
    required String name,
    required String label,
    required FieldType type,
    required bool deactivate,
    required bool required,
    required bool isHidden,
    required bool isReadOnly,
    required bool showIfLogicCheckbox,
    required bool showIfIsRequired,
    required bool requiredIfLogicCheckbox,
  }) : super(
      name: name,
      label: label,
      type: type,
      deactivate: deactivate,
      required: required,
      isHidden: isHidden,
      isReadOnly: isReadOnly,
      showIfLogicCheckbox: showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired,
      requiredIfLogicCheckbox: requiredIfLogicCheckbox);


  CheckboxGroupModel copyWith({

    bool ?  other,
     bool ?  minMaxCheckbox,
     int?   checkboxMinValue,
     int ?  checkboxMaxValue,
    List<CheckboxGroupItemModel>? values,
    String? name,
    String? label,
    FieldType? type,
    bool? deactivate,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    bool? showIfLogicCheckbox,
    bool? showIfIsRequired,
    bool? requiredIfLogicCheckbox,
  }) {
    return CheckboxGroupModel(

      other: other ?? this.other,
      minMaxCheckbox: minMaxCheckbox ?? this.minMaxCheckbox,
      checkboxMinValue: checkboxMinValue ?? this.checkboxMinValue,
      checkboxMaxValue: checkboxMaxValue ?? this.checkboxMaxValue,
      values: values ?? this.values,
      name: name ?? this.name,
      label: label ?? this.label,
      type: type ?? this.type,
      deactivate: deactivate ?? this.deactivate,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      showIfLogicCheckbox: showIfLogicCheckbox ?? this.showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      requiredIfLogicCheckbox:
      requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,

    );
  }


  @override
  List<Object?> get props => super.props..addAll([other,minMaxCheckbox,checkboxMinValue,checkboxMaxValue,values]);

  @override
  Widget toWidget() {
    // TODO: implement toWidget
    throw UnimplementedError();
  }

}
