// ignore_for_file: unused_import

import 'package:equatable/equatable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_builder_test/data/responses/forms/forms_response.dart';
import 'package:form_builder_test/presentation/form_widgets/file_picker_widget/file_picker_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../data/responses/forms/enums.dart';
import '../form_model.dart';


part 'file_picker_model.g.dart';

@HiveType(typeId: 6)
class FilePickerModel extends FormFieldModel with EquatableMixin {


  @HiveField(13)
  final int maxFileSize;

  @HiveField(14)
  final FileType fileType;



  FilePickerModel({
    required this.maxFileSize,
    required this.fileType,


    required String name,
    required String label,
    required String showIfFieldName,
    required String showIfFieldValue,
    required FieldType type,
    required bool deactivate,
    required bool required,
    required bool isHidden,
    required bool isReadOnly,
    required bool showIfLogicCheckbox,
    required bool showIfIsRequired,
    required bool requiredIfLogicCheckbox,
  }) : super(
      name: name,
      label: label,
      type: type,
      deactivate: deactivate,
      required: required,
      isHidden: isHidden,
      isReadOnly: isReadOnly,
      showIfFieldName: showIfFieldName,
      showIfFieldValue: showIfFieldValue,
      showIfLogicCheckbox: showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired,
      requiredIfLogicCheckbox: requiredIfLogicCheckbox);

  FilePickerModel copyWith({
     int? maxFileSize,
    FileType? fileType,
    String? name,
    String? label,
    String? showIfFieldName,
    String? showIfFieldValue,
    FieldType? type,
    bool? deactivate,
    bool? required,
    bool? isHidden,
    bool? isReadOnly,
    bool? showIfLogicCheckbox,
    bool? showIfIsRequired,
    bool? requiredIfLogicCheckbox,
  }) {
    return FilePickerModel(
      maxFileSize : maxFileSize ?? this.maxFileSize,
      fileType : fileType ?? this.fileType,
      name: name ?? this.name,
      label: label ?? this.label,
      showIfFieldName: showIfFieldName ?? this.showIfFieldName,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      type: type ?? this.type,
      deactivate: deactivate ?? this.deactivate,
      required: required ?? this.required,
      isHidden: isHidden ?? this.isHidden,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      showIfLogicCheckbox: showIfLogicCheckbox ?? this.showIfLogicCheckbox,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      requiredIfLogicCheckbox:
      requiredIfLogicCheckbox ?? this.requiredIfLogicCheckbox,

    );
  }



  @override

  List<Object?> get props => super.props..addAll([maxFileSize,fileType]);

  @override
  Widget toWidget() {
    return FilePickerWidget(
      model: this,
    );
  }
}
