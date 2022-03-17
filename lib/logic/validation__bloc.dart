// ignore_for_file: unnecessary_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/FormRepository.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/DrawChildList.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import 'package:form_builder_test/Widgets/DropDownItemWidget.dart';
import 'package:meta/meta.dart';

part 'validation__event.dart';
part 'validation__state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  FormRepository _formRepository;

  ValidationBloc(this._formRepository) : super(ValidationState()) {
    on<CheckboxGroupValueChanged>(_onCheckboxGroupValueChanged);
    on<ParentDropListChanged>(_onParentDropListChanged1);
    on<childDropDownChanged>(_onchildDropDownChanged);
  }





  void _onCheckboxGroupValueChanged (CheckboxGroupValueChanged event, Emitter <ValidationState> emit){
    var group = _formRepository.getCheckBoxGroup(event.groupName);
    if (event.newIsChecked == true)
      group.checksNumber++;
    else
      group.checksNumber--;

    var child =
    group.children.firstWhere((element) => element.id == event.id);
    child.isChecked = event.newIsChecked;
    emit(state.copyWith(drawCheckboxGroup: group));
  }

  void _onParentDropListChanged (ParentDropListChanged event, Emitter <ValidationState> emit){
    var childLists =
    _formRepository.getChildrenSelectsFor(event.drawDropDownButton.name);

      for(var childList in childLists){

        DrawChildList ch = childList.copyWith();
        ch.items  = ch.items.where((element) => element.parent == event.parent).toList();
        print(ch.items.toString()+ ' 21301392103210838012308120832180');
        for(var c in ch.items) print( ' ${c.value}  21444444');
        ch.value = ch.items.first.value;

        emit(state.copyWith(childList: ch));
      }
  }
  void _onParentDropListChanged1 (ParentDropListChanged event, Emitter <ValidationState> emit){
    var childLists =
      _formRepository.getChildrenSelectsFor(event.drawDropDownButton.name);
      event.drawDropDownButton.value = event.parent;
        for(var c in childLists){
          print(c.name);
        }
      List<DrawChildList>    list = List.from(state.childLists!);
      for(var childList in childLists){

        DrawChildList ch = childList.copyWith();

        ch.items  = ch.items.where((element) => element.parent == event.parent).toList();

        ch.value = null;
            list.add(ch);

      }
    for(var c in list){
      print(c.toString()+'state list ');
    }
    emit(state.copyWith(childLists: list));

  }
  void _onchildDropDownChanged (childDropDownChanged event, Emitter <ValidationState> emit){
      event.childList.value = event.value;
  }


}
