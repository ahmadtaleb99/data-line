import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:datalines/presentation/form_widgets/email_text_field_widget/email_text_field_widget.dart';
import 'package:hive/hive.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../../../data/responses/forms/enums.dart';
import '../form_model.dart';

part 'email_text_field_model.g.dart';
@HiveType(typeId: 5)
class EmailTextFieldModel extends FormFieldModel with EquatableMixin{
  EmailTextFieldModel({
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
      showIfFieldValue: showIfFieldValue,
      isReadOnly: isReadOnly,
      showIfFieldName: showIfFieldName,
      showIfLogicCheckbox: showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired,
      requiredIfLogicCheckbox: requiredIfLogicCheckbox);

  EmailTextFieldModel copyWith({

    String? name,
    String? label,
    String? showIfFieldName,
    FieldType? type,
    bool? deactivate,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    bool? showIfLogicCheckbox,
    bool? showIfIsRequired,
    String? showIfFieldValue,
    bool? requiredIfLogicCheckbox,
  }) {
    return EmailTextFieldModel(

      name: name ?? this.name,
      label: label ?? this.label,
      type: type ?? this.type,
      deactivate: deactivate ?? this.deactivate,
      required: required ?? this.required,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      isHidden: isHidden ?? this.isHidden,
      showIfFieldName: showIfFieldName ?? this.showIfFieldName,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      showIfLogicCheckbox: showIfLogicCheckbox ?? this.showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      requiredIfLogicCheckbox:
      requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,

    );
  }

  @override
  List<Object?> get props => super.props;

  @override
  Widget toWidget() {
    return EmailTextFieldWidget(model: this);
  }
}
