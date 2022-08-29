
part of 'new_form_bloc.dart';



class NewFormState extends Equatable {


  final FlowState flowState;

  @override
  // TODO: implement props
  List<Object?> get props => [flowState];

  const NewFormState({
    required this.flowState,
  });

  NewFormState copyWith({
    FlowState? flowState,
  }) {
    return NewFormState(
      flowState: flowState ?? this.flowState,
    );
  }
}
