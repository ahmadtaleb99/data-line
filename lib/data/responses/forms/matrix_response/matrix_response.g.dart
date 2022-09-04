// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matrix_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************



Map<String, dynamic> _$MatrixResponseToJson(MatrixResponse instance) =>
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
      'maxRecordsCount': instance.maxRecordsCount,
      'values': instance.values,
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

MatrixFieldResponse _$MatrixFieldResponseFromJson(Map<String, dynamic> json) =>
    MatrixFieldResponse()
      ..fieldName = json['fieldName'] as String?
      ..label = json['label'] as String?
      ..value = $enumDecodeNullable(_$FieldTypeEnumMap, json['value']);

Map<String, dynamic> _$MatrixFieldResponseToJson(
        MatrixFieldResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'value': _$FieldTypeEnumMap[instance.value],
    };

MatrixTextFieldResponse _$MatrixTextFieldResponseFromJson(
        Map<String, dynamic> json) =>
    MatrixTextFieldResponse()
      ..fieldName = json['fieldName'] as String?
      ..label = json['label'] as String?
      ..value = $enumDecodeNullable(_$FieldTypeEnumMap, json['value']);

Map<String, dynamic> _$MatrixTextFieldResponseToJson(
        MatrixTextFieldResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'value': _$FieldTypeEnumMap[instance.value],
    };

MatrixNumberResponse _$MatrixNumberResponseFromJson(
        Map<String, dynamic> json) =>
    MatrixNumberResponse()
      ..fieldName = json['fieldName'] as String?
      ..label = json['label'] as String?
      ..value = $enumDecodeNullable(_$FieldTypeEnumMap, json['value']);

Map<String, dynamic> _$MatrixNumberResponseToJson(
        MatrixNumberResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'value': _$FieldTypeEnumMap[instance.value],
    };

MatrixDatePickerResponse _$MatrixDatePickerResponseFromJson(
        Map<String, dynamic> json) =>
    MatrixDatePickerResponse()
      ..fieldName = json['fieldName'] as String?
      ..label = json['label'] as String?
      ..value = $enumDecodeNullable(_$FieldTypeEnumMap, json['value']);

Map<String, dynamic> _$MatrixDatePickerResponseToJson(
        MatrixDatePickerResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'value': _$FieldTypeEnumMap[instance.value],
    };

MatrixCheckboxResponse _$MatrixCheckboxResponseFromJson(
        Map<String, dynamic> json) =>
    MatrixCheckboxResponse()
      ..fieldName = json['fieldName'] as String?
      ..label = json['label'] as String?
      ..value = $enumDecodeNullable(_$FieldTypeEnumMap, json['value']);

Map<String, dynamic> _$MatrixCheckboxResponseToJson(
        MatrixCheckboxResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'value': _$FieldTypeEnumMap[instance.value],
    };

MultipleOptionsResponse _$MultipleOptionsResponseFromJson(
        Map<String, dynamic> json) =>
    MultipleOptionsResponse(
      json['label'] as String?,
      json['value'] as String?,
    );

Map<String, dynamic> _$MultipleOptionsResponseToJson(
        MultipleOptionsResponse instance) =>
    <String, dynamic>{
      'label': instance.label,
      'value': instance.value,
    };

MatrixRadioGroupResponse _$MatrixRadioGroupResponseFromJson(
        Map<String, dynamic> json) =>
    MatrixRadioGroupResponse(
      (json['multipleOptions'] as List<dynamic>?)
          ?.map((e) =>
              MultipleOptionsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..fieldName = json['fieldName'] as String?
      ..label = json['label'] as String?
      ..value = $enumDecodeNullable(_$FieldTypeEnumMap, json['value']);

Map<String, dynamic> _$MatrixRadioGroupResponseToJson(
        MatrixRadioGroupResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'value': _$FieldTypeEnumMap[instance.value],
      'multipleOptions': instance.values,
    };

MatrixCheckboxGroupResponse _$MatrixCheckboxGroupResponseFromJson(
        Map<String, dynamic> json) =>
    MatrixCheckboxGroupResponse(
      (json['multipleOptions'] as List<dynamic>?)
          ?.map((e) =>
              MultipleOptionsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..fieldName = json['fieldName'] as String?
      ..label = json['label'] as String?
      ..value = $enumDecodeNullable(_$FieldTypeEnumMap, json['value']);

Map<String, dynamic> _$MatrixCheckboxGroupResponseToJson(
        MatrixCheckboxGroupResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'value': _$FieldTypeEnumMap[instance.value],
      'multipleOptions': instance.values,
    };

MatrixDropDownResponse _$MatrixDropDownResponseFromJson(
        Map<String, dynamic> json) =>
    MatrixDropDownResponse(
      (json['multipleOptions'] as List<dynamic>?)
          ?.map((e) =>
              MultipleOptionsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..fieldName = json['fieldName'] as String?
      ..label = json['label'] as String?
      ..value = $enumDecodeNullable(_$FieldTypeEnumMap, json['value']);

Map<String, dynamic> _$MatrixDropDownResponseToJson(
        MatrixDropDownResponse instance) =>
    <String, dynamic>{
      'fieldName': instance.fieldName,
      'label': instance.label,
      'value': _$FieldTypeEnumMap[instance.value],
      'multipleOptions': instance.values,
    };
