import 'package:datalines/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';

import '../../../resources/strings_manager.dart';

class SyncButtonWidget extends StatelessWidget {
  final void  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return    TextButton(

      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            AppStrings.sync,
            style: TextStyle(color: ColorManager.white),
          ),
          Icon(Icons.sync,color: ColorManager.white,)
        ],
      ),
    );
  }

  const SyncButtonWidget({
    this.onPressed,
  });
}
