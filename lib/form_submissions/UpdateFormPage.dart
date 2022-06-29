import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Widgets/form_widget.dart';
import '../utils/loading_overlay.dart';
import '../validation/bloc/validation__bloc.dart';


class UpdateFormPage extends StatelessWidget {
  
  
  FormWidget form;
  UpdateFormPage({Key? key, required this.form, required this.index})
      : super(key: key);
  late GlobalKey<FormState> _key;
  final int index;
  final _loadingOverlay = LoadingService.instance;

  @override
  Widget build(BuildContext context) {
    log(form.fields[2].name);
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

              }
            },
            child: Text('Update form ')),
        appBar: AppBar(
          title: Text('Update Form Submission'),
          centerTitle: true,
        ),
        body:               BlocConsumer<ValidationBloc, ValidationState>(

          listener: (context,state) {
            if(state.status == Status.loading)
              _loadingOverlay.show(context,msg:'updating form ...');
            else
              _loadingOverlay.hide();


            if(state.updated! && state.status == Status.success) {
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
              return state.form!;
            } else
              return Container();
          },
        ),
    );
  }
}
