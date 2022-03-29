import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/FormService/FormRepository.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/Widgets/DrawRadioGroup.dart';
import 'package:form_builder_test/dynamic%20form/DropDownItem.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:meta/meta.dart';

part 'form__event.dart';
part 'form__state.dart';

class FormBloc extends Bloc<FormEvent, BlocFormState> {
 final  FormRepository _formRepository;
  FormBloc( this._formRepository) : super(FormInitial()) {
    on<FormRequested>((event, emit) async {
      emit(FormLoading());
      var formElements = await _formRepository.LoadFormElements(event.formId);
      emit(FormLoaded(formElements: formElements, childsMap: {}));
    });

    on<CheckboxGroupValueChanged1>(_onCheckboxGroupValueChanged);
    on<ParentDropListChanged1>(_onParentDropListChanged1);
    on<childDropDownChanged1>(_onchildDropDownChanged);
    on<RadioGroupValueChanged1>(_onRadioGroupValueChanged);


  }
 void _onCheckboxGroupValueChanged (CheckboxGroupValueChanged1 event, Emitter <BlocFormState> emit){
   var group = _formRepository.getCheckBoxGroup(event.groupName);
   if (event.newIsChecked == true)
     group.checksNumber++;
   else
     group.checksNumber--;

   var child =
   group.children.firstWhere((element) => element.value == event.id);
   child.isChecked = event.newIsChecked;

   emit((state as FormLoaded).copyWith(drawCheckboxGroup: group));

 }

 void _onParentDropListChanged (ParentDropListChanged1 event, Emitter <BlocFormState> emit){
   // var childLists =
   // _formRepository.getChildrenSelectsFor(event.drawDropDownButton.name);
   //
   // for(var childList in childLists){
   //
   //   DrawChildList ch = childList.copyWith();
   //   ch.items  = ch.items.where((element) => element.parent == event.parent).toList();
   //   print(ch.items.toString()+ ' 21301392103210838012308120832180');
   //   for(var c in ch.items) print( ' ${c.value}  21444444');
   //   ch.value = ch.items.first.value;
   //
   //   emit((state as FormLoaded).copyWith(childList: ch));
   // }
 }
 void _onParentDropListChanged1 (ParentDropListChanged1 event, Emitter <BlocFormState> emit){
   // var childLists =
   // _formRepository.getChildrenSelectsFor(event.drawDropDownButton.name);
   // event.drawDropDownButton.value = event.parent;
   // for(var c in childLists){
   //   print(c.name);
   // }
   // var map = (state as FormLoaded).childsMap;
   // List<DrawChildList>    list = List.from((state as FormLoaded).childLists!);
   // for(var childList in childLists){
   //   emit((state as FormLoaded));
   //
   //   DrawChildList ch = childList.copyWith();
   //
   //   ch.items  = ch.items.where((element) => element.parent == event.parent).toList();
   //   map[ch.name]=ch;
   //   for(var c in ch.items){
   //     print('items to be added to list : ${c.value}   ');
   //   }
   //
   //   list.add(ch);
   //   emit((state as FormLoaded).copyWith(childLists: list,childsMap: map ));
   //
   // }
   // for(var c in list){
   //   print(c.toString()+'state list ');
   // }

 }
 void _onchildDropDownChanged (childDropDownChanged1 event, Emitter <BlocFormState> emit){
   var map = (state as FormLoaded).childsMap;
   var ch = map[event.childList.name];
   ch!.value = event.value;
   map[event.childList.name] = ch ;
   emit((state as FormLoaded).copyWith(childsMap: map));
 }

 Future<void> _onRadioGroupValueChanged (RadioGroupValueChanged1 event, Emitter <BlocFormState> emit) async {
    var radioGroup = _formRepository.getRadioGroup(event.groupName);
   var child = radioGroup.children.firstWhere((element) => element.value == event.id);
   for(var child in radioGroup.children){
     child.groupValue = event.value;
   }
   emit(FormLoading());

   var formElements = _formRepository.formElementList as List<dynamic>;
   for(var formElement in formElements)
   {
     if(formElement.showIfValueSelected && formElement.showIfFieldValue == event.value)
       formElement.visible = true;
     else   formElement.visible = false;


   }
   emit(FormLoaded(formElements: formElements,childsMap: {}));
 }
}
