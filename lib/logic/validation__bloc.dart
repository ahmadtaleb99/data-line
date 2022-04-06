// ignore_for_file: unnecessary_import

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/FormService/FormRepository.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/Widgets/DrawFilePicker.dart';
import 'package:form_builder_test/Widgets/DrawForm.dart';
import 'package:form_builder_test/Widgets/DrawMultiSelect.dart';
import 'package:form_builder_test/Widgets/DrawRadioGroup.dart';
import 'package:form_builder_test/Widgets/DrawTextField.dart';
import 'package:form_builder_test/dynamic%20form/DropDownItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
import 'package:form_builder_test/dynamic%20form/IFormDropList.dart';
import 'package:form_builder_test/dynamic%20form/IFormTextField.dart';
import 'package:meta/meta.dart';

part 'validation__event.dart';
part 'validation__state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  FormRepository _formRepository;

  ValidationBloc(this._formRepository)
      : super(ValidationState(
          childsMap: {},
        )) {
    on<CheckboxGroupValueChanged>(_onCheckboxGroupValueChanged);
    on<FormsRequested>(_onFormsRequested);
    on<FormRequested>(_onFormRequested);
    on<ParentDropListChanged>(_onParentDropListChanged);
    on<childDropDownChanged>(_onchildDropDownChanged);
    on<RadioGroupValueChanged>(_onRadioGroupValueChanged);
    on<MultiSelectItemRemoved>(_onMultiSelectItemRemoved);
    on<ServiceRegistered>(_onServiceRegistered);
    on<FormsRequestedFromLocal>(_onFormsRequestedFromLocal);
    on<TextFieldValueChanged>(_onTextFieldValueChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<MultiSelectChanged>(_onMultiSelectChanged);
    on<FilePickerPressed>(_onFilePickerPressed);
    on<SubmittionsFormsRequested>(_onSubmittionsFormsRequested);
    on<FormUpdateRequested>(_onFormUpdateRequested);
  }

  Future<void> _onFormsRequested(
      FormsRequested event, Emitter<ValidationState> emit) async {
    try{
      emit(state.copyWith(status: Status.loading));
      var forms = await _formRepository.LoadFormsModel();

      emit(state.copyWith(
          status: Status.success,
          forms: forms.map((e) => e.toWidget() as FormWidget).toList()));
    }
    on SocketException {
      emit(state.copyWith(islocallyWorking: true));
      add(FormsRequestedFromLocal());
    }
  }

  void _onMultiSelectChanged(
      MultiSelectChanged event, Emitter<ValidationState> emit) {
    var select = event.select as DrawMultiSelect;

    select.selectedValues = event.value;
    select.value = event.value;
    print('selected value for multi parent : ${select.value}');
    print('selected value for multi parent : ${select.selectedValues}');

    emit(state.copyWith());
  }

  Future<void> _onFormsRequestedFromLocal(
      FormsRequestedFromLocal event, Emitter<ValidationState> emit) async {
    var forms = await _formRepository.getAvailableFormsFromLocal();

    emit(state.copyWith(
        status: Status.success,
        forms: forms.map((e) => e.toWidget() as FormWidget).toList()));
  }



  Future<void> _onServiceRegistered(
      ServiceRegistered event, Emitter<ValidationState> emit) async {
    await _formRepository.initLocal();
  }
  Future<void> _onSubmittionsFormsRequested(
      SubmittionsFormsRequested event, Emitter<ValidationState> emit) async {



   var forms =  _formRepository.getAllSubmissionByName(event.formName);
   emit(state.copyWith(subedForms:
   forms.map((e) => e.toWidget() as FormWidget).toList()
   ));

  }


  Future<void> _onFormUpdateRequested(
      FormUpdateRequested event, Emitter<ValidationState> emit) async {
    print('fast');

    var formModel = _formRepository.up

    print('form model state : ${formModel.fields.first.value}');
    emit(state.copyWith(
        form: formModel.toWidget() as FormWidget,
        status: Status.success,
        formModel: formModel));
  }


  Future<void> _onFormRequested(
      FormRequested event, Emitter<ValidationState> emit) async {

    var formModel = _formRepository.availableForms
        .firstWhere((element) => element.name == event.formName);

    emit(state.copyWith(
        form: formModel.toWidget() as FormWidget,
        status: Status.success,
        formModel: formModel));
  }

  void _onCheckboxGroupValueChanged(
      CheckboxGroupValueChanged event, Emitter<ValidationState> emit) {
    var group = state.form!.fields.firstWhere((element) =>
            (element is DrawCheckboxGroup) && element.name == event.groupName)
        as DrawCheckboxGroup;

    List<String> valuesList = group.value ;

    if (event.newIsChecked == true){
      valuesList.add(event.value);
      group.checksNumber++;
    }
    else{
      valuesList.remove(event.value);
      group.checksNumber--;
    }

    var child =
        group.children.firstWhere((element) => element.value == event.id);
    child.isChecked = event.newIsChecked;

    print(group.value);
    emit(state.copyWith(drawCheckboxGroup: group));
  }

  void _onParentDropListChanged(
      ParentDropListChanged event, Emitter<ValidationState> emit) {
    print(state.form!.fields.toString() + ' children for ${event.parent}');

    dynamic childLists = state.form!.fields
        .where((dynamic element) =>
            ((element is DrawChildList) || (element is DrawMultiSelect)) &&
            (element.parentName == event.drawDropDownButton.name))
        .toList();
    print(childLists.toString() + ' children for ${event.parent}');
    event.drawDropDownButton.value = event.parent;

    for (var childList in childLists) {
      List<DropDownItem> items = (_formRepository.formsModel
              .firstWhere((element) => element.name == state.form!.name)
              .fields
              .firstWhere((element) =>
                  element is IFormDropList &&
                  childList.name == element.name) as IFormDropList)
          .items;


        childList.items =
            items.where((element) => element.parent == event.parent).toList();
        childList.value = null;
        event.drawDropDownButton.value == event.parent;
      print(childList.items.toString() + '  chil   ');
    }

    emit(state.copyWith());
  }

  void _onchildDropDownChanged(
      childDropDownChanged event, Emitter<ValidationState> emit) {
    var ch = event.childList;
    if (ch is DrawChildList) {
      ch.value = event.value;
    }

    emit(state.copyWith());
  }

  void _onRadioGroupValueChanged(
      RadioGroupValueChanged event, Emitter<ValidationState> emit) {
    var radioGroup = state.form!.fields.firstWhere((element) =>
            (element is DrawRadioGroup) && element.name == event.groupName)
        as DrawRadioGroup;

    for (var child in radioGroup.children) {
      child.groupValue = event.value;
    }
    radioGroup.value = event.value;
    if (event.value == 'other') {
      radioGroup.isOtherSelected = true;
    } else
      radioGroup.isOtherSelected = false;

    var newForm = _checkRelatedFields(event.value);
    emit(state.copyWith(form: newForm, status: Status.success));
  }

  FormWidget _checkRelatedFields(String fieldValue) {
    var form = state.form!;
    for (var formElement in form.fields) {
      if (formElement.showIfValueSelected! &&
          formElement.showIfFieldValue == fieldValue)
        formElement.visible = true;
      else
        formElement.visible = false;
    }

    return form;
  }

  void _onMultiSelectItemRemoved(
      MultiSelectItemRemoved event, Emitter<ValidationState> emit) {
    var select = state.form!.fields
            .firstWhere((element) => element.name == event.selectName)
        as DrawMultiSelect;
    select.selectedValues!.remove(event.item);
    emit(state.copyWith(initialMulti: select.selectedValues));
  }

  void _onTextFieldValueChanged(
      TextFieldValueChanged event, Emitter<ValidationState> emit) {
    var textField = state.form!.fields
            .firstWhere((element) => element.name == event.textFieldName)
        as DrawTextField;

    textField.value = event.value;
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<ValidationState> emit) {
    var formModel = _formRepository.availableForms
        .firstWhere((element) => element.name == event.formName);
    for (int i = 0; i < formModel.fields.length; i++){
      print(formModel.fields[i].value.toString());
      print(state.form!.fields[i].value.toString());
      formModel.fields[i].value = state.form!.fields[i].value;
    }

    _formRepository.addSubmittedForm(formModel);
  }

  void _onFilePickerPressed(FilePickerPressed event, Emitter<ValidationState> emit) async {


    var filePicker = event.drawFilePicker;
    PlatformFile? pickedFile;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

    if (result != null) {
      pickedFile = result.files.single;
      // fieldState.didChange(_pickedFile);
      filePicker.pickedFile = pickedFile;
      filePicker.value = pickedFile.path;

    } else {
      // User canceled the picker
    }
    emit(state.copyWith());
  }
}
