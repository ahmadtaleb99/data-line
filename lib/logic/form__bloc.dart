import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_builder_test/FormRepository.dart';
import 'package:form_builder_test/Widgets/DrawChecboxGroup.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';
import 'package:form_builder_test/Widgets/DrawCheckboxGroupItem.dart';
import 'package:meta/meta.dart';

part 'form__event.dart';
part 'form__state.dart';

class FormBloc extends Bloc<FormEvent, BlocFormState> {
 final  FormRepository _formRepository;
  FormBloc( this._formRepository) : super(FormInitial()) {
    on<FormRequested>((event, emit) async {
      emit(FormLoading());
     var formElements = await  _formRepository.getFormElements();
     emit(FormLoaded(formElements: formElements));
    });
  }

}
