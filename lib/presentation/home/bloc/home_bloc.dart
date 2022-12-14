// import 'dart:async';
// import 'dart:developer';
//
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:datalines/app/dependency_injection.dart';
// import 'package:datalines/domain/model/form_model.dart';
// import 'package:datalines/domain/repository/form_repository.dart';
// import 'package:datalines/presentation/common/state_renderer/state_renderer.dart';
// import 'package:datalines/presentation/common/state_renderer/state_renderer_impl.dart';
// import 'package:datalines/presentation/state_renderer_bloc/state_renderer_bloc.dart';
//
// part 'home_event.dart';
// part 'home_state.dart';
//
// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final stateBloc = getIT<StateRendererBloc>();
//   final AssignedFormRepository _assignedFormRepository;
//
//   HomeBloc(this._assignedFormRepository)
//       : super(HomeState(assignedForms: [], flowState: ContentState())) {
//     stateBloc.add(StateRendererEvent(ContentState()));
//
//     on<AssignedFormsRequested>(_onAssignedFormsRequested);
//     on<AssignedFormsRefreshRequested>(_onAssignedFormsRefreshRequested);
//   }
//
//   Future<void> _onAssignedFormsRequested(
//       AssignedFormsRequested event, Emitter<HomeState> emit) async {
//     emit(state.copyWith(
//         flowState: LoadingState(
//             stateRendererType: StateRendererType.FULLSCREEN_LOADING)));
//
//     try {
//       var either = await _assignedFormRepository.getAssignedForms();
//       either.fold((failure) {
//         emit(state.copyWith(
//             flowState: ErrorState(
//                 stateRendererType: StateRendererType.FULLSCREEN_ERROR,
//                 message: failure.message)));
//       }, (forms) {
//         emit(state.copyWith(
//             assignedForms: forms.data, flowState: ContentState()));
//       });
//     } catch (e) {
//       emit(state.copyWith(
//           flowState: ErrorState(
//               stateRendererType: StateRendererType.FULLSCREEN_ERROR,
//               message: e.toString())));
//     }
//   }
//
//    Future<void> _onAssignedFormsRefreshRequested(
//        AssignedFormsRefreshRequested event, Emitter<HomeState> emit) async {
//     emit(state.copyWith(
//         flowState: LoadingState(
//             stateRendererType: StateRendererType.POPUP_LOADING)));
//
//     try {
//       var either = await _assignedFormRepository.getAssignedForms(forceFromRemote: true);
//       either.fold((failure) {
//         emit(state.copyWith(
//             flowState: ErrorState(
//                 stateRendererType: StateRendererType.POPUP_ERROR,
//                 message: failure.message)));
//       }, (forms) {
//         emit(state.copyWith(
//             assignedForms: forms.data, flowState: ContentState()));
//       });
//     } catch (e) {
//       emit(state.copyWith(
//           flowState: ErrorState(
//               stateRendererType: StateRendererType.POPUP_ERROR,
//               message: e.toString())));
//     }
//   }
//
//
// }
