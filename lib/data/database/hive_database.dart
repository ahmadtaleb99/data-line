import 'dart:developer';

import 'package:datalines/data/responses/forms/enums.dart';
import 'package:datalines/domain/model/checkbox_group_model/checkbox_group_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_checkbox_group_model/matrix_checkbox_group_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_date_picker_model/matrix_date_picker_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_dropdown_model/matrix_dropdown_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_model.dart';
import 'package:datalines/domain/model/node/node.dart';
import 'package:datalines/domain/model/matrix_model/matrix_number_model/matrix_number_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_radio_group_model/matrix_radio_group_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_record/matrix_record_model.dart';
import 'package:datalines/domain/model/matrix_model/matrix_text_field_model/matrix_text_field_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:collection/collection.dart';
import '../../domain/model/checkbox_group_item_model/checkbox_group_item_model.dart';
import '../../domain/model/dropdown_item_model/dropdown_item_model.dart';
import '../../domain/model/dropdown_model/dropdown_model.dart';
import '../../domain/model/email_text_field_model/email_text_field_model.dart';
import '../../domain/model/file_picker_model/file_picker_model.dart';
import '../../domain/model/form_model.dart';
import '../../domain/model/number_text_field_model/number_text_field_model.dart';
import '../../domain/model/radio_group_item_model/radio_group_item_model.dart';
import '../../domain/model/radio_group_model/radio_group_model.dart';
import '../../domain/model/star_rating_model/star_rating_model.dart';
import '../../domain/model/text_area_model/text_area_model.dart';
import '../../domain/model/text_field_model/text_field_model.dart';

class DatabaseDataNotFoundException implements Exception {
  final String message;
  DatabaseDataNotFoundException(this.message);
}

class HiveDatabase {
  static const String inactiveFormsBoxKey = 'inactiveFormsBoxKey';
  static const String inactiveForms = 'inactiveForms';

  static const String assignedFormsBoxKey = 'assignedFormsBoxKey';
  static const String _assignedForm = 'assignedForms';

  static const String submissionBoxKey = 'submissionBoxKey';

  static const String nodeBoxKey = 'nodeBoxKey';
  static const String _nodes = 'nodes';

  late final Box<AssignedForms> _assignedFormsBox;
  late final Box<FormModel> _inactiveFormsBox;
  late final Box<Submission> _submissionsBox;
  late final Box<List<dynamic>> _nodesBox;

  Future<void> init() async {
    //matrix

    Hive.registerAdapter(MatrixTextFieldModelAdapter());
    Hive.registerAdapter(MultipleOptionsModelAdapter());
    Hive.registerAdapter(MatrixCheckboxGroupModelAdapter());
    Hive.registerAdapter(MatrixCheckboxModelAdapter());
    Hive.registerAdapter(MatrixRadioGroupModelAdapter());
    Hive.registerAdapter(MatrixDropDownModelAdapter());
    Hive.registerAdapter(MatrixDatePickerModelAdapter());
    Hive.registerAdapter(MatrixNumberModelAdapter());
    Hive.registerAdapter(MatrixModelAdapter());
    Hive.registerAdapter(MatrixRecordModelAdapter());

    Hive.registerAdapter(CheckboxGroupItemModelAdapter());
    Hive.registerAdapter(CheckboxGroupModelAdapter());
    Hive.registerAdapter(DropDownItemModelAdapter());
    Hive.registerAdapter(DropDownModelAdapter());
    Hive.registerAdapter(EmailTextFieldModelAdapter());
    Hive.registerAdapter(FileTypeAdapter());
    Hive.registerAdapter(FilePickerModelAdapter());
    Hive.registerAdapter(NumberFieldModelAdapter());
    Hive.registerAdapter(RadioGroupItemModelAdapter());
    Hive.registerAdapter(RadioGroupModelAdapter());
    Hive.registerAdapter(StarRatingModelAdapter());
    Hive.registerAdapter(TextAreaModelAdapter());
    Hive.registerAdapter(TextFieldModelAdapter());
    Hive.registerAdapter(AssignedFormsAdapter());
    Hive.registerAdapter(FormModelAdapter());
    Hive.registerAdapter(FormFieldModelAdapter());
    Hive.registerAdapter(FieldTypeAdapter());
    Hive.registerAdapter(SubmissionAdapter());
    Hive.registerAdapter(FieldEntryAdapter());
    Hive.registerAdapter(OperatorAdapter());


    Hive.registerAdapter(NodeAdapter());

    //
    _assignedFormsBox = await Hive.openBox<AssignedForms>(assignedFormsBoxKey);
    _submissionsBox = await Hive.openBox<Submission>(submissionBoxKey);
    _nodesBox = await Hive.openBox<List<dynamic>>(nodeBoxKey);
    _inactiveFormsBox = await Hive.openBox<FormModel>(inactiveFormsBoxKey);


  }




  Future<void> updateSubmission(Submission submission) async {
    await _submissionsBox.put(getSubmissionId(submission), submission);
  }

  Future<void> addSubmission(Submission submission) async {
    var sub = submission.copyWith(id: getLastSubmissionId() + 1);
    log('addSubmission subid ${sub.id.toString()}  subKey: ${sub.key.toString()} submitted at :  ${sub.submittedAt.toString()}');
    await _submissionsBox.add(sub);
  }

  List<Submission>? getAllSubmissions(String formId) {
    var list = _submissionsBox.values
        .where((element) => element.formId == formId)
        .toList();
    log(list.toString());
    return list;
  }


  Future<void> addInactiveForms(List<FormModel> forms) async {
   await _inactiveFormsBox.addAll(forms);
  }


  Future<void> saveAssignedForms(List<FormModel> assignedForms) async {
    await _assignedFormsBox.put(_assignedForm, AssignedForms(assignedForms));
  }

  int getLastSubmissionId() {
    final key = _submissionsBox.keys.lastOrNull ?? -1;

    return key as int;
  }

  int getSubmissionId(Submission submission) {
    final _submission = _submissionsBox.values
        .firstWhere((element) => element.id == submission.id);
    final index = _submission.key as int;
    return index;
  }

  List<FormModel>? getAssignedForms() {
    AssignedForms? assignedForms = _assignedFormsBox.get(_assignedForm);

    return assignedForms?.data;
  }



  Future<void> deleteSubmissionsRage (String formId,int startIndex,int endIndex) async {


    var allFormSubmissions = getAllSubmissions(formId);

    if(allFormSubmissions != null){
      final submissionsRange = allFormSubmissions.sublist(startIndex,endIndex);
      final List<dynamic> keys = submissionsRange.map((e) => e.key).toList();
      await _submissionsBox.deleteAll(keys);
    }

  }
  List<FormModel>? getInactiveForms() {
    return  _inactiveFormsBox.values.toList();
  }


  bool formHasSubmissions(String formId) {
    return _submissionsBox.values.any((element) => element.formId ==formId);
  }
  List<Node>? getNodes() {


    return  _nodesBox.get(_nodes)?.cast();

  }

  Future<void> saveNodes(List<Node> nodes) async {
    await _nodesBox.put(_nodes, nodes);
  }

  Future<void> deleteSubmission(Submission submission) async {
    await _submissionsBox.delete(getSubmissionId(submission));
  }
}
