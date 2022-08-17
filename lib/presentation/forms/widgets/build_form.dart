import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/form_model.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

class BuildForm extends StatelessWidget {
  const BuildForm({Key? key, required this.formModel}) : super(key: key);
  final FormModel formModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 50, vertical: AppPadding.p20),
      child: BlocBuilder<FormsBloc, FormsState>(
        builder: (context, state) {
          return ListView.separated(
              separatorBuilder: (context, index) =>
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p8)),
              itemBuilder: (context, index) {
                // log(state.formModel!.fields[1].toString());
                return state.formModel!.fields[index].toWidget();
              },
              itemCount: state.formModel!.fields.length
          );
        },
      ),
    );
  }
}
