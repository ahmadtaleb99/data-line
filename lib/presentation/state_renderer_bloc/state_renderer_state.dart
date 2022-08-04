part of 'state_renderer_bloc.dart';

@immutable

class StateRendererState extends Equatable{
  FlowState flowState;
  StateRendererState(this.flowState);

  @override
  // TODO: implement props
  List<Object?> get props => [flowState];
}
