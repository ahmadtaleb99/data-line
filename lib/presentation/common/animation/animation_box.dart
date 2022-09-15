import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:lottie/lottie.dart';
class AnimationBox extends StatelessWidget {

  final double? width;
  final double? height;
  final String animation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: SizedBox(
        height: height ?? AppSize.s100,
        width: width ?? AppSize.s100,
        child: Lottie.asset(animation),
      ),
    );
  }

  const AnimationBox(    this.animation,
      {
    this.width,
    this.height,
  });
}
