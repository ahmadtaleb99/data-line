import 'package:form_builder_test/data/responses/forms/enums.dart';
import 'package:form_builder_test/data/responses/forms/matrix_response/matrix_response.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_group_model/matrix_checkbox_group_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_date_picker_model/matrix_date_picker_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_dropdown_model/matrix_dropdown_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/app/extenstions.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_number_model/matrix_number_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_radio_group_model/matrix_radio_group_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_text_field_model/matrix_text_field_model.dart';



extension MatrixMapper on MatrixResponse? {
  MatrixModel toDomain() {
    return MatrixModel(

      name: this?.name.orEmpty() ?? '',
      label: this?.label.orEmpty() ?? '',
      type: this?.type ?? FieldType.UNKNOWN,
      showIfFieldName: this?.showIfFieldName.orEmpty() ?? '',
      showIfFieldValue: this?.showIfFieldValue.orEmpty() ?? '',
      deactivate: this?.deactivate ?? false,
      required: this?.required ?? false,

      isHidden: this?.isHidden ?? false,
      isReadOnly: this?.isReadOnly ?? false,
      showIfLogicCheckbox: this?.showIfLogicCheckbox ?? false,
      showIfIsRequired: this?.showIfIsRequired ?? false,
      requiredIfLogicCheckbox: this?.requiredIfLogicCheckbox ?? false,
      maxRecordsCount: this?.maxRecordsCount.orZero() ?? 0,
      values: this?.values?.map((e) => e.toDomain()).toList() ?? [],

    );
  }
}


extension MatrixFieldMapper on MatrixFieldResponse? {

  MatrixFieldModel toDomain() {
    var field = _getModelField(this);
    return field;
  }
}
MatrixFieldModel _getModelField (MatrixFieldResponse?  matrixFieldResponse){
  switch (matrixFieldResponse.runtimeType) {


    case MatrixDropDownResponse:
      return (matrixFieldResponse as MatrixDropDownResponse).toDomain();


    case MatrixCheckboxGroupResponse:
      return (matrixFieldResponse as MatrixCheckboxGroupResponse).toDomain();

    case MatrixRadioGroupResponse:
      return (matrixFieldResponse as MatrixRadioGroupResponse).toDomain();

    case MatrixTextFieldResponse:
      return (matrixFieldResponse as MatrixTextFieldResponse).toDomain();



    case MatrixNumberResponse:
      return (matrixFieldResponse as MatrixNumberResponse).toDomain();


    case MatrixCheckboxResponse:
      return (matrixFieldResponse as MatrixCheckboxResponse).toDomain();

      case MatrixDatePickerResponse:
      return (matrixFieldResponse as MatrixDatePickerResponse).toDomain();

    default: throw UnimplementedError();
  }
}




extension MultipleOptions on MultipleOptionsResponse? {
  MultipleOptionsModel toDomain() {
    return MultipleOptionsModel(
        label: this?.label.orEmpty() ?? '',
        value: this?.value.orEmpty() ?? '',
    );
  }
}

extension MatrixTextFieldMapper on MatrixTextFieldResponse? {
  MatrixTextFieldModel toDomain() {
    return MatrixTextFieldModel(
      fieldName: this?.fieldName.orEmpty() ?? '',
      label: this?.label.orEmpty() ?? '',
      type: this?.value ?? FieldType.UNKNOWN,
    );
  }
}
extension MatrixNumberMapper on MatrixNumberResponse? {
  MatrixNumberModel toDomain() {
    return MatrixNumberModel(
      fieldName: this?.fieldName.orEmpty() ?? '',
      label: this?.label.orEmpty() ?? '',
      type: this?.value ?? FieldType.UNKNOWN,
    );
  }
}


extension MatrixDatePickerMapper on MatrixDatePickerResponse? {
  MatrixDatePickerModel toDomain() {
    return MatrixDatePickerModel(
      fieldName: this?.fieldName.orEmpty() ?? '',
      label: this?.label.orEmpty() ?? '',
      type: this?.value ?? FieldType.UNKNOWN,
    );
  }
}

extension MatrixCheckboxMapper on MatrixCheckboxResponse? {
  MatrixCheckboxModel toDomain() {
    return MatrixCheckboxModel(
      fieldName: this?.fieldName.orEmpty() ?? '',
      label: this?.label.orEmpty() ?? '',
      type: this?.value ?? FieldType.UNKNOWN,
    );
  }
}



extension MatrixCheckboxGroupMapper on MatrixCheckboxGroupResponse? {
  MatrixCheckboxGroupModel toDomain() {
    return MatrixCheckboxGroupModel(
      fieldName: this?.fieldName.orEmpty() ?? '',
      label: this?.label.orEmpty() ?? '',
      type: this?.value ?? FieldType.UNKNOWN,
        values: this?.values?.map((e) => e.toDomain()).toList() ?? []
    );
  }
}


extension MatrixRadioGroupMapper on MatrixRadioGroupResponse? {
  MatrixRadioGroupModel toDomain() {
    return MatrixRadioGroupModel(
        fieldName: this?.fieldName.orEmpty() ?? '',
        label: this?.label.orEmpty() ?? '',
        type: this?.value ?? FieldType.UNKNOWN,
        values: this?.values?.map((e) => e.toDomain()).toList() ?? []
    );
  }
}



extension MatrixDropDownMapper on MatrixDropDownResponse? {
  MatrixDropDownModel toDomain() {
    return MatrixDropDownModel(
        fieldName: this?.fieldName.orEmpty() ?? '',
        label: this?.label.orEmpty() ?? '',
        type: this?.value ?? FieldType.UNKNOWN,
        values: this?.values?.map((e) => e.toDomain()).toList() ?? []
    );
  }
}