// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';
import 'package:form_builder_test/Widgets/DrawRadioItem.dart';
import 'package:form_builder_test/form1Page.dart';
import 'package:multi_select_flutter/dialog/mult_select_dialog.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'form2Page.dart';
import 'logic/form__bloc.dart';
import 'logic/validation__bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // var list = FormRepository().jsonSeilize();

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton:  BlocBuilder<ValidationBloc, ValidationState>(

        builder: (context, state) {

           return Container ();
        },
        ),
        appBar: AppBar(),
        body: Form(
          key: _key,
          child: Center(

            child: SingleChildScrollView(
              child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      onPressed: () {
                        context.read<ValidationBloc>().add(StateFormRequested(formId: 0));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Form1Page()));

                      },
                      child: Text('load form 1 '),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ValidationBloc>().add(StateFormRequested(formId: 1));
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Form2Page()));
                      },
                      child: Text('load form 2 '),
                    ),
                    SizedBox(height: 20,),
                    BlocBuilder<ValidationBloc, ValidationState>(
                      builder: (context, state) {

                        if (state.status == Status.loading)
                          return CircularProgressIndicator();
                        // else if (state.status == Status.success) {
                        //   print(state.formElements![1].visible);
                        //   return Padding(
                        //     padding:
                        //         const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        //     child: Column(
                        //       children: state.formElements!.cast(),
                        //     ),
                        //   );
                        // } else
                          return Container();
                      },
                    ),
                    SizedBox(height: 30  ,),



                  ]),
            ),
          ),
        ));
  }
}
