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
    return BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        return ListView.builder(

            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p14, vertical: AppPadding.p8),
                child: state.formModel!.fields[index].toWidget(),
              );
            },
            itemCount: state.formModel!.fields.length);
      },
    );
  }
}
