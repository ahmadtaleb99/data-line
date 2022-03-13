import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';

import 'FormRepository.dart';
import 'dynamic form/person_bloc.dart';
import 'home_screen.dart';
import 'logic/form__bloc.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => FormRepository(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FormBloc(context.read<FormRepository>()),
            ),
            BlocProvider(
              create: (context) => ValidationBloc(context.read<FormRepository>()),
            ),
          ],
          child: HomeScreen(),
        ),
      ),
    );
  }
}

