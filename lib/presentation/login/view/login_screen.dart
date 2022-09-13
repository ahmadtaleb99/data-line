import 'dart:developer';

import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/data/repository_impl/authentication_repository_impl.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:datalines/presentation/login/bloc/login_bloc.dart';
import 'package:datalines/presentation/resources/assets_manager.dart';
import 'package:datalines/presentation/resources/routes_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/presentation/state_renderer_bloc/state_renderer_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<LoginBloc, LoginState>(
          buildWhen: (p, c) => p.flowState != c.flowState,
          builder: (context, state) {
            log('has been built ${state.flowState.runtimeType.toString()}');
            if (state.flowState != null) {
              log('has been built   if (state.flowState != null) {');

              var widget = state.flowState.getWidget(context, NewWidget(), () {});
              return widget;
            } else {
              return NewWidget();
            }
          },
        )
        // body: NewWidget()
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
        if (state.hasLoggedIn) {
          context.read<AuthenticationBloc>().add(
              AuthenticationStatusChanged(
                  status: AuthenticationStatus.authenticated));
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
                  initialValue: 'test',
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
                  initialValue: 'test',
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
                          onPressed: state.allValid
                              ? () {
                                  context.read<LoginBloc>().add(UserLoggedIn());
                                }
                              : null,
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
