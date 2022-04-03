// ignore_for_file: unnecessary_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/FormService/FormRepository.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
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

  ValidationBloc(this._formRepository) : super(ValidationState(childsMap: {},)) {
    on<CheckboxGroupValueChanged>(_onCheckboxGroupValueChanged);
    on<StateFormRequested>(_onStateFormRequested);
    on<FormRequested>(_onFormRequested);
    on<ParentDropListChanged>(_onParentDropListChanged);
    on<childDropDownChanged>(_onchildDropDownChanged);
    on<RadioGroupValueChanged>(_onRadioGroupValueChanged);
    on<MultiSelectItemRemoved>(_onMultiSelectItemRemoved);
    on<ServiceRegistered>(_onServiceRegistered);
    on<FormsRequestedFromLocal>(_onFormsRequestedFromLocal);
    on<TextFieldValueChanged>(_onTextFieldValueChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  Future<void> _onStateFormRequested(
      StateFormRequested event, Emitter<ValidationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    var forms = await _formRepository.LoadFormsModel();

    emit(state.copyWith(status: Status.success, forms: forms.map((e) => e.toWidget() as FormWidget).toList()));
  }



  Future<void> _onFormsRequestedFromLocal(
      FormsRequestedFromLocal event, Emitter<ValidationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    await _formRepository.initLocal();
    var forms = await _formRepository.getForms();
    emit(state.copyWith(status: Status.success, forms: forms.map((e) => e.toWidget() as FormWidget).toList() ));
  }


  Future<void> _onServiceRegistered(
      ServiceRegistered event, Emitter<ValidationState> emit) async {
   add(FormsRequestedFromLocal());

  }

  Future<void> _onFormRequested(

  FormRequested event, Emitter<ValidationState> emit) async {

      var formModel =  _formRepository.formsModel.firstWhere((element) => element.name == event.formName);
                for(var kza in formModel.fields){
                  print(kza.value);

                }
        emit(state.copyWith(form: formModel.toWidget() as FormWidget,status: Status.success,formModel: formModel));
  }

  void _onCheckboxGroupValueChanged(
      CheckboxGroupValueChanged event, Emitter<ValidationState> emit) {
    var group = state.form!.fields.firstWhere((element) => (element is DrawCheckboxGroup) && element.name == event.groupName) as DrawCheckboxGroup;
    if (event.newIsChecked == true)
      group.checksNumber++;
    else
      group.checksNumber--;

    var child = group.children.firstWhere((element) => element.value == event.id);
    child.isChecked = event.newIsChecked;
    emit(state.copyWith(drawCheckboxGroup: group));
  }



  void _onParentDropListChanged(ParentDropListChanged event, Emitter<ValidationState> emit) {
    print(state.form!.fields.toString()+ ' children for ${event.parent}');

    dynamic childLists = state.form!.fields.where((dynamic element)
    =>(  (element is DrawChildList)  ||  (element is DrawMultiSelect ) ) &&(  element.parentName == event.drawDropDownButton.name)).toList();
    print(childLists.toString()+ ' children for ${event.parent}');
    event.drawDropDownButton.value = event.parent;
      
    for (var childList in childLists) {

      List<DropDownItem> items   = (_formRepository.formsModel.firstWhere((element) => element.name == state.form!.name).fields.firstWhere
        (( element ) => element is IFormDropList && childList.name == element.name) as IFormDropList).items;


        childList.items =  items.where((element) => element.parent == event.parent).toList();
        childList.value=null;
      print(childList.items.toString()+ '  chil   ');

    }


    emit(state.copyWith());



  }

  void _onchildDropDownChanged(
      childDropDownChanged event, Emitter<ValidationState> emit) {
    var list =
    print('fat');
    var ch =event.childList;
    if (ch is DrawChildList){
      ch.value = event.value;
    }

    else  if (ch is DrawMultiSelect){
      var list  = event.childList as DrawMultiSelect;
      ch.selectedValues = list.selectedValues;
    }



    emit(state.copyWith());
  }

  void _onRadioGroupValueChanged(


      RadioGroupValueChanged event, Emitter<ValidationState> emit) {
    var radioGroup = state.form!.fields.firstWhere((element) =>
      (element is DrawRadioGroup) && element.name == event.groupName) as DrawRadioGroup;

    for (var child in radioGroup.children) {
      child.groupValue = event.value;
    }
    radioGroup.value = event.value;
    if(event.value == 'other'){
      radioGroup.isOtherSelected= true;
  }
    else  radioGroup.isOtherSelected= false;

     var newForm = _checkRelatedFields(event.value);
    emit(state.copyWith(form: newForm,status: Status.success));

  }

  FormWidget  _checkRelatedFields(String fieldValue) {
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







  void _onMultiSelectItemRemoved(MultiSelectItemRemoved event, Emitter<ValidationState> emit) {

    var map = state.childsMap;
    var select =  event.select;
      select.selectedValues.remove(event.item);
      map[select.name] = select;
      emit(state.copyWith(childsMap: map));
  }



  void _onTextFieldValueChanged(TextFieldValueChanged event, Emitter<ValidationState> emit) {
    var textField = state.form!.fields.firstWhere((element) =>element.name == event.textFieldName)  as DrawTextField;

    textField.value  = event.value;
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<ValidationState> emit) {
    var formModel =  _formRepository.formsModel.firstWhere((element) => element.name == event.formName);
      for(int i=0;i<formModel.fields.length;i++){
        print(formModel.fields[i].value.toString());
        formModel.fields[i].value = state.form!.fields[i].value;
      }

      _formRepository.saveToLocal(formModel);
  }



}






