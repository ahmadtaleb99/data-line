import 'dart:developer';

import 'package:form_builder_test/domain/model/checkbox_group_model/checkbox_group_model.dart';
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


class DatabaseException  implements Exception{
  final String message;
  DatabaseException(this.message);
}
class HiveDatabase {
  
  static const String assignedFormsBoxKey = 'assignedFormsBoxKey';
  static const String _assignedForm = 'assignedForms';


  static const String submissionBoxKey = 'submissionBoxKey';
  static const String _submissions = 'submissions';



  late final Box<AssignedForms> _assignedFormsBox;
  late final Box<Submission> _submissionsBox;

  Future<void> init() async {
    Hive.registerAdapter(CheckboxGroupItemModelAdapter());
    Hive.registerAdapter(CheckboxGroupModelAdapter());
    Hive.registerAdapter(DropDownItemModelAdapter());
    Hive.registerAdapter(DropDownModelAdapter());
    Hive.registerAdapter(EmailTextFieldModelAdapter());
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
    //
    _assignedFormsBox  = await Hive.openBox<AssignedForms>(assignedFormsBoxKey);
    _submissionsBox  = await Hive.openBox<Submission>(submissionBoxKey);


  }

  Future<void> updateSubmission (Submission submission) async {
    await   _submissionsBox.put(getSubmissionId(submission),submission);
  }

  Future<void> addSubmission (Submission submission) async {
      var sub = submission.copyWith(id: _getLastSubmissionId()+1);

    await   _submissionsBox.add(submission);
  }
  
  List<Submission>? getAllSubmissions (String formName){
    return _submissionsBox.values.where((element) => element.formName == formName).toList() ;

  }

  Future<void> saveAssignedForms (AssignedForms assignedForms) async {
  await   _assignedFormsBox.put(_assignedForm, assignedForms);
  }


 int  _getLastSubmissionId() {
    final key = _submissionsBox.keys.lastOrNull ?? 0;
    return key as int;
  }


  int getSubmissionId(Submission submission){
    log('sub id '+ submission.key.toString());
    _submissionsBox.values.forEach((element) {log(element.key.toString());});
    final _submission = _submissionsBox.values.firstWhere((element) => element.id == submission.id);
    final index = _submission.key as int ;
    return index;
  }
  AssignedForms getAssignedForms ()  {
     var assignedForms =  _assignedFormsBox.get(_assignedForm);
     if (assignedForms == null)
       throw DatabaseException('no forms available');

     return assignedForms;
  }

  Future<void> deleteSubmission(Submission submission) async {
   await  _submissionsBox.delete(getSubmissionId(submission));
  }




}