import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class NewSubmitScreen extends StatelessWidget {
  const NewSubmitScreen({Key? key,required this.formModel}) : super(key: key);
  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: WillPopScope(
          onWillPop: () async  {
            context.read<FormsBloc>().add(SubmitCanceled());
            return  true;
          },
          child: ListView.separated(
            separatorBuilder: (context, index) => const Padding(padding: EdgeInsets.all(AppPadding.p20)),
            itemBuilder: (context, index) {
              return formModel.fields[index].toWidget() ;
            },
            itemCount: formModel.fields.length
          ),
        ),
      ),
    );
  }
}
