import 'package:form_builder_test/data/responses/forms/enums.dart';
import 'package:form_builder_test/data/responses/forms/matrix_response/matrix_response.dart';
import 'package:form_builder_test/data/responses/responses.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'forms_response.g.dart';

FormFieldResponse? _getFieldFromType(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'select':
      return DropDownFieldResponse.fromJson(json);

    case 'text':
      return TextFieldResponse.fromJson(json);

    case 'textarea':
      return TextAreaFieldResponse.fromJson(json);
    case 'number':
      return NumberFieldResponse.fromJson(json);

    case 'email':
      return EmailTextFieldResponse.fromJson(json);

    case 'radio-group':
      return RadioGroupFieldResponse.fromJson(json);

    case 'file':
      return FilePickerFieldResponse.fromJson(json);

    case 'checkbox-group':
      return CheckboxGroupFieldResponse.fromJson(json);

    case 'starrating':
      return StarRatingFieldResponse.fromJson(json);

    case 'matrix':
      return MatrixResponse.fromJson(json);
    default:
      return null;
  }
}

@JsonSerializable()
class AssignedFormsResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<FormResponse>? data;

  AssignedFormsResponse(this.data);

  factory AssignedFormsResponse.fromJson(Map<String, dynamic> json) =>
      _$AssignedFormsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AssignedFormsResponseToJson(this);
}

@JsonSerializable()
class FormResponse {
  String? name;

  String? directionality;

  List<FormFieldResponse>? fields;

  factory FormResponse.fromJson(Map<String, dynamic> json) {
    return FormResponse(
      json['name'] as String?,
      json['directionality'] as String?,
      (json['fields'] as List<dynamic>?)
          ?.map((e) => _getFieldFromType(e)!)
          .toList(),
    );
  }

  FormResponse(this.name, this.directionality, this.fields);
}

@JsonSerializable()
class FormFieldResponse {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'label')
  String? label;

  @JsonEnum()
  FieldType? type;

  @JsonKey(name: 'deactivate')
  bool? deactivate;

  @JsonKey(name: 'required')
  bool? required;

  @JsonKey(name: 'isHidden')
  bool? isHidden;

  @JsonKey(name: 'isReadOnly')
  bool? isReadOnly;

  @JsonKey(name: 'showIfLogicCheckbox')
  bool? showIfLogicCheckbox;

  @JsonKey(name: 'showIfFieldName')
  String? showIfFieldName;

  @JsonKey(name: 'showIfFieldValue')
  String? showIfFieldValue;

  @JsonKey(name: 'showIfIsRequired')
  bool? showIfIsRequired;

  @JsonKey(name: 'requiredIfLogicCheckbox')
  bool? requiredIfLogicCheckbox;
}

@JsonSerializable()
class TextFieldResponse extends FormFieldResponse {
  @JsonKey(name: 'unique')
  bool? unique;

  TextFieldResponse(this.unique);

  factory TextFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$TextFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TextFieldResponseToJson(this);
}

@JsonSerializable()
class EmailTextFieldResponse extends FormFieldResponse {
  factory EmailTextFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$EmailTextFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$EmailTextFieldResponseToJson(this);

  EmailTextFieldResponse();
}

@JsonSerializable()
class TextAreaFieldResponse extends FormFieldResponse {
  @JsonKey(name: 'minLength')
  int? minLength;

  @JsonKey(name: 'maxLength')
  int? maxLength;

  TextAreaFieldResponse(this.minLength, this.maxLength);

  factory TextAreaFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$TextAreaFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TextAreaFieldResponseToJson(this);
}

@JsonSerializable()
class NumberFieldResponse extends FormFieldResponse {

  @JsonEnum()
  Operator? operator;

  @JsonKey(name: 'expressionsValue')
  int? expressionsValue;

  @JsonKey(name: 'expressionsValue2')
  int? expressionsValue2;

  factory NumberFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$NumberFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NumberFieldResponseToJson(this);

  NumberFieldResponse(this.operator, this.expressionsValue);
}

@JsonSerializable()
class CheckboxGroupFieldResponse extends FormFieldResponse {
  @JsonKey(name: 'other')
  bool? other;

  @JsonKey(name: 'minMaxCheckbox')
  bool? minMaxCheckbox;

  @JsonKey(name: 'checkboxMinValue')
  int? checkboxMinValue;

  CheckboxGroupFieldResponse(this.other, this.minMaxCheckbox,
      this.checkboxMinValue, this.checkboxMaxValue, this.values);

  @JsonKey(name: 'checkboxMaxValue')
  int? checkboxMaxValue;

  @JsonKey(name: 'values')
  List<CheckboxGroupItemResponse>? values;

  factory CheckboxGroupFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckboxGroupFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckboxGroupFieldResponseToJson(this);
}

@JsonSerializable()
class CheckboxGroupItemResponse {
  @JsonKey(name: 'label')
  String? label;

  @JsonKey(name: 'value')
  String? value;

  @JsonKey(name: 'parent')
  String? parent;

  @JsonKey(name: 'status')
  String? status;

  CheckboxGroupItemResponse(this.label, this.value, this.parent, this.status);

  factory CheckboxGroupItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckboxGroupItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckboxGroupItemResponseToJson(this);
}

@JsonSerializable()
class RadioGroupFieldResponse extends FormFieldResponse {
  @JsonKey(name: 'other')
  bool? other;

  @JsonKey(name: 'values')
  List<RadioGroupItemResponse>? values;

  RadioGroupFieldResponse(this.other, this.values);

  factory RadioGroupFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$RadioGroupFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RadioGroupFieldResponseToJson(this);
}

@JsonSerializable()
class RadioGroupItemResponse {
  @JsonKey(name: 'label')
  String? label;

  @JsonKey(name: 'value')
  String? value;

  @JsonKey(name: 'parent')
  String? parent;

  @JsonKey(name: 'status')
  String? status;

  RadioGroupItemResponse(this.label, this.value, this.parent, this.status);

  factory RadioGroupItemResponse.fromJson(Map<String, dynamic> json) =>
      _$RadioGroupItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RadioGroupItemResponseToJson(this);
}

@JsonSerializable()
class DropDownFieldResponse extends FormFieldResponse {
  @JsonKey(name: 'prompt')
  String? prompt;

  @JsonKey(name: 'multiple')
  bool? multiple;

  @JsonKey(name: 'relatedListCheckbox')
  bool? relatedListCheckbox;

  @JsonKey(name: 'relatedListFieldName')
  String? relatedListFieldName;

  DropDownFieldResponse(this.prompt, this.multiple, this.relatedListFieldName,
      this.values, this.relatedListCheckbox);

  @JsonKey(name: 'values')
  List<DropDownItemResponse>? values;

  factory DropDownFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$DropDownFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DropDownFieldResponseToJson(this);
}

@JsonSerializable()
class DropDownItemResponse {
  @JsonKey(name: 'label')
  String? label;

  @JsonKey(name: 'value')
  String? value;

  DropDownItemResponse(this.label, this.value, this.parent, this.status);

  @JsonKey(name: 'parent')
  String? parent;

  @JsonKey(name: 'status')
  String? status;

  factory DropDownItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DropDownItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DropDownItemResponseToJson(this);
}

@JsonSerializable()
class StarRatingFieldResponse extends FormFieldResponse {
  factory StarRatingFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$StarRatingFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StarRatingFieldResponseToJson(this);

  StarRatingFieldResponse();
}

@JsonSerializable()
class FilePickerFieldResponse extends FormFieldResponse {
  @JsonKey(name: 'maxFileSize')
  int? maxFileSize;

  @JsonEnum()
  FileType? fileType;

  FilePickerFieldResponse(this.maxFileSize, this.fileType);

  factory FilePickerFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$FilePickerFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FilePickerFieldResponseToJson(this);
}

