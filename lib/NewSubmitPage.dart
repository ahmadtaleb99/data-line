import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/logic/utils.dart';

import 'FormService/FormRepository.dart';
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

      if(state.submitted! && state.status == Status.success) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('form has been submitted'),duration: Duration(milliseconds: 600)));

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
