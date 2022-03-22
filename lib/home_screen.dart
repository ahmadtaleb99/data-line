// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';
import 'package:form_builder_test/Widgets/DrawRadioItem.dart';

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
          if(state.status == Status.initial)
            return Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<ValidationBloc>().add(StateFormRequested(formId: 0));
                  },
                  child: Text('load form 1 '),
                ),
                FloatingActionButton(
                  onPressed: () {
                    context.read<ValidationBloc>().add(StateFormRequested(formId: 1));
                  },
                  child: Text('load form 2 '),
                ),
              ],
            );
          else            if(state.status == Status.success)

            return   ElevatedButton(
               onPressed: () {
                 if (_key.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('form is valid ')));
                 }
               },
               child: Text('submit form '));
          else return Container ();
        },
        ),
        appBar: AppBar(),
        body: Form(
          key: _key,
          child: BlocListener<ValidationBloc, ValidationState>(
            listener: (context, state) {
              for (var kza in state.childItems)
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(kza.value),
                  duration: Duration(microseconds: 500),));
              // TODO: implement listener
            },
            child: Center(

              child: SingleChildScrollView(
                child: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocBuilder<ValidationBloc, ValidationState>(
                        builder: (context, state) {

                          if (state.status == Status.loading)
                            return CircularProgressIndicator();
                          else if (state.status == Status.success) {
                            print(state.formElements![1].visible);
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: state.formElements!.cast(),
                              ),
                            );
                          } else
                            return Container();
                        },
                      ),


                    ]),
              ),
            ),
          ),
        ));
  }
}
