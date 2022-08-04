import 'package:equatable/equatable.dart';

class AssignedForms with EquatableMixin {
  List<FormModel>? data;

  AssignedForms(this.data);

  @override
  List<Object?> get props => [data];
}

class FormModel with EquatableMixin {
  final String name;
  final String directionality;
  final List<FormFieldModel> fields;

  const FormModel({
    required this.name,
    required this.directionality,
    required this.fields,
  });

  @override
  List<Object?> get props => [name, directionality, fields];

  FormModel copyWith({
    String? name,
    String? directionality,
    List<FormFieldModel>? fields,
  }) {
    return FormModel(
      name: name ?? this.name,
      directionality: directionality ?? this.directionality,
      fields: fields ?? this.fields,
    );
  }
}

class FormFieldModel with EquatableMixin {
  final String name;

  final String label;

  final String type;

  final bool deactivate;

  final bool required;

  final bool isHidden;

  final bool isReadOnly;

  final bool showIfLogicCheckbox;

  final bool showIfIsRequired;

  final bool requiredIfLogicCheckbox;

  FormFieldModel({
    required this.name,
    required this.label,
    required this.type,
    required this.deactivate,
    required this.required,
    required this.isHidden,
    required this.isReadOnly,
    required this.showIfLogicCheckbox,
    required this.showIfIsRequired,
    required this.requiredIfLogicCheckbox,
  });

  @override
  List<Object?> get props => [
        name,
        label,
        type,
        deactivate,
        isHidden,
        isReadOnly,
        showIfLogicCheckbox,
    showIfIsRequired,
    requiredIfLogicCheckbox,
      ];

  FormFieldModel copyWith({
    String? name,
    String? label,
    String? type,
    bool? deactivate,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    bool? showIfLogicCheckbox,
    bool? showIfIsRequired,
    bool? requiredIfLogicCheckbox,
  }) {
    return FormFieldModel(
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
}











