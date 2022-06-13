// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:form_builder_test/NewSubmitPage.dart';
import 'package:form_builder_test/SubmittionsPage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'logic/form__bloc.dart';
import 'logic/validation__bloc.dart';

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
        appBar: AppBar(actions: [

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
                  BlocConsumer<ValidationBloc, ValidationState>(
                    listener: (context, state) {


                      if (state.status == Status.newFormLoaded)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewSubmitPage(
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
                              MyStatefulWidget(),

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
                                                    NewSubmitPage(
                                                      form: state.forms![index],
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


class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const ExpansionTile(
          title: Text('ExpansionTile 1'),
          subtitle: Text('Trailing expansion arrow icon'),
          children: <Widget>[
            ListTile(title: Text('This is tile number 1')),
          ],
        ),
        ExpansionTile(
          title: const Text('ExpansionTile 2'),
          subtitle: const Text('Custom expansion arrow icon'),
          trailing: Icon(
            _customTileExpanded
                ? Icons.arrow_drop_down_circle
                : Icons.arrow_drop_down,
          ),
          children: const <Widget>[
            ListTile(title: Text('This is tile number 2')),
          ],
          onExpansionChanged: (bool expanded) {
            setState(() => _customTileExpanded = expanded);
          },
        ),
        const ExpansionTile(
          title: Text('ExpansionTile 3'),
          subtitle: Text('Leading expansion arrow icon'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('This is tile number 3')),
          ],
        ),
      ],
    );
  }
}