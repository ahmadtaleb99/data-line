import 'package:equatable/equatable.dart';
import 'package:form_builder_test/domain/model/dropdown_item_model/dropdown_item_model.dart';
import 'package:form_builder_test/domain/model/radio_group_item_model/radio_group_item_model.dart';
import 'package:form_builder_test/presentation/form_widgets/dropdown_widget/dropdown_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../form_model.dart';



part 'dropdown_model.g.dart';

@HiveType(typeId: 4)
class DropDownModel extends FormFieldModel with EquatableMixin{

  @HiveField(11)
  final String prompt;

  @HiveField(12)
  final bool relatedListCheckbox;

  @HiveField(13)
  final String relatedListFieldName;

  @HiveField(14)
  final bool multiple;

  @HiveField(15)
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
  DropDownWidget toWidget () {
    return DropDownWidget(dropDownModel: this);
  }

  @override
  List<Object?> get props => super.props..addAll([prompt,relatedListCheckbox,relatedListFieldName,multiple,values]);

}
