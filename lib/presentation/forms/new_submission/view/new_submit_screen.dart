import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/widgets/build_form.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class NewSubmitScreen extends StatelessWidget {
  const NewSubmitScreen({Key? key, required this.formModel}) : super(key: key);
  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          context.read<FormsBloc>().add(FormSubmitted(formModel));
        },
        child: const Text(AppStrings.submit),
      ),
      body: BuildForm(formModel: formModel,),
    );


  }
}
