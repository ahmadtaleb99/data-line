import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/login/bloc/login_bloc.dart';
import 'package:form_builder_test/presentation/resources/assets_manager.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//       body: BlocBuilder<StateRendererBloc, StateRendererState>(
//         bloc: getIT<StateRendererBloc>(),
//   builder: (context, state) {
//     if(state.flowState != null ){
//       return state.flowState.getWidget(context,_getWidget(context),(){
//       });
//     }
//     else 
//       return _getWidget(context);
//   },
// )
      body: _getWidget(context)
    );
  }


  _getWidget (BuildContext context) {
    return SingleChildScrollView(
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

                child:    TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,

                  style: Theme.of(context).textTheme.headline1,
                  decoration: InputDecoration(hintText: AppStrings.username.tr()),
                ),
              ),
              SizedBox(
                height: 19.8.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 46.w),
                child: TextFormField(
                  style: Theme.of(context).textTheme.headline1,
                  decoration:  InputDecoration(
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
                  child: ElevatedButton(
                      onPressed:  () {
                       context.read<LoginBloc>().add(UserLoggedIn('username', 'password'));
                      } ,
                      child:  Text(
                        AppStrings.login.tr(),
                      ))),
              SizedBox(
                height: 19.h,
              ),
              Padding(
                padding:  EdgeInsets.only(right: 38.0.w,left: 37.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: (){
                        // Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                      },
                      child: Text(
                        AppStrings.forgetPassword.tr(),
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),

                    TextButton(
                        onPressed: (){
                          // Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child:  Text(
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
    );
  }
}
