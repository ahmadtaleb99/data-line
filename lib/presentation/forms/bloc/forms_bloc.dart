import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_builder_test/domain/model/form_model.dart';

part 'forms_event.dart';
part 'forms_state.dart';

class FormsBloc extends Bloc<FormsEvent, FormsState> {
  FormsBloc() : super(FormsState(submissionMap: {})) {
    on<DropDownValueChanged>(_onDropDownValueChanged);
    on<NewFormRequested>(_onNewFormRequested);
    on<SubmitCanceled>(_onSubmitCanceled);
  }


  Future<void> _onDropDownValueChanged(
      DropDownValueChanged event, Emitter<FormsState> emit) async  {
    var dropDown  = state.formModel!.fields.firstWhere((element) => element.name == event.fieldName);
    Map<String,dynamic> map = Map.from(state.submissionMap);
    map[event.fieldName] = event.value;

    emit(state.copyWith(submissionMap: map));

  }

  Future<void> _onNewFormRequested(
      NewFormRequested event, Emitter<FormsState> emit) async  {
    emit(state.copyWith(formModel: event.formModel));

  }


  Future<void> _onSubmitCanceled(
      SubmitCanceled event, Emitter<FormsState> emit) async  {
        emit(state.copyWith(submissionMap: {}));
  }

}
