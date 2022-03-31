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
import 'package:form_builder_test/dynamic%20form/DropDownItem.dart';
import 'package:form_builder_test/Widgets/IDrawable.dart';
import 'package:meta/meta.dart';

part 'validation__event.dart';
part 'validation__state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  FormRepository _formRepository;

  ValidationBloc(this._formRepository) : super(ValidationState(childsMap: {})) {
    on<CheckboxGroupValueChanged>(_onCheckboxGroupValueChanged);
    on<StateFormRequested>(_onStateFormRequested);
    on<FormRequested>(_onFormRequested);
    on<ParentDropListChanged>(_onParentDropListChanged);
    on<childDropDownChanged>(_onchildDropDownChanged);
    on<RadioGroupValueChanged>(_onRadioGroupValueChanged);
    on<MultiSelectItemRemoved>(_onMultiSelectItemRemoved);
  }

  Future<void> _onStateFormRequested(
      StateFormRequested event, Emitter<ValidationState> emit) async {
    emit(state.copyWith(status: Status.loading));
    var forms = await _formRepository.LoadForms(event.formId);
    Map<String, FormElement>? map = {};
    // for(var formElement in formElements) {
    //   if(formElement is DrawChildList || formElement is DrawMultiSelect  ){
    //   map[formElement.name] = formElement;
    //   }
    // }

    print(map.toString());
    emit(state.copyWith(status: Status.success, forms: forms,childsMap: map));
  }


  Future<void> _onFormRequested(
      FormRequested event, Emitter<ValidationState> emit) async {
        var form =  _formRepository.forms.firstWhere((element) => element.name == event.formName);
        emit(state.copyWith(form: form,childsMap: {}));
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

    var childLists = state.form!.fields.where((dynamic element)
    =>(  (element is DrawChildList)  ||  (element is DrawMultiSelect ) ) &&(  element.parentName == event.drawDropDownButton.name)).toList();
    // _formRepository.getChildrenSelectsFor(event.drawDropDownButton.name);
    print(childLists.toString()+ ' children for ${event.parent}');
    event.drawDropDownButton.value = event.parent;

    var map = state.childsMap;
    for (var childList in childLists) {
      var ch;
      if(childList is DrawChildList)
       ch = childList.copyWith();

     else if(childList is DrawMultiSelect)
         ch = childList.copyWith();


      ch.items =  ch.items.where((element) => element.parent == event.parent).toList();
      print(ch.items! );
      map[ch.name] = ch;
    }

    print(map.toString()+ '  chil   ');

    emit(state.copyWith( childsMap: map));



  }

  void _onchildDropDownChanged(
      childDropDownChanged event, Emitter<ValidationState> emit) {



    var map = state.childsMap;
    var ch = map[event.childList.name];
    if (ch is DrawChildList){
      ch.value = event.value;
    }

    else  if (ch is DrawMultiSelect){
      var list  = event.childList as DrawMultiSelect;
      ch.selectedValues = list.selectedValues;
    }
    map[ch!.name] = ch;



    emit(state.copyWith(childsMap: map));
  }

  void _onRadioGroupValueChanged(


      RadioGroupValueChanged event, Emitter<ValidationState> emit) {

    var s =  state.form!.fields.firstWhere((element) => element.name == 'radio-group-1') as DrawRadioGroup;
    s.isOtherSelected = true;
    var radioGroup = state.form!.fields.firstWhere((element) =>
      (element is DrawRadioGroup) && element.name == event.groupName) as DrawRadioGroup;

    for (var child in radioGroup.children) {
      child.groupValue = event.value;
    }
    radioGroup.value = event.value;
    if(event.value == 'other'){
      radioGroup.isOtherSelected= true;
  }
    // else  radioGroup.isOtherSelected= false;

     var newForm = _checkRelatedFields(event.value);
    emit(state.copyWith(form: newForm,status: Status.success));

  }

  DrawForm  _checkRelatedFields(String fieldValue) {
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
}












