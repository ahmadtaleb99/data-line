import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/data/responses/forms/forms_response.dart';
import 'package:form_builder_test/domain/model/dropdown_model/dropdown_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';


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
  List<DropDownModel> getRelatedDropDowns(
      String fieldName) {
    return this.fields
        .where((element) => (element is DropDownModel &&
        element.relatedListCheckbox == true &&
        element.relatedListFieldName == fieldName))
        .toList()
        .cast();
  }

}

@HiveType(typeId: 13)
abstract class FormFieldModel with EquatableMixin {


  Widget toWidget();

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
    requiredIfLogicCheckbox,
      ];

  // FormFieldModel copyWith({
  //   String? name,
  //   String? label,
  //   FieldType? type,
  //   bool? deactivate,
  //   bool? required,
  //   bool? isHidden,
  //   bool? isReadOnly,
  //   bool? showIfLogicCheckbox,
  //   bool? showIfIsRequired,
  //   bool? requiredIfLogicCheckbox,
  // }) {
  //   return FormFieldModel(
  //     name: name ?? this.name,
  //     label: label ?? this.label,
  //     type: type ?? this.type,
  //     deactivate: deactivate ?? this.deactivate,
  //     required: required ?? this.required,
  //     isHidden: isHidden ?? this.isHidden,
  //     isReadOnly: isReadOnly ?? this.isReadOnly,
  //     showIfLogicCheckbox: showIfLogicCheckbox ?? this.showIfLogicCheckbox,
  //     showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
  //     requiredIfLogicCheckbox:
  //         requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,
  //   );
  // }
}

@HiveType(typeId: 16)
enum FieldType {

  @HiveField(1)
  @JsonValue('text')
  TEXT,


  @HiveField(2)
  @JsonValue('textarea')
  TEXT_AREA,


  @HiveField(3)
  @JsonValue('number')
  NUMBER,



  @HiveField(4)
  @JsonValue('email')
  EMAIL,


  @HiveField(5)
  @JsonValue('select')
  DROPDOWN,


  @HiveField(6)
  @JsonValue('starrating')
  STAR_RATING,


  @HiveField(7)
  @JsonValue('checkbox-group')
  CHECKBOX_GROUP,


  @HiveField(8)
  @JsonValue('checkbox')
  CHECKBOX,


  @HiveField(9)
  @JsonValue('radio-group')
  RADIO_GROUP,


  @HiveField(10)
  @JsonValue('file')
  FILE,
  UNKNOWN
}








@HiveType(typeId: 17)
class Submission extends HiveObject with EquatableMixin{


  Map<String, dynamic> toMap(){
    Map<String, dynamic> map =  {};
   fieldEntries.forEach((FieldEntry fieldEntry) {
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


  }) {
    return Submission(
      formName: formName ?? this.formName,
      id: id ?? this.id,
      fieldEntries: fieldEntries ?? this.fieldEntries,


    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [formName,id,fieldEntries];
}

@HiveType(typeId: 18)
class FieldEntry extends Equatable{

  @HiveField(1)
  final String name;

  @HiveField(2)
  final dynamic value;

  const FieldEntry({
    required this.name,
    required this.value,
  });

  @override
  String toString() {
    return 'FieldEntry{name: $name}';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name,value];
}