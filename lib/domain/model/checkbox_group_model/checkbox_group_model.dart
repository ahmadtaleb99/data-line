import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:datalines/presentation/form_widgets/checkbox_group_widget/checkbox_group_widget.dart';
import 'package:hive/hive.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../../../data/responses/forms/enums.dart';
import '../checkbox_group_item_model/checkbox_group_item_model.dart';
import '../form_model.dart';

part 'checkbox_group_model.g.dart';

@HiveType(typeId: 2)
class CheckboxGroupModel extends FormFieldModel with EquatableMixin{

  @HiveField(13)
  final bool other;

  @HiveField(14)
  final bool minMaxCheckbox;

  @HiveField(15)
  final int checkboxMinValue;

  @HiveField(16)
  final int checkboxMaxValue;

  @HiveField(17)
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
    required String showIfFieldName,
    required String showIfFieldValue,
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
      showIfFieldName: showIfFieldName,
      showIfFieldValue: showIfFieldValue,
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
   String?  showIfFieldName,
   String?  showIfFieldValue,
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
      showIfFieldName: showIfFieldName ?? this.showIfFieldName,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      requiredIfLogicCheckbox:
      requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,

    );
  }


  @override
  List<Object?> get props => super.props..addAll([other,minMaxCheckbox,checkboxMinValue,checkboxMaxValue,values]);

  @override
  Widget toWidget() {
   return CheckboxGroupWidget(model : this);
  }

}
