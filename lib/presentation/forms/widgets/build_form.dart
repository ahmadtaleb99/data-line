import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_model.dart';
import 'package:form_builder_test/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class BuildForm extends StatelessWidget {
  const BuildForm({Key? key, required this.formModel}) : super(key: key);
  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(

      buildWhen: (p,c) => p.newFlowState!= c.newFlowState,
      builder: (context, state) {
        if (state.newFlowState != null) {
          var widget = state.newFlowState
              .getWidget(context, _BuildForm(), () {

            if(state.newFlowState is SuccessState) {
              if(state.isNewSubmit)
                context.read<FormsBloc>().add(NewFormRequested(formModel));



            }

          });
          return widget;
        } else {
          return _BuildForm();
        }
      },
    );
  }
}

class _BuildForm extends StatelessWidget {
  const _BuildForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p18, vertical: AppPadding.p8),
                child: state.formModel!.fields[index].toWidget(),
              );
            },
            itemCount: state.formModel!.fields.length);
      },
    );
  }
}
