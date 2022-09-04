// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forms_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignedFormsResponse _$AssignedFormsResponseFromJson(
        Map<String, dynamic> json) =>
    AssignedFormsResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => FormResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AssignedFormsResponseToJson(
        AssignedFormsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };


Map<String, dynamic> _$FormResponseToJson(FormResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'directionality': instance.directionality,
      'fields': instance.fields,
    };

FormFieldResponse _$FormFieldResponseFromJson(Map<String, dynamic> json) =>
    FormFieldResponse()
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$FormFieldResponseToJson(FormFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
    };

const _$FieldTypeEnumMap = {
  FieldType.TEXT: 'text',
  FieldType.TEXT_AREA: 'textarea',
  FieldType.NUMBER: 'number',
  FieldType.EMAIL: 'email',
  FieldType.DROPDOWN: 'select',
  FieldType.STAR_RATING: 'starrating',
  FieldType.CHECKBOX_GROUP: 'checkbox-group',
  FieldType.CHECKBOX: 'checkbox',
  FieldType.RADIO_GROUP: 'radio-group',
  FieldType.FILE: 'file',
  FieldType.MATRIX: 'matrix',
  FieldType.DATE: 'date',
  FieldType.UNKNOWN: 'UNKNOWN',
};

TextFieldResponse _$TextFieldResponseFromJson(Map<String, dynamic> json) =>
    TextFieldResponse(
      json['unique'] as bool?,
    )
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$TextFieldResponseToJson(TextFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
      'unique': instance.unique,
    };

EmailTextFieldResponse _$EmailTextFieldResponseFromJson(
        Map<String, dynamic> json) =>
    EmailTextFieldResponse()
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$EmailTextFieldResponseToJson(
        EmailTextFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
    };

TextAreaFieldResponse _$TextAreaFieldResponseFromJson(
        Map<String, dynamic> json) =>
    TextAreaFieldResponse(
      json['minLength'] as int?,
      json['maxLength'] as int?,
    )
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$TextAreaFieldResponseToJson(
        TextAreaFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
      'minLength': instance.minLength,
      'maxLength': instance.maxLength,
    };

NumberFieldResponse _$NumberFieldResponseFromJson(Map<String, dynamic> json) =>
    NumberFieldResponse(
      $enumDecodeNullable(_$OperatorEnumMap, json['operator']),
      json['expressionsValue'] as int?,
    )
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?
      ..expressionsValue2 = json['expressionsValue2'] as int?;

Map<String, dynamic> _$NumberFieldResponseToJson(
        NumberFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
      'operator': _$OperatorEnumMap[instance.operator],
      'expressionsValue': instance.expressionsValue,
      'expressionsValue2': instance.expressionsValue2,
    };

const _$OperatorEnumMap = {
  Operator.MORE: 'more',
  Operator.LESS: 'less',
  Operator.EQUAL: 'equal',
  Operator.BETWEEN: 'between',
};

CheckboxGroupFieldResponse _$CheckboxGroupFieldResponseFromJson(
        Map<String, dynamic> json) =>
    CheckboxGroupFieldResponse(
      json['other'] as bool?,
      json['minMaxCheckbox'] as bool?,
      json['checkboxMinValue'] as int?,
      json['checkboxMaxValue'] as int?,
      (json['values'] as List<dynamic>?)
          ?.map((e) =>
              CheckboxGroupItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$CheckboxGroupFieldResponseToJson(
        CheckboxGroupFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
      'other': instance.other,
      'minMaxCheckbox': instance.minMaxCheckbox,
      'checkboxMinValue': instance.checkboxMinValue,
      'checkboxMaxValue': instance.checkboxMaxValue,
      'values': instance.values,
    };

CheckboxGroupItemResponse _$CheckboxGroupItemResponseFromJson(
        Map<String, dynamic> json) =>
    CheckboxGroupItemResponse(
      json['label'] as String?,
      json['value'] as String?,
      json['parent'] as String?,
      json['status'] as String?,
    );

Map<String, dynamic> _$CheckboxGroupItemResponseToJson(
        CheckboxGroupItemResponse instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'parent': instance.parent,
      'status': instance.status,
    };

RadioGroupFieldResponse _$RadioGroupFieldResponseFromJson(
        Map<String, dynamic> json) =>
    RadioGroupFieldResponse(
      json['other'] as bool?,
      (json['values'] as List<dynamic>?)
          ?.map(
              (e) => RadioGroupItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$RadioGroupFieldResponseToJson(
        RadioGroupFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
      'other': instance.other,
      'values': instance.values,
    };

RadioGroupItemResponse _$RadioGroupItemResponseFromJson(
        Map<String, dynamic> json) =>
    RadioGroupItemResponse(
      json['label'] as String?,
      json['value'] as String?,
      json['parent'] as String?,
      json['status'] as String?,
    );

Map<String, dynamic> _$RadioGroupItemResponseToJson(
        RadioGroupItemResponse instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'parent': instance.parent,
      'status': instance.status,
    };

DropDownFieldResponse _$DropDownFieldResponseFromJson(
        Map<String, dynamic> json) =>
    DropDownFieldResponse(
      json['prompt'] as String?,
      json['multiple'] as bool?,
      json['relatedListFieldName'] as String?,
      (json['values'] as List<dynamic>?)
          ?.map((e) => DropDownItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['relatedListCheckbox'] as bool?,
    )
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$DropDownFieldResponseToJson(
        DropDownFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
      'prompt': instance.prompt,
      'multiple': instance.multiple,
      'relatedListCheckbox': instance.relatedListCheckbox,
      'relatedListFieldName': instance.relatedListFieldName,
      'values': instance.values,
    };

DropDownItemResponse _$DropDownItemResponseFromJson(
        Map<String, dynamic> json) =>
    DropDownItemResponse(
      json['label'] as String?,
      json['value'] as String?,
      json['parent'] as String?,
      json['status'] as String?,
    );

Map<String, dynamic> _$DropDownItemResponseToJson(
        DropDownItemResponse instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
      'parent': instance.parent,
      'status': instance.status,
    };

StarRatingFieldResponse _$StarRatingFieldResponseFromJson(
        Map<String, dynamic> json) =>
    StarRatingFieldResponse()
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$StarRatingFieldResponseToJson(
        StarRatingFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
    };

FilePickerFieldResponse _$FilePickerFieldResponseFromJson(
        Map<String, dynamic> json) =>
    FilePickerFieldResponse(
      json['maxFileSize'] as int?,
      $enumDecodeNullable(_$FileTypeEnumMap, json['fileType']),
    )
      ..name = json['name'] as String?
      ..label = json['label'] as String?
      ..type = $enumDecodeNullable(_$FieldTypeEnumMap, json['type'])
      ..deactivate = json['deactivate'] as bool?
      ..required = json['required'] as bool?
      ..isHidden = json['isHidden'] as bool?
      ..isReadOnly = json['isReadOnly'] as bool?
      ..showIfLogicCheckbox = json['showIfLogicCheckbox'] as bool?
      ..showIfFieldName = json['showIfFieldName'] as String?
      ..showIfFieldValue = json['showIfFieldValue'] as String?
      ..showIfIsRequired = json['showIfIsRequired'] as bool?
      ..requiredIfLogicCheckbox = json['requiredIfLogicCheckbox'] as bool?;

Map<String, dynamic> _$FilePickerFieldResponseToJson(
        FilePickerFieldResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'type': _$FieldTypeEnumMap[instance.type],
      'deactivate': instance.deactivate,
      'required': instance.required,
      'isHidden': instance.isHidden,
      'isReadOnly': instance.isReadOnly,
      'showIfLogicCheckbox': instance.showIfLogicCheckbox,
      'showIfFieldName': instance.showIfFieldName,
      'showIfFieldValue': instance.showIfFieldValue,
      'showIfIsRequired': instance.showIfIsRequired,
      'requiredIfLogicCheckbox': instance.requiredIfLogicCheckbox,
      'maxFileSize': instance.maxFileSize,
      'fileType': _$FileTypeEnumMap[instance.fileType],
    };

const _$FileTypeEnumMap = {
  FileType.IMAGE: 'Image',
  FileType.AUDIO: 'Audio',
  FileType.VIDEO: 'Video',
  FileType.CUSTOM: 'CUSTOM',
};
