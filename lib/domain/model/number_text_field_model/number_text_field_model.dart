import 'package:equatable/equatable.dart';
import 'package:form_builder_test/data/responses/forms/forms_response.dart';
import 'package:form_builder_test/presentation/form_widgets/number_text_field_widget/number_text_field_widget.dart';

import '../form_model.dart';

class NumberFieldModel extends FormFieldModel with EquatableMixin{
  final String operator;
  final int expressionsValue;

  NumberFieldModel({
    required this.operator,
    required this.expressionsValue,
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

  NumberFieldModel copyWith({
    String? operator,
    int? expressionsValue,
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
    return NumberFieldModel(

      operator: operator ?? this.operator,
      expressionsValue: expressionsValue ?? this.expressionsValue,
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


  NumberTextFieldWidget toWidget (){
    return NumberTextFieldWidget(numberFieldModel: this,

    );
  }

  @override
  List<Object?> get props => super.props..addAll([operator,expressionsValue]);

}