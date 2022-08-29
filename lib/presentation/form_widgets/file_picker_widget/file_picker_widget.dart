import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_test/app/extenstions.dart';
import 'package:form_builder_test/domain/model/file_picker_model/file_picker_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';
import 'package:form_builder_test/presentation/resources/values_manager.dart';

import '../../resources/color_manager.dart';

class FilePickerWidget extends StatelessWidget {

  final FilePickerModel model;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsBloc, FormsState>(

      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            FormFieldWidget(
              onSaved: (value){
                context.read<FormsBloc>().add(FilePickerSaved(model: model));
              },
                validator: (value){
                  return context.read<FormsBloc>().validateFile(model);
                },
                widget: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(

                    onPressed: () {
                      context.read<FormsBloc>().add(FilePickerPressed(
                          model: model));
                    }, child: const Text(AppStrings.uploadFile),
                  ),
                ),
       if(_isFileLoading(state)) SpinKitThreeInOut(
        color: ColorManager.primary,
          size: 25,
     ),
               if(_getValue(state) != null)  Column(
                  children: [
                    const SizedBox(height: AppSize.s8),
                    Text(AppStrings.file + ': '+_getValue(state)!.getName())

                  ],
                ),
              ],
            ), model: model),
          ],
        );
      },
    );
  }

  const FilePickerWidget({
    required this.model,
  });

  File? _getValue(FormsState state){
    String? path = state.valuesMap[model.name];

    if(path != null){
      return File(path);
    }
    return null;

  }

  bool _isFileLoading(FormsState state){
    bool? isLoading = state.isFilePicking[model.name];
    if(isLoading == null) return false;

    return isLoading;
  }



}
