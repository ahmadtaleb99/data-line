import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/data/responses/forms/forms_response.dart';
import 'package:form_builder_test/domain/model/checkbox_group_model/checkbox_group_model.dart';
import 'package:form_builder_test/domain/model/dropdown_model/dropdown_model.dart';
import 'package:form_builder_test/domain/model/email_text_field_model/email_text_field_model.dart';
import 'package:form_builder_test/domain/model/file_picker_model/file_picker_model.dart';

import 'package:form_builder_test/domain/model/file_picker_model/file_picker_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:form_builder_test/domain/model/number_text_field_model/number_text_field_model.dart';
import 'package:form_builder_test/domain/model/radio_group_model/radio_group_model.dart';
import 'package:form_builder_test/domain/model/star_rating_model/star_rating_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/responses/forms/enums.dart';
import '../../presentation/resources/strings_manager.dart';
import 'text_area_model/text_area_model.dart';
import 'text_field_model/text_field_model.dart';


part 'form_model.g.dart';

@HiveType(typeId: 15)
class AssignedForms with EquatableMixin {

  @HiveField(1)
  List<FormModel>? data;

  AssignedForms(this.data);

  @override
  List<Object?> get props => [data];
}


@HiveType(typeId: 14)
class FormModel with EquatableMixin {

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String directionality;

  @HiveField(3)
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
      fields: fields ?? this.fields.map((dynamic e) => e.copyWith()).toList().cast(),
    );
  }
}
extension xFormModel on FormModel {
  FormFieldModel getField(String fieldName) => this.fields.firstWhere((element) => element.name == fieldName);
  List<DropDownModel> getRelatedDropDownsFor(
      String fieldName) {
    return this.fields
        .where((element) => (element is DropDownModel &&
        element.relatedListCheckbox == true &&
        element.relatedListFieldName == fieldName))
        .toList()
        .cast();
  }

  List<DropDownModel> getChildrenDropDowns(){
    return fields.where((element) => element is DropDownModel && element.relatedListCheckbox == true).toList().cast();
  }


  bool hasType(FieldType fieldType) {
    return fields.any((field) => field.type == fieldType);
  }
}

@HiveType(typeId: 13)
 class FormFieldModel with EquatableMixin {


  Widget toWidget(

      ) {
    return Text('ads');
  }

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String label;

  @HiveField(3)
  final FieldType type;


  @HiveField(4)
  final bool deactivate;

  @HiveField(5)
  final bool required;

  @HiveField(6)
  final bool isHidden;

  @HiveField(7)
  final bool isReadOnly;

  @HiveField(8)
  final bool showIfLogicCheckbox;

  @HiveField(9)
  final bool showIfIsRequired;

  @HiveField(10)
  final bool requiredIfLogicCheckbox;

    @HiveField(11)
  final  String showIfFieldName;

    @HiveField(12)
  final  String showIfFieldValue;


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
    required this.showIfFieldName,
    required this.showIfFieldValue,
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
    showIfFieldName,
    showIfFieldValue,
    requiredIfLogicCheckbox,
      ];

  FormFieldModel copyWith({
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
      showIfFieldName: showIfFieldName ?? this.showIfFieldName,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      requiredIfLogicCheckbox:
          requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,
    );
  }
}




extension xFormFieldModel on FormFieldModel{
    String getHintName(){
      switch (this.runtimeType){
        case CheckboxGroupModel:
          return AppStrings.checkgroupBoxHint;

        case RadioGroupModel:
          return AppStrings.radioGroupBoxHint;

        case DropDownModel:
          return AppStrings.dropdownHint;

        case EmailTextFieldModel:
          return AppStrings.emailHint;

        case NumberFieldModel:
          return AppStrings.numberHint;

          case FilePickerModel:
          return AppStrings.fileHint;

        case StarRatingModel:
          return AppStrings.starRatingHint;

        case TextAreaModel:
          return AppStrings.textAreaHint;

        case TextFieldModel:
          return AppStrings.textFieldHint;

           case MatrixModel:
          return AppStrings.matrixHint;


        default:
          return AppStrings.unknown;



      }
    }

}










@HiveType(typeId: 17)
class Submission extends HiveObject with EquatableMixin{


  Map<String, dynamic> $toMap(){
    Map<String, dynamic> map =  {};
   fieldEntries.forEach((FieldEntry fieldEntry) {

     log('   fieldEntries.forEach((FieldEntry fieldEntry) {'+fieldEntry.value.runtimeType.toString());
      map[fieldEntry.name] = fieldEntry.value;
    });
   return map;
  }


    @HiveField(1)
    final String formName;

    @HiveField(2)
    final List<FieldEntry> fieldEntries;

    @HiveField(3)
     final int? id;


  Submission( {

     this.id  ,
    required this.formName  ,
    required this.fieldEntries,
  });

  @override
  String toString() {
    return 'Submission{formName: $formName, fieldEntries: $fieldEntries}';
  }

  Submission copyWith({

    String? formName  ,
    int? id  ,
    List<FieldEntry>? fieldEntries,
    FieldType? type,

  }) {
    return Submission(
      formName: formName ?? this.formName,
      id: id ?? this.id,
      fieldEntries: fieldEntries ?? this.fieldEntries,


    );
  }

  @override
  List<Object?> get props => [formName,id,fieldEntries];




}

@HiveType(typeId: 18)
class FieldEntry extends Equatable{

  @HiveField(1)
  final String name;

  @HiveField(2)
  final dynamic value;

   @HiveField(3)
  final FieldType type;


  const FieldEntry({
    required this.name,
    required this.value,
    required this.type,
  });



  @override
  List<Object?> get props => [name,value,type];

  FieldEntry copyWith({
    String? name,
    dynamic? value,
    FieldType? type,
  }) {
    return FieldEntry(
      name: name ?? this.name,
      value: value ?? this.value,
      type: type ?? this.type,
    );
  }
}