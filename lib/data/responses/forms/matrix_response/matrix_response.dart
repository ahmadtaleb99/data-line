import 'package:form_builder_test/data/responses/forms/forms_response.dart';
import 'package:json_annotation/json_annotation.dart';

import '../enums.dart';
part 'matrix_response.g.dart';
MatrixFieldResponse? _getMatrixFieldFromType(Map<String, dynamic> json) {
  switch (json['value']) {
    case 'select':
      return MatrixDropDownResponse.fromJson(json);

    case 'text':
      return MatrixTextFieldResponse.fromJson(json);


    case 'number':
      return MatrixNumberResponse.fromJson(json);

    case 'radio-group':
      return MatrixRadioGroupResponse.fromJson(json);


    case 'checkbox-group':
      return MatrixCheckboxResponse.fromJson(json);

    case 'date':
      return MatrixDatePickerResponse.fromJson(json);


    default:
      return null;
  }
}

MatrixResponse _MatrixResponseFromJson(Map<String, dynamic> json) =>
    MatrixResponse(
      json['maxRecordsCount'] as int?,
      (json['values'] as List<dynamic>? )!.map((e) => _getMatrixFieldFromType(e)).toList().cast()
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
@JsonSerializable()
class MatrixResponse extends FormFieldResponse {


  @JsonKey(name: 'maxRecordsCount')
  int? maxRecordsCount;
  @JsonKey(name: 'values')
  List<MatrixFieldResponse> values;



  factory MatrixResponse.fromJson(Map<String, dynamic> json) =>
      _MatrixResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatrixResponseToJson(this);

  MatrixResponse(this.maxRecordsCount,this.values);
}



@JsonSerializable()
class MatrixFieldResponse {
  @JsonKey(name: 'fieldName')
  String? fieldName;

  @JsonKey(name: 'label')
  String? label;

  @JsonEnum()
  FieldType? value;



}



@JsonSerializable()
class MatrixTextFieldResponse extends MatrixFieldResponse {


  factory MatrixTextFieldResponse.fromJson(Map<String, dynamic> json) =>
      _$MatrixTextFieldResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatrixTextFieldResponseToJson(this);

  MatrixTextFieldResponse();
}




@JsonSerializable()
class MatrixNumberResponse extends MatrixFieldResponse {


  factory MatrixNumberResponse.fromJson(Map<String, dynamic> json) =>
      _$MatrixNumberResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatrixNumberResponseToJson(this);

  MatrixNumberResponse();
}

@JsonSerializable()
class MatrixDatePickerResponse extends MatrixFieldResponse {


  factory MatrixDatePickerResponse.fromJson(Map<String, dynamic> json) =>
      _$MatrixDatePickerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatrixDatePickerResponseToJson(this);

  MatrixDatePickerResponse();
}



@JsonSerializable()
class MatrixCheckboxResponse extends MatrixFieldResponse {


  factory MatrixCheckboxResponse.fromJson(Map<String, dynamic> json) =>
      _$MatrixCheckboxResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatrixCheckboxResponseToJson(this);

  MatrixCheckboxResponse();
}


@JsonSerializable()
class MultipleOptionsResponse {
  @JsonKey(name: 'label')
  String? label;

  @JsonKey(name: 'value')
  String? value;

  MultipleOptionsResponse(this.label, this.value);

  factory MultipleOptionsResponse.fromJson(Map<String, dynamic> json) =>
      _$MultipleOptionsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MultipleOptionsResponseToJson(this);
}

@JsonSerializable()
class MatrixRadioGroupResponse extends MatrixFieldResponse {
  @JsonKey(name: 'multipleOptions')
  List<MultipleOptionsResponse>? values;

  MatrixRadioGroupResponse(this.values);

  factory MatrixRadioGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$MatrixRadioGroupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatrixRadioGroupResponseToJson(this);
}

@JsonSerializable()
class MatrixCheckboxGroupResponse extends MatrixFieldResponse {
  @JsonKey(name: 'multipleOptions')
  List<MultipleOptionsResponse>? values;

  MatrixCheckboxGroupResponse(this.values);

  factory MatrixCheckboxGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$MatrixCheckboxGroupResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatrixCheckboxGroupResponseToJson(this);
}


@JsonSerializable()
class MatrixDropDownResponse extends MatrixFieldResponse {
  @JsonKey(name: 'multipleOptions')
  List<MultipleOptionsResponse>? values;

  MatrixDropDownResponse(this.values);

  factory MatrixDropDownResponse.fromJson(Map<String, dynamic> json) =>
      _$MatrixDropDownResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MatrixDropDownResponseToJson(this);
}

