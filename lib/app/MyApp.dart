import 'dart:developer';

import 'package:datalines/app/authtication_bloc/authentication_bloc.dart';
import 'package:datalines/data/repository_impl/authentication_repository_impl.dart';
import 'package:datalines/domain/repository/repository.dart';
import 'package:datalines/presentation/home/view/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:datalines/app/app_prefs.dart';
import 'package:datalines/app/dependency_injection.dart';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/resources/routes_manager.dart';
import 'package:datalines/presentation/resources/theme_manager.dart';
import 'package:datalines/presentation/state_renderer_bloc/state_renderer_bloc.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();

  static final _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appPrefs = getIt<AppPreferences>();
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, child) {
          return BlocProvider(
            create: (context) {
             return initAuthModule();
            },
            child: MaterialApp(
              navigatorKey: _navigatorKey,
              builder: (context, child) {
                return BlocListener<AuthenticationBloc, AuthenticationState>(

                  listener: (context, state) {
                    log('AUTH LISTENER INVOKED');
                    switch (state.status) {
                      case AuthenticationStatus.authenticated:
                        Future.delayed(Duration.zero, () =>
                            _navigator.pushNamedAndRemoveUntil<void>(
                              Routes.homeRoute,
                                  (route) => false,
                            ));
                        break;
                      case AuthenticationStatus.unauthenticated:
                        Future.delayed(Duration.zero, () =>
                            _navigator.pushNamedAndRemoveUntil<void>(
                              Routes.loginRoute,
                                  (route) => false,
                            ));
                        break;
                      case AuthenticationStatus.unknown:
                        break;
                    }
                  },
                  child: child,
                );
              },
              initialRoute: Routes.splashRoute,
              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.getRoute,
              theme: getApplicationTheme(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            ),
          );
        });
  }
}
