import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';

import 'FormService/FormRepository.dart';

class Form2Page extends StatelessWidget {
   Form2Page({Key? key}) : super(key: key);
  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
        body: Center(

          child: SingleChildScrollView(
            child: Form(
              key: _key,
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
                          print(state.formElements![1].visible);
                          return Padding(
                            padding:
                            const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children:[ ...state.formElements!.cast(),
                              SizedBox(height: 20,),
                                ElevatedButton(

                                    onPressed: () {
                                      if (_key.currentState!.validate()) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('form is valid ')));
                                      }
                                    },
                                    child: Text('submit form '))

                              ],

                            ),
                          );
                        } else
                          return Container();
                      },
                    ),
                    SizedBox(height: 30,),



                  ]),
            ),
          ),
        ));
  }
}
