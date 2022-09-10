import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/data/responses/forms/matrix_response/matrix_response.dart';
import 'package:datalines/data/responses/forms/node_response/node_response.dart';
import 'package:datalines/domain/model/checkbox_group_item_model/checkbox_group_item_model.dart';
import 'package:datalines/domain/model/checkbox_group_model/checkbox_group_model.dart';
import 'package:datalines/domain/model/dropdown_item_model/dropdown_item_model.dart';
import 'package:datalines/domain/model/dropdown_model/dropdown_model.dart';
import 'package:datalines/domain/model/email_text_field_model/email_text_field_model.dart';
import 'package:datalines/domain/model/file_picker_model/file_picker_model.dart';
import 'dart:developer';
import 'package:datalines/data/mapper/matrix_mappers.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/domain/model/number_text_field_model/number_text_field_model.dart';
import 'package:datalines/domain/model/radio_group_item_model/radio_group_item_model.dart';
import 'package:datalines/domain/model/radio_group_model/radio_group_model.dart';
import 'package:datalines/domain/model/star_rating_model/star_rating_model.dart';
import 'package:datalines/domain/model/text_area_model/text_area_model.dart';
import 'package:datalines/domain/model/text_field_model/text_field_model.dart';
import 'package:datalines/app/extenstions.dart';

import '../../domain/model/node/node.dart';
import '../responses/forms/enums.dart';

extension TextFieldMapper on TextFieldResponse? {
  TextFieldModel toDomain() {
    return TextFieldModel(
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
    );
  }
}

extension EmailTextFieldMapper on EmailTextFieldResponse? {
  EmailTextFieldModel toDomain() {
    return EmailTextFieldModel(
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
    );
  }
}

extension TextAreaMapper on TextAreaFieldResponse? {
  TextAreaModel toDomain() {
    return TextAreaModel(
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
      maxLength: this?.maxLength.orZero() ?? 0,
      minLength: this?.minLength.orZero() ?? 0,
    );
  }
}

extension StarRatingMapper on StarRatingFieldResponse? {
  StarRatingModel toDomain() {
    return StarRatingModel(
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
    );
  }
}

extension NumberTextFieldMapper on NumberFieldResponse? {
  NumberFieldModel toDomain() {
    return NumberFieldModel(
        name: this?.name.orEmpty() ?? '',
        label: this?.label.orEmpty() ?? '',
        type: this?.type ?? FieldType.UNKNOWN,
        deactivate: this?.deactivate ?? false,
        required: this?.required ?? false,
        isHidden: this?.isHidden ?? false,
        isReadOnly: this?.isReadOnly ?? false,
        showIfLogicCheckbox: this?.showIfLogicCheckbox ?? false,
        showIfIsRequired: this?.showIfIsRequired ?? false,
        requiredIfLogicCheckbox: this?.requiredIfLogicCheckbox ?? false,
        expressionsValue: this?.expressionsValue,
        expressionsValue2: this?.expressionsValue2,
        operator: this?.operator,
        showIfFieldName: this?.showIfFieldName.orEmpty() ?? '',
        showIfFieldValue: this?.showIfFieldValue.orEmpty() ?? '');
  }
}

extension FilerPickerMapper on FilePickerFieldResponse? {
  FilePickerModel toDomain() {
    return FilePickerModel(
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
      fileType: this?.fileType ?? FileType.CUSTOM,
      maxFileSize: this?.maxFileSize.orZero() ?? 0,
    );
  }
}

extension CheckboxGroupMapper on CheckboxGroupFieldResponse? {
  CheckboxGroupModel toDomain() {
    return CheckboxGroupModel(
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
        other: this?.other ?? false,
        minMaxCheckbox: this?.minMaxCheckbox ?? false,
        checkboxMaxValue: this?.checkboxMaxValue.orZero() ?? 0,
        checkboxMinValue: this?.checkboxMinValue.orZero() ?? 0,
        values: this?.values?.map((e) => e.toDomain()).toList() ?? []);
  }
}

extension CheckboxGroupItemMapper on CheckboxGroupItemResponse? {
  CheckboxGroupItemModel toDomain() {
    return CheckboxGroupItemModel(
        label: this?.label.orEmpty() ?? '',
        value: this?.value.orEmpty() ?? '',
        parent: this?.parent.orEmpty() ?? '',
        status: this?.status.orEmpty() ?? '');
  }
}

extension DropDownItemMapper on DropDownItemResponse? {
  DropDownItemModel toDomain() {
    return DropDownItemModel(
        label: this?.label.orEmpty() ?? '',
        value: this?.value.orEmpty() ?? '',
        parent: this?.parent.orEmpty() ?? '',
        status: this?.status.orEmpty() ?? '');
  }
}

extension RadioGroupItemMapper on RadioGroupItemResponse? {
  RadioGroupItemModel toDomain() {
    return RadioGroupItemModel(
        label: this?.label.orEmpty() ?? '',
        value: this?.value.orEmpty() ?? '',
        parent: this?.parent.orEmpty() ?? '',
        status: this?.status.orEmpty() ?? '');
  }
}

extension RadioGroupMapper on RadioGroupFieldResponse? {
  RadioGroupModel toDomain() {
    return RadioGroupModel(
      name: this?.name.orEmpty() ?? '',
      label: this?.label.orEmpty() ?? '',
      type: this?.type ?? FieldType.UNKNOWN,
      deactivate: this?.deactivate ?? false,
      required: this?.required ?? false,
      isHidden: this?.isHidden ?? false,
      isReadOnly: this?.isReadOnly ?? false,
      showIfLogicCheckbox: this?.showIfLogicCheckbox ?? false,
      showIfIsRequired: this?.showIfIsRequired ?? false,
      requiredIfLogicCheckbox: this?.requiredIfLogicCheckbox ?? false,
      other: this?.other ?? false,
      values: this?.values?.map((e) => e.toDomain()).toList() ?? [],
      showIfFieldName: this?.showIfFieldName.orEmpty() ?? '',
      showIfFieldValue: this?.showIfFieldValue.orEmpty() ?? '',
    );
  }
}

extension DropDownMapper on DropDownFieldResponse? {
  DropDownModel toDomain() {
    return DropDownModel(
      name: this?.name.orEmpty() ?? '',
      label: this?.label.orEmpty() ?? '',
      type: this?.type ?? FieldType.UNKNOWN,
      deactivate: this?.deactivate ?? false,
      required: this?.required ?? false,
      isHidden: this?.isHidden ?? false,
      isReadOnly: this?.isReadOnly ?? false,
      showIfLogicCheckbox: this?.showIfLogicCheckbox ?? false,
      showIfIsRequired: this?.showIfIsRequired ?? false,
      requiredIfLogicCheckbox: this?.requiredIfLogicCheckbox ?? false,
      values: this?.values?.map((e) => e.toDomain()).toList() ?? [],
      relatedListCheckbox: this?.relatedListCheckbox ?? false,
      multiple: this?.multiple ?? false,
      prompt: this?.prompt.orEmpty() ?? '',
      relatedListFieldName: this?.relatedListFieldName.orEmpty() ?? '',
      showIfFieldName: this?.showIfFieldName.orEmpty() ?? '',
      showIfFieldValue: this?.showIfFieldValue.orEmpty() ?? '',
    );
  }
}

extension MatrixMapper on MatrixResponse? {
  MatrixModel toDomain() {
    log(this!.values.toString());

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
      values: this?.values.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension FormMapper on FormResponse? {
  FormModel toDomain() {
    return FormModel(
        name: this?.name.orEmpty() ?? '',
        directionality: this?.directionality.orEmpty() ?? '',
        fields: this?.fields?.map((e) => e.toDomain()).toList() ?? []);
  }
}

extension FormFieldMapper on FormFieldResponse? {
  FormFieldModel toDomain() {
    var field = _getModelField(this);
    return field;
  }
}

FormFieldModel _getModelField(FormFieldResponse? formFieldResponse) {
  switch (formFieldResponse.runtimeType) {
    case DropDownFieldResponse:
      return (formFieldResponse as DropDownFieldResponse).toDomain();

    case CheckboxGroupFieldResponse:
      return (formFieldResponse as CheckboxGroupFieldResponse).toDomain();

    case RadioGroupFieldResponse:
      return (formFieldResponse as RadioGroupFieldResponse).toDomain();

    case TextFieldResponse:
      return (formFieldResponse as TextFieldResponse).toDomain();

    case NumberFieldResponse:
      return (formFieldResponse as NumberFieldResponse).toDomain();

    case EmailTextFieldResponse:
      return (formFieldResponse as EmailTextFieldResponse).toDomain();

    case TextAreaFieldResponse:
      return (formFieldResponse as TextAreaFieldResponse).toDomain();

    case FilePickerFieldResponse:
      return (formFieldResponse as FilePickerFieldResponse).toDomain();

    case StarRatingFieldResponse:
      return (formFieldResponse as StarRatingFieldResponse).toDomain();

    case MatrixResponse:
      // log('MatrixResponse');
      return (formFieldResponse as MatrixResponse).toDomain();

    default:
      throw UnimplementedError('cant map to domain');
  }
}

extension AssignedFormMapper on AssignedFormsResponse? {
  AssignedForms toDomain() {
    return AssignedForms(this?.data?.map((e) => e.toDomain()).toList());
  }
}

extension NodeResponseMapper on NodeBaseResponse? {
  List<Node> toDomain() {
    return this?.data?.map((e) => e.toDomain()).toList() ?? [];
  }
}

extension NodeMapper on NodeResponse? {
  Node toDomain() {
    return Node(
      name: this?.name.orEmpty() ?? '',
      id: this?.id.orEmpty() ?? '',
    );
  }
}
