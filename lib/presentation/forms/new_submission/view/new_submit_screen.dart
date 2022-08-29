import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/app/dependency_injection.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/forms/new_submission/bloc/new_form_bloc.dart';
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

            if(          _key.currentState!.validate())  {
              _key.currentState!.save();

              context.read<FormsBloc>().add(FormSubmitted(formModel));
            }

        },
        child: const Text(AppStrings.submit),
      ),
      body: BlocBuilder<FormsBloc, FormsState>(
        buildWhen: (p, c) => p.newFlowState != c.newFlowState,
        builder: (context, state) {
          if (state.newFlowState != null) {
            var widget =
            state.newFlowState.getWidget(context,  NewWidget(formModel: formModel,formKey: _key,), () {
              context.read<FormsBloc>().add(AssignedFormsRequested());
            });
            return widget;
          } else {
            return  NewWidget(formModel: formModel,formKey: _key,);
          }
        },
      ),
    );


  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required  this.formKey,
    required this.formModel,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Form(key:formKey,child: BuildForm(formModel: formModel,));
  }
}
