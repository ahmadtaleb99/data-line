import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/logic/utils.dart';
import 'package:cool_alert/cool_alert.dart';

import 'data/FormRepository.dart';
import 'Widgets/DrawForm.dart';
import 'logic/validation__bloc.dart';

class NewSubmitPage extends StatelessWidget {

   FormWidget form;
   NewSubmitPage ({Key? key, required this.form}) : super(key: key);
  late GlobalKey<FormState> _key;
  LoadingOverlay _loadingOverlay =  LoadingOverlay();

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

              context.read<ValidationBloc>().add(FormSubmitted(formName: this.form.name));


            }
          },
          child: Text('submit form ')),
    appBar: AppBar(

    ),
    body: Center(

  child: SingleChildScrollView(
  child: Column(

  mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  SizedBox(height: 20,),
  BlocConsumer<ValidationBloc, ValidationState>(
    listener: (context,state){
      if(state.status == Status.loading)
      _loadingOverlay.show(context,'submitting ...');
      else _loadingOverlay.hide();

      if(state.submitted! && state.status == Status.success) {
   CoolAlert.show(
     context: context,
     type: CoolAlertType.success,
     text: "Form is Submitted successfuly!",
     onConfirmBtnTap: (){
       Navigator.pop(context);
     }
   );
    }

    },
  builder: (context, state) {



   if (state.status == Status.success) {
    form =state.form!;
  return Padding(
  padding:
  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
  child: Column(
  children: [state.form!],

  ),
  );
  } else
  return Container();
  },
  ),
  SizedBox(height: 30  ,),



  ]),
  ),
    ));
  }
}
