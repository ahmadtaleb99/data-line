import 'dart:developer';

import 'package:cool_alert/cool_alert.dart';
import 'package:datalines/presentation/forms/widgets/node_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:datalines/app/dependency_injection.dart';
import 'package:datalines/domain/model/form_model.dart';
import 'package:datalines/presentation/common/dialogs/warning_dialog.dart';
import 'package:datalines/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
import 'package:datalines/presentation/forms/new_submission/bloc/new_form_bloc.dart';
import 'package:datalines/presentation/forms/widgets/build_form.dart';
import 'package:datalines/presentation/resources/routes_manager.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:datalines/presentation/resources/values_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/model/node/node.dart';
import '../../../common/snackbars/snackbars.dart';

class NewSubmitScreen extends StatelessWidget {
  final FormModel formModel;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (context.read<FormsBloc>().hasValues()) {
          showWarningDialog(context, text: AppStrings.submitBackWarningMgs,
              onConfirmBtnTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              });
        } else
          return true;

        return false;
      },
      child: Scaffold(
          key: UniqueKey(),
          appBar: AppBar(
            actions: [NodeWidget()],
            title: const Text(AppStrings.newSubmission),
          ),
          floatingActionButton: BlocBuilder<FormsBloc, FormsState>(
            builder: (context, state) {

              return ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  bool isFormValid = _key.currentState!.validate();
                  if(state.currentNode == null)
                showSnackBar(context,AppStrings.selectNodeWarning);


                  if (isFormValid && state.currentNode != null) {
                    _key.currentState!.save();
                    await context.read<FormsBloc>().saveForm();
                  }
                },
                child: const Text(AppStrings.submit),
              );
            },
          ),
          // body: BlocConsumer<FormsBloc, FormsState>(
          //   listener: (context, state) {
          //     // if(state.allSaved)      context.read<FormsBloc>().add(FormSubmitted(formModel));
          //
          //   },
          //   buildWhen: (p, c) => p.newFlowState != c.newFlowState,
          //   builder: (context, state) {
          //     if (state.newFlowState != null) {
          //       var widget = state.newFlowState.getWidget(
          //           context,
          //           NewWidget(
          //             formModel: formModel,
          //             formKey: _key,
          //           ), () {
          //
          //             log(state.newFlowState.toString());
          //             log(state.flowState.toString());
          //        if(state.newFlowState is SuccessState)
          //          context.read<FormsBloc>().add(NewFormRequested(formModel));
          //
          //       else context.read<FormsBloc>().add(AssignedFormsRequested());
          //       });
          //       return widget;
          //     } else {
          //       return NewWidget(
          //         formModel: formModel,
          //         formKey: _key,
          //       );
          //     }
          //
          //
          //     // return NewWidget(
          //     //   formModel: formModel,
          //     //   formKey: _key,
          //     // );
          //   },
          // ),
          body: NewWidget(
            formModel: formModel,
            formKey: _key,
          )),
    );
  }

  NewSubmitScreen({
    required this.formModel,
  });
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key? key,
    required this.formKey,
    required this.formModel,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: BuildForm(
          formModel: formModel,
        ));
  }
}
