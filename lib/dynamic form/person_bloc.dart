import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:form_builder_test/person.dart';
import 'package:meta/meta.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonInitial()) {
    on<PersonIsMarriedToggled>((event, emit) {
      emit()
    });
  }
}
