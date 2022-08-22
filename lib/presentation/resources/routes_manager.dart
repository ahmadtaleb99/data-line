import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/repository/form_repository.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/home/bloc/home_bloc.dart';
import 'package:form_builder_test/presentation/home/view/home_screen.dart';
import 'package:form_builder_test/presentation/login/bloc/login_bloc.dart';
import 'package:form_builder_test/presentation/login/view/login_screen.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/state_renderer_bloc/state_renderer_bloc.dart';
import 'package:form_builder_test/presentation/submission_details_screen/view/submisson_details_screen.dart';
import 'package:form_builder_test/presentation/submissions/view/submissions_screen.dart';
import 'package:get_it/get_it.dart';

class Routes {
  static const String homeRoute = "/home";
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
              BlocProvider(create: (context) =>  FormsBloc(getIT<AssignedFormRepository>())
                ..add(AssignedFormsRequested())),
            ], child: const HomeScreen()));

      case Routes.loginRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => LoginBloc(), child: const LoginScreen()));

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
