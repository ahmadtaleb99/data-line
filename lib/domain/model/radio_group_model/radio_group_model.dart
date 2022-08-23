import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../../../data/responses/forms/enums.dart';
import '../../../presentation/form_widgets/radio_group_widget/radio_group_widget.dart';
import '../form_model.dart';
import '../radio_group_item_model/radio_group_item_model.dart';

part 'radio_group_model.g.dart';

@HiveType(typeId: 9)
class RadioGroupModel extends FormFieldModel with EquatableMixin {

  @HiveField(13)
  final bool other;

  @HiveField(14)
  final List<RadioGroupItemModel> values;
  RadioGroupModel({
    required this.other,
    required this.values,
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
            isReadOnly: isReadOnly,
      showIfFieldName: showIfFieldName,
      showIfFieldValue: showIfFieldValue,

            showIfLogicCheckbox: showIfLogicCheckbox,
            showIfIsRequired: showIfIsRequired,
            requiredIfLogicCheckbox: requiredIfLogicCheckbox);



  RadioGroupModel copyWith({
    List<RadioGroupItemModel>? values,
    bool? other,
    String? name,
    String? label,
    FieldType? type,
    bool? deactivate,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    bool? showIfLogicCheckbox,
    bool? showIfIsRequired,
    String? showIfFieldName,
    String? showIfFieldValue,
    bool? requiredIfLogicCheckbox,
  }) {
    return RadioGroupModel(
      values: values ?? this.values,
      other: other ?? this.other,
      name: name ?? this.name,
      label: label ?? this.label,
      showIfFieldName: showIfFieldName ?? this.showIfFieldName,
      type: type ?? this.type,
      deactivate: deactivate ?? this.deactivate,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      showIfLogicCheckbox: showIfLogicCheckbox ?? this.showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      requiredIfLogicCheckbox:
          requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,
    );
  }

  @override
  List<Object?> get props => super.props..addAll([other, values]);

  @override
  Widget toWidget() {
    return RadioGroupWidget(model: this,);
  }

}
