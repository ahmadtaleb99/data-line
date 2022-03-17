// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/DrawCheckbox.dart';

import 'logic/form__bloc.dart';
import 'logic/validation__bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  // var list = FormRepository().jsonSeilize();

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<FormBloc>().add(FormRequested());
          },
          child: Text('load'),
        ),
        appBar: AppBar(),
        body: Form(
          key: _key,
          child: BlocListener<ValidationBloc, ValidationState>(
            listener: (context, state) {
              for(var kza  in state.childItems)
              Scaffold.of(context).showSnackBar(SnackBar(content: Text(kza.value),duration: Duration(microseconds: 500),));
              // TODO: implement listener
            },
            child: Center(

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: Text('hit me ')),
                    BlocBuilder<FormBloc, BlocFormState>(
                      builder: (context, state) {
                        if (state is FormLoading)
                          return CircularProgressIndicator();
                        else if (state is FormLoaded)
                          return Expanded(

                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                              addAutomaticKeepAlives: true,
                              cacheExtent: 40,
                                itemCount: state.formElements.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,

                                      children: [

                                        Text(''),
                                        state.formElements[index]
                                      ]
                                  );
                                }),
                          );
                        else
                          return Text('somthing wen wrong ');
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {}
                        },
                        child: Text('submit form ')),
                    DrawCheckbox(label: 'hello', validator: (value) {
                      return value == false ? 'valid' : 'not valid';
                    },),
                  ]),
            ),
          ),
        ));
  }
}
