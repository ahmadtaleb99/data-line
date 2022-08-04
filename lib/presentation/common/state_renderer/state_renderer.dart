// ignore_for_file: constant_identifier_names


import 'package:flutter/material.dart';
import 'package:form_builder_test/presentation/resources/assets_manager.dart';
import 'package:form_builder_test/presentation/resources/color_manager.dart';
import 'package:form_builder_test/presentation/resources/font_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/style_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  POPUP_LOADING,
  POPUP_ERROR,
  POPUP_SUCCESS,

  FULLSCREEN_LOADING,
  FULLSCREEN_ERROR,
  FULLSCREEN_EMPTY,

  CONTENT_STATE
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String title;
  final String message;
  final Function onRetryButton;

  @override
  Widget build(BuildContext context) {
    return Center(child: _getWidget(stateRendererType, context));
  }

  Widget _getWidget(StateRendererType stateRendererType, BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING:

        return _getPopUpDialog(context, [_getAnimatedImage(AnimationAssets.loading)]);

      case StateRendererType.POPUP_ERROR:
        return _getPopUpDialog(context, [
          _getAnimatedImage(AnimationAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)
        ]);
      case StateRendererType.FULLSCREEN_LOADING:
        return   _getItemsColumn( [
          _getAnimatedImage(AnimationAssets.loading)
        ]);

      case StateRendererType.FULLSCREEN_ERROR:
     return   _getItemsColumn( [
          _getAnimatedImage(AnimationAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);

        break;
      case StateRendererType.FULLSCREEN_EMPTY:
        return _getItemsColumn([_getAnimatedImage(AnimationAssets.empty), _getMessage(message)]);

      case StateRendererType.CONTENT_STATE:
       return Container();


      case StateRendererType.POPUP_SUCCESS:
        return _getPopUpDialog(context, [
          _getAnimatedImage(AnimationAssets.success),
          _getMessage(message),
          _getRetryButton(AppStrings.ok, context)

        ]);
    }
  }


  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(context, children),

      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }


  Widget _getAnimatedImage(String animation) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animation),
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  Widget _getMessage(String message) {
    return Text(
      message,
      style: getRegularStyle(color: ColorManager.black, fontSize: FontSize.s18),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {

            if (this.stateRendererType == StateRendererType.FULLSCREEN_ERROR) {
              this.onRetryButton.call();

            } else {
              Navigator.pop(context);
            }
          },
          child: Text(buttonTitle)),
    );
  }

  const StateRenderer({
    required this.stateRendererType,
     this.title ='',
    required this.message,
    required this.onRetryButton,
  });
}
