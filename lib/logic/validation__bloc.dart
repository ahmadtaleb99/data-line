// ignore_for_file: unnecessary_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/FormRepository.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:form_builder_test/Widgets/DrawDropDownButton.dart';
import  'package:meta/meta.dart';

part 'validation__event.dart';
part 'validation__state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {

  FormRepository _formRepository;

  ValidationBloc(this._formRepository) : super( ValidationState()) {
    on<CheckboxGroupValueChanged>((event, emit) {
      var group= _formRepository.getCheckBoxGroup(event.groupName) ;
      if (event.newIsChecked == true )
      group.checksNumber ++ ;
      else
        group.checksNumber -- ;

      var child  = group.children.firstWhere((element) => element.id == event.id );
      child.isChecked = event.newIsChecked;
      emit(state.copyWith(drawCheckboxGroup: group));
    });


    on<ParentDropListChanged>((event, emit) {
        // var lists = _formRepository.getChildDropDowns(event.drawDropDownButton.)
    });
  }
}
