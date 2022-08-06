import 'package:equatable/equatable.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../form_model.dart';
import '../radio_group_item_model/radio_group_item_model.dart';

class RadioGroupModel extends FormFieldModel with EquatableMixin {
  final bool other;
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
    bool? requiredIfLogicCheckbox,
  }) {
    return RadioGroupModel(
      values: values ?? this.values,
      other: other ?? this.other,
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
  List<Object?> get props => super.props..addAll([other, values]);

}
