import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  LoadingState({
    required this.stateRendererType,
    this.message,
  });
}

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  int? code;
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  ErrorState({
    required this.stateRendererType,
    required this.message,
    this.code,
  });
}

class ContentState extends FlowState {
  @override
  String getMessage() => '';

  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_STATE;
}

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.FULLSCREEN_EMPTY;
}

class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.POPUP_SUCCESS;
}

extension xFlowState on FlowState {
  Widget getWidget(BuildContext context, Widget widget, Function onRetry) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.POPUP_LOADING) {
          // show popup loading
          dismissOpenedDialog(context);

          showPopup(context, getStateRendererType(), getMessage());
          // show content ui of the screen
          return widget;
        } else {
          // full screen loading state
          return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              onRetryButton: onRetry);
        }

      case ErrorState:
        if (getStateRendererType() == StateRendererType.POPUP_ERROR) {
          print('error state ');
          dismissOpenedDialog(context);

          // show popup error
          showPopup(context, getStateRendererType(), getMessage(),
              code: (this as ErrorState).code);
          // show content ui of the screen
          return widget;
        } else {
          // full screen loading state
          return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              onRetryButton: onRetry);
        }

      case SuccessState:
        dismissOpenedDialog(context);
        if (getStateRendererType() == StateRendererType.POPUP_SUCCESS) {
          print('success state ');

          // show popup sucess
          showPopup(context, getStateRendererType(), getMessage(),onButtonPressed: onRetry);
          // show content ui of the screen
          return widget;
        }

        else {
          // full screen loading state
          return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              onRetryButton: () {});
        }

      case ContentState:
        dismissOpenedDialog(context);
        return widget;

      case EmptyState:
        dismissOpenedDialog(context);
    }
    return StateRenderer(
        message: getMessage(),
        stateRendererType: getStateRendererType(),
        onRetryButton: onRetry);
  }

  showPopup(
      BuildContext context, StateRendererType stateRendererType, String message,
      {int? code,Function? onButtonPressed}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
              stateRendererType: stateRendererType,
              message: message,
              code: code,
              onRetryButton: onButtonPressed ?? () {},
            )));
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  dismissOpenedDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
