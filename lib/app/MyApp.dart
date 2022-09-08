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
  final _appPrefs = getIT<AppPreferences>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 667),
        builder: (context, child) {
          return  MultiBlocProvider(providers: [
            BlocProvider.value(value:  getIT<StateRendererBloc>()),

          ],
            child: MaterialApp(

              debugShowCheckedModeBanner: false,
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: Routes.homeRoute ,
              theme: getApplicationTheme(),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

            ),
          );
        });
  }
}
