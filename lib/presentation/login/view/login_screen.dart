import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/login/bloc/login_bloc.dart';
import 'package:form_builder_test/presentation/resources/assets_manager.dart';
import 'package:form_builder_test/presentation/resources/routes_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<StateRendererBloc, StateRendererState>(
      builder: (context, state) {
        if (state.flowState != null) {
          var widget = state.flowState.getWidget(context, NewWidget(), () {
            context.read<LoginBloc>().add(UserLoggedIn());
          });
          log(widget.hashCode.toString());
          return widget;
        } else {
          log('else');
          return NewWidget();
        }
      },
    )
//       body: _getWidget(context)
        );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
  listener: (context, state) {
    if(state.hasLoggedIn) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      });
    }

  },
  child: SingleChildScrollView(
      child: Center(
        child: Form(
          // key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 85.h,
              ),
              SizedBox(
                height: 155.h,
                width: 155.w,
                child: Image.asset(ImageAssets.flexLogo),
              ),
              SizedBox(
                height: 43.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 46.w),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (username) =>
                      context.read<LoginBloc>().add(UsernameChanged(username)),
                  style: Theme.of(context).textTheme.headline1,
                  decoration:
                      InputDecoration(hintText: AppStrings.username.tr()),
                ),
              ),
              SizedBox(
                height: 19.8.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 46.w),
                child: TextFormField(
                  onChanged: (username) =>
                      context.read<LoginBloc>().add(PasswordChanged(username)),
                  style: Theme.of(context).textTheme.headline1,
                  decoration: InputDecoration(
                    hintText: AppStrings.password.tr(),
                  ),
                ),
              ),
              SizedBox(
                height: 47.h,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 46.w),
                  width: double.infinity,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return ElevatedButton(
                          onPressed: state.allValid ? () {
                            context.read<LoginBloc>().add(UserLoggedIn());
                          } :  null ,
                          child: Text(
                            AppStrings.login.tr(),
                          ));
                    },
                  )),
              SizedBox(
                height: 19.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 38.0.w, left: 37.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                      },
                      child: Text(
                        AppStrings.forgetPassword.tr(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: Text(
                          AppStrings.notAMember.tr(),
                          style: Theme.of(context).textTheme.bodyText2,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
);
  }
}
