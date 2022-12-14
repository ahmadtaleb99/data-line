// ignore_for_file: constant_identifier_names


import 'package:datalines/presentation/common/animation/animation_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/data/network/error_handler.dart';
import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:datalines/presentation/resources/font_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/style_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:datalines/presentation/resources/assets_manager.dart';

import '../dialogs/custom_dialog.dart';

enum StateRendererType {
  POPUP_LOADING,
  POPUP_ERROR,
  POPUP_SUCCESS,
  POPUP_WARNING,

  FULLSCREEN_LOADING,
  FULLSCREEN_ERROR,
  FULLSCREEN_EMPTY,

  CONTENT_STATE
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String title;
  final String message;
  final int? code;
  final void Function()? onRetryButton;

  @override
  Widget build(BuildContext context) {
    return Center(child: _getStateWidget(stateRendererType, context));
  }

  Widget _getStateWidget(
      StateRendererType stateRendererType, BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING:

            return const CustomDialog(
              children:  [
                AnimationBox(AnimationAssets.loading)
              ],
            );
      case StateRendererType.POPUP_ERROR:
        return WillPopScope(
          onWillPop: () async {
            this.onRetryButton?.call();
            return true;
          },
          child: CustomDialog(
            children: [
              code == ResponseCode.NO_INTERNET_CONNECTION
                  ? const AnimationBox(AnimationAssets.noInternet)
                  : const AnimationBox(AnimationAssets.error),
              _getMessage(message),
              _getRetryButton(AppStrings.ok, context)
            ],
          ),
        );

      case StateRendererType.FULLSCREEN_LOADING:
        return _getItemsColumn(
            [const AnimationBox(AnimationAssets.loading, height: AppSize.s200)]);

      case StateRendererType.FULLSCREEN_ERROR:
        return _getItemsColumn([
         const  AnimationBox(AnimationAssets.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain, context)
        ]);

        break;
      case StateRendererType.FULLSCREEN_EMPTY:
        return _getItemsColumn(
            [const AnimationBox(AnimationAssets.empty), _getMessage(message)]);

      case StateRendererType.CONTENT_STATE:
        return Container();

      case StateRendererType.POPUP_SUCCESS:
        return WillPopScope(
          onWillPop: () async {
            this.onRetryButton?.call();
            return true;
          },
          child: CustomDialog(children : [
            const AnimationBox(AnimationAssets.success),
            _getMessage(message),
            _getRetryButton(AppStrings.ok, context)
          ]),
        );
      case StateRendererType.POPUP_WARNING:
        return CustomDialog(
          children: [
            const AnimationBox(AnimationAssets.warning),
            _getMessage(message),
            _getRetryButton(AppStrings.ok, context)
          ],
        );
    }
  }



  Widget _getItemsColumn(List<Widget> children) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children);
  }

  Widget _getMessage(String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style:
            getRegularStyle(color: ColorManager.black, fontSize: FontSize.s18),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: SizedBox(
        width: 100.w,
        child: ElevatedButton(
            onPressed: onRetryButton ??  () {
              Navigator.pop(context);
            },
            child: FittedBox(child: Text(buttonTitle))),
      ),
    );
  }

  const StateRenderer({
    required this.stateRendererType,
    this.title = '',
    required this.message,
    this.code,
    required this.onRetryButton,
  });
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
