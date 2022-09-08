import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/forms/widgets/build_form.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';

class UpdateSubmissionScreen extends StatelessWidget {
  UpdateSubmissionScreen(
      {Key? key, required this.formModel, required this.submission})
      : super(key: key);
  final FormModel formModel;
  final Submission submission;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.updateSubmission),

      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (_key.currentState!.validate()) {
            _key.currentState!.save();
            context.read<FormsBloc>().add(
                SubmissionUpdated(formModel, submission));
          }
        },
        child: const Text(AppStrings.update),
      ),
    //   body: BlocBuilder<FormsBloc, FormsState>(
    //  builder: (context, state) {
    // if (state.updateFlowState != null) {
    // var widget = state.updateFlowState.getWidget(
    // context,
    // NewWidget(
    //   formKey: _key,
    //   formModel: formModel,
    // ), () {
    //     Navigator.pop(context);
    // });
    // return widget;
    // } else {
    // return NewWidget(
    //   formKey: _key,
    // formModel: formModel,
    // );
    // }


          body: NewWidget(
            formModel: formModel,
            formKey: _key,
          )
    );
  }
}

class NewWidget extends StatelessWidget {
  NewWidget({

    Key? key,
    required this.formKey,
    required this.formModel,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Form(key: formKey, child: BuildForm(formModel: formModel,));
  }
}
