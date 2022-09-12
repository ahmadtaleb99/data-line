import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/data/repository_impl/authentication_repository_impl.dart';
import 'package:datalines/presentation/home/view/widgets/sync_button_widget.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/values_manager.dart';


class InactiveFormCard extends StatelessWidget {
  const InactiveFormCard(
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
    return ClipRect(
      child: CustomPaint(
        child: Banner(
          color: Colors.red[900]!,
          location: BannerLocation.topStart,
          message: AppStrings.revoked,
          child: Container(
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
                        style: Theme.of(context).textTheme.overline!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18.sp),
                      ))),
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SyncButtonWidget(onPressed: (){
                            context.read<AuthenticationBloc>().add(
                                AuthenticationStatusChanged(
                                    status: AuthenticationStatus.unauthenticated));
                          },)
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
