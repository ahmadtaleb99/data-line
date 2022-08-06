import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_form_event.dart';
part 'new_form_state.dart';

class NewFormBloc extends Bloc<NewFormEvent, NewFormState> {
  NewFormBloc() : super(NewFormInitial()) {
    on<NewFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
