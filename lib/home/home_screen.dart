// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:form_builder_test/form_submissions/new_submit_screen.dart';
import 'package:form_builder_test/form_submissions/SubmittionsPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Widgets/Matrix/cubit/matrix_record_cubit.dart';
import '../data/FormRepository.dart';
import '../validation/bloc/validation__bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
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
        appBar: AppBar(  title: Text('Home Page '),
          centerTitle: true,),
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
                  BlocConsumer<ValidationBloc, ValidationState>(
                    listener: (context, state) {
                      if (state.status == Status.newFormLoaded)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewSubmitScreen(
                                      form: state.form!,
                                    )));
                    },
                    builder: (context, state) {
                      if (state.status == Status.loading)
                        return CircularProgressIndicator();
                      else if (state.status == Status.success) {
                        if (state.forms!.isEmpty) {
                          return Text('There are no Assigned forms yet. ');
                        }
                        return Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Assigned Forms',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: GridView.builder(
                                  padding: EdgeInsets.all(40),
                                  itemCount: state.forms!.length,
                                  itemBuilder: (context, index) {
                                    return FormCard(
                                      formName: state.forms![index].name,
                                      submitNewFormCallBack: () async {
                                        context.read<ValidationBloc>().add(
                                            FormRequested(
                                                formName:
                                                state.forms![index].name));

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BlocProvider(
                                                      create: (context) => MatrixRecordCubit(context.read<FormRepository>())..setCurrentForm(index)..loadMatrices(),
                                                      child: NewSubmitScreen(
                                                        form: state
                                                            .forms![index],
                                                      ),
                                                    )));
                                        // print(state.form!.value);
                                      },
                                      viewSubmittedCallBack: () {
                                        context.read<ValidationBloc>().add(
                                            SubmittionsFormsRequested(
                                                formName:
                                                state.forms![index].name));

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SubmittionsPage(
                                                      form: state.forms![index],
                                                    )));
                                      },
                                    );
                                  },
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 20.0,
                                      childAspectRatio: 1),
                                ),
                              ),

                            ],
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
  const FormCard({Key? key,
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
                      onPressed: submitNewFormCallBack,
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



