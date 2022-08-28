import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/widgets/build_form.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class NewSubmitScreen extends StatelessWidget {
   NewSubmitScreen({Key? key, required this.formModel}) : super(key: key);
  final FormModel formModel;
    final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key :  UniqueKey(),
      appBar: AppBar(

      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          _key.currentState!.save();

            if(          _key.currentState!.validate())  {

              context.read<FormsBloc>().add(FormSubmitted(formModel));
            }

        },
        child: const Text(AppStrings.submit),
      ),
      body: Form(key:_key,child: BuildForm(formModel: formModel,)),
    );


  }
}
