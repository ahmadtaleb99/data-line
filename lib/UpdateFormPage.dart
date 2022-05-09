import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'FormService/FormRepository.dart';
import 'Widgets/DrawForm.dart';
import 'logic/utils.dart';
import 'logic/validation__bloc.dart';

class UpdateFormPage extends StatelessWidget {
  FormWidget form;
  UpdateFormPage({Key? key, required this.form, required this.index})
      : super(key: key);
  late GlobalKey<FormState> _key;
  final int index;
  final LoadingOverlay _loadingOverlay = LoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                )
            ),
            onPressed: () {
              if (form.validate()) {
                form.save();
                context
                    .read<ValidationBloc>()
                    .add(FormUpdated(formName: form.name, index: this.index));
                // context.read<FormRepository>().savetoLocal();
                // context.read<FormRepository>().getForm();

              }
            },
            child: Text('Update form ')),
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<ValidationBloc, ValidationState>(

                    listener: (context,state) {
                      if(state.status == Status.loading)
                      _loadingOverlay.show(context,'updating form ...');
                      else
                        _loadingOverlay.hide();


                      if(state.submitted! && state.status == Status.success) {
                        log('message');
                        CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: "Form is Updated successfuly!",
                            onConfirmBtnTap: (){
                              Navigator.pop(context);
                            }
                        );
                      }

                    },
                    builder: (context, state) {
                      print(state.submitted.toString()+'jijijijijijiji');

                      if (state.status == Status.success) {
                        form = state.form!;
                        // form = state.form!;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            children: [state.form!],
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
