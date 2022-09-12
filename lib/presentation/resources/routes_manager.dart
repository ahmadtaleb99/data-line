import 'package:datalines/presentation/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/domain/repository/form_repository.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/home/bloc/home_bloc.dart';
import 'package:datalines/presentation/home/view/home_screen.dart';
import 'package:datalines/presentation/login/bloc/login_bloc.dart';
import 'package:datalines/presentation/login/view/login_screen.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/state_renderer_bloc/state_renderer_bloc.dart';
import 'package:get_it/get_it.dart';

class Routes {
  static const String homeRoute = "/home";
  static const String splashRoute = "/splash";
  static const String submissionsRoute = "/submissions";
  static const String submissionDetailsRoute = "/submissionDetails";
  static const String newFormRoute = "/newFormRoute";
  static const String updateFormRoute = "/updateFormRoute";
  static const String loginRoute = "/login";
}

class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        initFormModule();
        return MaterialPageRoute(
            builder: (_) =>  MultiBlocProvider(providers: [
              BlocProvider(create: (context) =>  FormsBloc(getIt<AssignedFormRepository>())
                ..add(FormsPageRequested())),
            ], child: const HomeScreen()));

      case Routes.loginRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => LoginBloc(), child: const LoginScreen()));

        case Routes.splashRoute:
        return MaterialPageRoute(
            builder: (_) => const SplashScreen());

      default:
        return null;
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
