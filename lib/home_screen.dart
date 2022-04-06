// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:form_builder_test/NewSubmitPage.dart';
import 'package:form_builder_test/SubmittionsPage.dart';

import 'form2Page.dart';
import 'logic/form__bloc.dart';
import 'logic/validation__bloc.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({Key? key}) : super(key: key);
  Future<void> _refresh(BuildContext context) async{
    context.read<ValidationBloc>().add(FormsRequested());
  }


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
              onPressed: () {},
              child: Text(
                'load forms from internet',
                style: TextStyle(color: Colors.black),
              ))
        ]),
        body: RefreshIndicator(
          onRefresh: () async {
               context.read<ValidationBloc>().add(FormsRequested());
          },
          child: Center(
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
                        if (state.forms!.isEmpty) {
                          return Text('There are no submitted forms yet. ');
                        }
                        return Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(30),
                            itemCount: state.forms!.length,
                            itemBuilder: (context, index) {
                              return FormCard(
                                formName : state.forms![index].name,
                                submitNewFormCallBack: () {
                                   context.read<ValidationBloc>()
                                      .add(FormRequested(formName: state.forms![index].name));

                                 Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewSubmitPage(
                                            form: state.forms![index],
                                          )));

                                  // print(state.form!.value);

                                },
                                viewSubmittedCallBack: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubmittionsPage(
                                            form: state.forms![index],
                                          )));

                                  context.read<ValidationBloc>()
                                      .add(SubmittionsFormsRequested(formName: state.forms![index].name));
                                },
                              );
                              // return ElevatedButton(
                              //
                              //   style: ElevatedButton.styleFrom(
                              //     elevation: 20,
                              //     primary: Colors.lightBlueAccent,
                              //     shape: RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.circular(10)
                              //     )
                              //   ),
                              //   onPressed: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => Form1Page(
                              //                   form: state.forms![index],
                              //                 )));
                              //     context.read<ValidationBloc>().add(
                              //         FormRequested(
                              //             formName: state.forms![index].name));
                              //   },
                              //   child: Text(state.forms![index].name.toString(),style: TextStyle(color: Colors.black,fontSize: 15),),
                              // );
                            },
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 20.0,
                                    childAspectRatio: 1),
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
          ),
        ));
  }
}

class FormCard extends StatelessWidget {
  const FormCard(
      {Key? key,
      required this.viewSubmittedCallBack,
      required this.formName,
      required this.submitNewFormCallBack})
      : super(key: key);
  final String formName;
  final void Function()? viewSubmittedCallBack;
  final void Function()? submitNewFormCallBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Center(
                  child: Text(formName,
                      style: TextStyle(color: Colors.black, fontSize: 18)))),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed:submitNewFormCallBack ,
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: viewSubmittedCallBack,
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.white,
                      )),
                ],
              )),
        ],
      ),
    );
  }

}


