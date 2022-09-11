import 'package:datalines/presentation/home/view/widgets/sync_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class FormCard extends StatelessWidget {
  const FormCard(
      {Key? key,
      required this.viewSubmittedCallBack,
      required this.formName,
      required this.submitNewFormCallBack})
      : super(key: key);
  final String formName;
  final void Function()? viewSubmittedCallBack;
  final void Function()? submitNewFormCallBack;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300.w,
      height: 300.h,
      decoration: BoxDecoration(
          color: ColorManager.primary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppRadius.r10)),
      child: Card(
        elevation: 10,
        color: ColorManager.lightPrimary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.r10)),
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: Center(
                    child: Text(
                  formName,
                  style: Theme.of(context)
                      .textTheme
                      .overline!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
                ))),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: IconButton(
                          onPressed: submitNewFormCallBack,
                          icon: Icon(
                            Icons.add,
                            color: ColorManager.white,
                          )),
                    ),
                    Expanded(
                        flex: 2,
                        child: SyncButtonWidget(
                          onPressed: () {},
                        )),
                    Expanded(
                      child: IconButton(
                          onPressed: viewSubmittedCallBack,
                          icon: Icon(
                            Icons.visibility,
                            color: ColorManager.white,
                          )),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
