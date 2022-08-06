import 'package:equatable/equatable.dart';
import 'package:form_builder_test/domain/model/dropdown_item_model/dropdown_item_model.dart';
import 'package:form_builder_test/domain/model/radio_group_item_model/radio_group_item_model.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../form_model.dart';

class DropDownModel extends FormFieldModel with EquatableMixin{
  final String prompt;
  final bool relatedListCheckbox;
  final String relatedListFieldName;
  final bool multiple;
  final List<DropDownItemModel> values;
  
  DropDownModel({
    required this.prompt,
    required this.relatedListCheckbox,
    required this.relatedListFieldName,
    required this.multiple,
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


  DropDownModel copyWith({
     String? prompt,
     bool? relatedListCheckbox,
     String ?relatedListFieldName,
     bool? multiple,
    List<DropDownItemModel>? values,
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
    return DropDownModel(
      prompt : prompt ?? this.prompt,
      relatedListCheckbox : relatedListCheckbox ?? this.relatedListCheckbox,
      relatedListFieldName : relatedListFieldName ?? this.relatedListFieldName,
      multiple : multiple ?? this.multiple,
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
  List<Object?> get props => super.props..addAll([prompt,relatedListCheckbox,relatedListFieldName,multiple,values]);

}
