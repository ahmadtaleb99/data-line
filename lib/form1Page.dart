import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Widgets/DrawForm.dart';
import 'logic/validation__bloc.dart';

class Form1Page extends StatelessWidget {

  final DrawForm form;
   Form1Page ({Key? key, required this.form}) : super(key: key);
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(

          onPressed: () {

            if (form.validate()) {

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('form is valid ')));
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
  return Padding(
  padding:
  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
  child: Column(
  children: [form],

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
