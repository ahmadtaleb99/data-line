import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'FormService/FormRepository.dart';
import 'Widgets/DrawForm.dart';
import 'logic/validation__bloc.dart';

class NewSubmitPage extends StatelessWidget {

   FormWidget form;
   NewSubmitPage ({Key? key, required this.form}) : super(key: key);
  late GlobalKey<FormState> _key;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: ElevatedButton(

          onPressed: () {

            if (form.validate()) {
              form.save();

              context.read<ValidationBloc>().add(FormSubmitted(formName: this.form.name));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('form is valid ')));
            // context.read<FormRepository>().savetoLocal();
            // context.read<FormRepository>().getForm();


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
  BlocBuilder<ValidationBloc, ValidationState>(
  builder: (context, state) {

  if (state.status == Status.loading)
  return CircularProgressIndicator();
  else if (state.status == Status.success) {
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
