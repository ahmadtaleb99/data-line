import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/form__bloc.dart';

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
        ),
        appBar: AppBar(),
        body: Form(
          key: _key,
          child: Center(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center ,
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
                      itemCount: state.formElements.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: state.formElements,
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
              child: Text('asd'))
            ]),
          ),
        ));
  }
}
