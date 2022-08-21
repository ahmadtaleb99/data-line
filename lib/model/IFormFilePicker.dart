import 'package:form_builder_test/Widgets/file_picker_widget.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/model/IFormModel.dart';
import 'package:hive/hive.dart';

import '../utils/expression/Expression.dart';
import 'FileTypeEnum.dart';

part 'IFormFilePicker.g.dart';

@HiveType(typeId: 46)
class IFormFilePicker extends IFormModel {
  dynamic _parameters;

  @HiveField(1)
  String label;

  @HiveField(2)
  String name;

  @HiveField(3)
  bool deactivate;

  @HiveField(4)
  bool isHidden;

  @HiveField(5)
  bool required;

  @HiveField(6)
  bool isReadOnly;

  @HiveField(7)
  bool? visible;

  @HiveField(8)
  bool showIfValueSelected;

  @HiveField(9)
  String? showIfFieldValue;

  @HiveField(10)

  bool? showIfIsRequired;

  @HiveField(11)
  final int maxFileSize;

  @HiveField(12)
  FileTypeEnum fileType;


  @HiveField(13)
  dynamic value;
  IFormFilePicker( {
    required this.label,
    required this.name,
    required this.deactivate,
    required this.isHidden,
    required this.required,
    required this.isReadOnly,
    this.visible,
    this.value,
    required this.showIfValueSelected,
    this.showIfFieldValue,
    this.showIfIsRequired,

    required this.maxFileSize,
    required this.fileType,
  }) : super( name: name,label: label) ;


  factory IFormFilePicker.fromJson(json) {
    return IFormFilePicker(
      label: json['label'],
      required: json['required'],
      showIfIsRequired: json['showIfIsRequired'],
      showIfFieldValue: json['showIfFieldValue'],
      isHidden: json['isHidden'],
      isReadOnly: json['isReadOnly'],
      showIfValueSelected: json['showIfLogicCheckbox'],
      name: json['name'],
      maxFileSize: json['maxFileSize'],
      deactivate: json['deactivate'],
      fileType: fileTypeEnumValues.map![json['fileType']]!,
    );
  }
  
  @override
  FormElementWidget toWidget({parameters}) {
    return FilePickerWidget(
      value:  value,
      label: this.label,
      required: this.required,
      showIfIsRequired: this.showIfIsRequired,
      showIfFieldValue: this.showIfFieldValue,
      isHidden: this.isHidden,
      isReadOnly: this.isReadOnly,
      showIfValueSelected: this.showIfValueSelected,
      name: this.name,
      visible: this.showIfValueSelected == true && value == null ? false : true,
      deactivate: this.deactivate,
      maxFileSize: this.maxFileSize,
      fileType: this.fileType,
    );
  }

  @override
  void setParameters(parametrs) {
    _parameters = parametrs;
  }

  @override
  Map<String, dynamic> fomrElementtoJson(FormElementWidget formElement) {
    // TODO: implement fomrElementtoJson
    throw UnimplementedError();
  }

  IFormFilePicker copyWith({
    String? label,
    String? name,
    bool? deactivate,
    bool? isHidden,
    bool? required,
    bool? isReadOnly,
    bool? visible,
    bool? showIfValueSelected,
    String? showIfFieldValue,
    bool? showIfIsRequired,
    int? maxFileSize,
    FileTypeEnum? fileType,
    dynamic? value,
  }) {
    return IFormFilePicker(
      label: label ?? this.label,
      name: name ?? this.name,
      deactivate: deactivate ?? this.deactivate,
      isHidden: isHidden ?? this.isHidden,
      required: required ?? this.required,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      visible: visible ?? this.visible,
      showIfValueSelected: showIfValueSelected ?? this.showIfValueSelected,
      showIfFieldValue: showIfFieldValue ?? this.showIfFieldValue,
      showIfIsRequired: showIfIsRequired ?? this.showIfIsRequired,
      maxFileSize: maxFileSize ?? this.maxFileSize,
      fileType: fileType ?? this.fileType,
      value: value ?? this.value,
    );
  }

  @override
  String valueToString() {
    throw UnimplementedError();
  }

  @override
  bool isValid() {
    // TODO: implement isValid
    throw UnimplementedError();
  }


}
