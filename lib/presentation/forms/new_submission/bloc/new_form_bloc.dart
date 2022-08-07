// import 'dart:async';
// import 'dart:developer';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:form_builder_test/domain/model/form_model.dart';
//
// part 'new_form_event.dart';
// part 'new_form_state.dart';
//
// class NewFormBloc extends Bloc<NewFormEvent, NewFormState> {
//   NewFormBloc() : super(NewFormState(submissionMap: {} )) {
//     on<DropDownValueChanged>(_onDropDownValueChanged);
//     on<NewFormRequested>(_onNewFormRequested);
//   }
//
//
//   Future<void> _onDropDownValueChanged(
//       DropDownValueChanged event, Emitter<NewFormState> emit) async  {
//       var dropDown  = state.formModel!.fields.firstWhere((element) => element.name == event.fieldName);
//       Map<String,dynamic> map = Map.from(state.submissionMap);
//       map[event.fieldName] = event.value;
//
//       emit(state.copyWith(submissionMap: map));
//
//   }
//   Future<void> _onNewFormRequested(
//       NewFormRequested event, Emitter<NewFormState> emit) async  {
//     emit(state.copyWith(formModel: event.formModel));
//
//   }
//
// }
