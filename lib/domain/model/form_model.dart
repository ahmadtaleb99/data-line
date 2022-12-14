import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:datalines/data/responses/forms/forms_response.dart';
import 'package:datalines/domain/model/checkbox_group_model/checkbox_group_model.dart';
import 'package:datalines/domain/model/dropdown_model/dropdown_model.dart';
import 'package:datalines/domain/model/email_text_field_model/email_text_field_model.dart';
import 'package:datalines/domain/model/file_picker_model/file_picker_model.dart';
import 'package:datalines/domain/model/node/node.dart';

import 'package:datalines/domain/model/file_picker_model/file_picker_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:datalines/domain/model/number_text_field_model/number_text_field_model.dart';
import 'package:datalines/domain/model/radio_group_model/radio_group_model.dart';
import 'package:datalines/domain/model/star_rating_model/star_rating_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../data/responses/forms/enums.dart';
import '../../presentation/resources/strings_manager.dart';
import 'text_area_model/text_area_model.dart';
import 'text_field_model/text_field_model.dart';


part 'form_model.g.dart';


class SyncForm {
 final bool hasSubmitPermission;

 const SyncForm({
    required this.hasSubmitPermission,
  });
}

class FormsHomeModel {
  final List<FormModel> forms;
  final List<Node> nodes;

  const FormsHomeModel({
    required this.forms,
    required this.nodes,
  });
}

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


  @HiveField(4)
  final String id;

  const FormModel({
    required this.name,
    required this.directionality,
    required this.fields,
    required this.id,
  });

  @override
  List<Object?> get props => [id,name, directionality, fields];

  FormModel copyWith({
    String? name,
    String? directionality,
    String? id,
    List<FormFieldModel>? fields,
  }) {
    return FormModel(
      name: name ?? this.name,
      id: id ?? this.id,
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


  Map<String, dynamic> entriesAsMap(){
    Map<String, dynamic> map =  {};
   fieldEntries.forEach((FieldEntry fieldEntry) {

     log('   fieldEntries.forEach((FieldEntry fieldEntry) {'+fieldEntry.value.runtimeType.toString());
      map[fieldEntry.name] = fieldEntry.value;
    });
   return map;
  }


    @HiveField(1)
    final String formId;

    @HiveField(2)
    final List<FieldEntry> fieldEntries;

    @HiveField(3)
     final int? id;

    @HiveField(4)
     final Node node;


    @HiveField(5)
    final DateTime submittedAt;

  @HiveField(6)
  final DateTime? updatedAt;


  Submission( {

     this.id  ,
    required this.formId  ,
    required this.fieldEntries,
    required this.node,
    required this.submittedAt,
     this.updatedAt,

  });




  Future<Map<String, dynamic>> entriesToRequest() async{
    Map<String, dynamic> map =  {};

    for (FieldEntry fieldEntry in fieldEntries)  {
      if(fieldEntry.value != null) {
        if(fieldEntry.type == FieldType.FILE) {
          map[fieldEntry.name] =  await MultipartFile.fromFile(fieldEntry.value);

          log((map[fieldEntry.name] as MultipartFile).length.toString()+ 'map[fieldEntry.name] length');
          log(map[fieldEntry.name].toString() );

        }

        else  map[fieldEntry.name] = fieldEntry.value;

      }
    }

    return map;
  }


  Submission copyWith({

    String? formName  ,
    int? id  ,
    List<FieldEntry>? fieldEntries,
    FieldType? type,
    Node? node,
    DateTime? submittedAt,
    DateTime? updatedAt

  }) {
    return Submission(
      formId: formName ?? this.formId,
      id: id ?? this.id,
      fieldEntries: fieldEntries ?? this.fieldEntries,
      node: node ?? this.node,
      submittedAt: submittedAt ?? this.submittedAt,
      updatedAt: updatedAt ?? this.updatedAt,


    );
  }

  @override
  List<Object?> get props => [submittedAt,updatedAt,node,formId,id,fieldEntries];




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