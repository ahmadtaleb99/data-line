// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:form_builder_test/form1Page.dart';

import 'form2Page.dart';
import 'logic/form__bloc.dart';
import 'logic/validation__bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {


    return Scaffold(
        floatingActionButton: BlocBuilder<ValidationBloc, ValidationState>(
          builder: (context, state) {
            return Container();
          },
        ),
        appBar: AppBar(actions: [
          TextButton(
              onPressed: () {
                context
                    .read<ValidationBloc>()
                    .add(StateFormRequested());
              },
              child: Text(
                'load forms from internet',
                style: TextStyle(color: Colors.black),
              ))
        ]),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(
                  height: 20,
                ),
                BlocBuilder<ValidationBloc, ValidationState>(
                  builder: (context, state) {
                    if (state.status == Status.loading)
                      return CircularProgressIndicator();
                    else if (state.status == Status.success) {
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Form1Page(
                                              form: state.forms![index],
                                            )));
                                context.read<ValidationBloc>().add(
                                    FormRequested(
                                        formName: state.forms![index].name));
                              },
                              child: Text(state.forms![index].name.toString()),
                            );
                          },
                          itemCount: state.forms!.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(),
                        ),
                      );
                    } else
                      return Container();
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ]),
        ));
  }
}
