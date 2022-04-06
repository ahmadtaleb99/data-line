import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/UpdateFormPage.dart';

import 'FormService/FormRepository.dart';
import 'Widgets/DrawForm.dart';
import 'logic/validation__bloc.dart';

class SubmittionsPage extends StatelessWidget {
  FormWidget form;

  SubmittionsPage({Key? key, required this.form}) : super(key: key);
  late GlobalKey<FormState> _key;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ElevatedButton(
            onPressed: () {
              if (form.validate()) {
                context
                    .read<ValidationBloc>()
                    .add(FormSubmitted(formName: this.form.name));
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('form is valid ')));
                // context.read<FormRepository>().savetoLocal();
                // context.read<FormRepository>().getForm();

              }
            },
            child: Text('submit form ')),
        appBar: AppBar(
          title: Text(form.name),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              BlocBuilder<ValidationBloc, ValidationState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.subedForms!.length, itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,
                            horizontal: 30),
                        child: SubmittionCard(onUpdateCallBack: () {
                          context.read<ValidationBloc>().add(FormUpdateRequested(formName: this.form.name, index: index,context: context));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => UpdateFormPage(
                          //           form: state.form!,
                          //         )));
                        }, onViewCallBack: () {

                        }, onDeleteCallBack: () {

                        },),
                      );
                    }),
                  );
                },
              ),
            ],
          ),
        ));
  }
}


class SubmittionCard extends StatelessWidget {
  const SubmittionCard({Key? key,required this.onDeleteCallBack,required this.onViewCallBack, required this.onUpdateCallBack}) : super(key: key);
final void Function()? onDeleteCallBack;
final void Function()? onViewCallBack;
final void Function()? onUpdateCallBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 155,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Center(
                  child: Text('formName',
                      style: TextStyle(color: Colors.black, fontSize: 18)))),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: onViewCallBack,
                      icon: Icon(
                        Icons.visibility,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: onUpdateCallBack,

                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: onDeleteCallBack,

                      icon: Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
