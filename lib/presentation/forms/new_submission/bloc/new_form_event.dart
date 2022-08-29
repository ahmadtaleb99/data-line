part of 'new_form_bloc.dart';

abstract class NewFormEvent extends Equatable {
  const NewFormEvent();
}


class StateChanged extends NewFormEvent{
 final FlowState flowState;
  @override
  List<Object?> get props => [flowState];

  StateChanged({
    required this.flowState,
  });
}
