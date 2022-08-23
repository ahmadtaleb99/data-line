import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/domain/model/dropdown_item_model/dropdown_item_model.dart';
import 'package:form_builder_test/domain/model/radio_group_item_model/radio_group_item_model.dart';
import 'package:form_builder_test/presentation/form_widgets/dropdown_widget/dropdown_widget.dart';
import 'package:form_builder_test/presentation/form_widgets/multi_dropdown_widget/multi_dropdown_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../../../data/responses/forms/enums.dart';
import '../form_model.dart';

part 'dropdown_model.g.dart';

@immutable
@HiveType(typeId: 4)
class DropDownModel extends FormFieldModel with EquatableMixin {
  @HiveField(13)
  final String prompt;

  @HiveField(14)
  final bool relatedListCheckbox;

  @HiveField(15)
  final String relatedListFieldName;

  @HiveField(16)
  final bool multiple;

  @HiveField(17)
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
    required String showIfFieldName,
    required String showIfFieldValue,
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
            showIfFieldName: showIfFieldName,
            showIfFieldValue: showIfFieldValue,
            requiredIfLogicCheckbox: requiredIfLogicCheckbox);

  DropDownModel copyWith({
    String? prompt,
    bool? relatedListCheckbox,
    String? relatedListFieldName,
    bool? multiple,
    List<DropDownItemModel>? values,
    String? name,
    String? label,
    FieldType? type,
    bool? deactivate,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    String? showIfFieldName,
    String? showIfFieldValue,
    bool? showIfLogicCheckbox,
    bool? showIfIsRequired,
    bool? requiredIfLogicCheckbox,
  }) {
    return DropDownModel(
      prompt: prompt ?? this.prompt,
      relatedListCheckbox: relatedListCheckbox ?? this.relatedListCheckbox,
      relatedListFieldName: relatedListFieldName ?? this.relatedListFieldName,
      multiple: multiple ?? this.multiple,
      values: values ??
          this.values.map((DropDownItemModel e) => e.copyWith()).toList(),
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

  @override
  Widget toWidget() {
    return this.multiple == false
        ? DropDownWidget(dropDownModel: this) : MultiDropDownWidget(dropDownModel: this);
  }

  @override
  List<Object?> get props => super.props
    ..addAll(
        [prompt, relatedListCheckbox, relatedListFieldName, multiple, values]);
}
