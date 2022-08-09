import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/widgets/build_form.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class UpdateSubmissionScreen extends StatelessWidget {
  const UpdateSubmissionScreen({Key? key,required this.formModel,required this.submission}) : super(key: key);
  final FormModel formModel;
  final Submission submission;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          context.read<FormsBloc>().add(SubmissionUpdated(formModel,submission));
        },
        child: const Text(AppStrings.update),
      ),
      body: BuildForm(formModel: formModel,),
    );
  }
}
