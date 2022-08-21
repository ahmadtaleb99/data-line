import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/responses/forms/forms_response.dart';
import '../form_model.dart';

part 'text_field_model.g.dart';


@HiveType(typeId: 12)
class TextFieldModel extends FormFieldModel with EquatableMixin{



  TextFieldModel({
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

  TextFieldModel copyWith({

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
    return TextFieldModel(

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
  List<Object?> get props => super.props;

  @override
  Widget toWidget() {
    // TODO: implement toWidget
    throw UnimplementedError();
  }
}
