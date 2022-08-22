import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../data/responses/forms/forms_response.dart';
import '../../../data/responses/forms/enums.dart';
import '../form_model.dart';


part 'text_area_model.g.dart';

@HiveType(typeId: 11)
class TextAreaModel extends FormFieldModel with EquatableMixin {

  @HiveField(13)
  final int maxLength;

  @HiveField(14)
  final int minLength;

  TextAreaModel({
    required this.maxLength,
    required this.minLength,
    required String name,
    required String label,
    required FieldType type,
    required bool deactivate,
    required bool required,
    required bool isHidden,
    required bool isReadOnly,
    required bool showIfLogicCheckbox,
    required bool showIfIsRequired,
    required String showIfFieldName,
    required String showIfFieldValue,

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
      showIfLogicCheckbox: showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired,
      showIfFieldName: showIfFieldName,
      requiredIfLogicCheckbox: requiredIfLogicCheckbox);


  TextAreaModel copyWith({
    int? maxLength,
    int? minLength,
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
    return TextAreaModel(
      maxLength: maxLength ?? this.maxLength,
      minLength: minLength ?? this.minLength,
      name: name ?? this.name,
      label: label ?? this.label,
      type: type ?? this.type,
      deactivate: deactivate ?? this.deactivate,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      showIfLogicCheckbox: showIfLogicCheckbox ?? this.showIfLogicCheckbox,
      showIfFieldName: showIfFieldName ?? this.showIfFieldName,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      requiredIfLogicCheckbox:
      requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,

    );
  }

  @override
  List<Object?> get props => super.props..addAll([maxLength, minLength]);

  @override
  Widget toWidget() {
    // TODO: implement toWidget
    throw UnimplementedError();
  }


}
