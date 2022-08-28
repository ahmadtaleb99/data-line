import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/file_picker_model/file_picker_model.dart';
import 'package:form_builder_test/presentation/form_widgets/form_field_widget/form_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';
import 'package:form_builder_test/presentation/resources/strings_manager.dart';

class FilePickerWidget extends StatelessWidget {

  final FilePickerModel model;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormFieldWidget(widget: SizedBox(
          width: double.infinity,
          child: ElevatedButton(

            onPressed: (){
                context.read<FormsBloc>().add(FilePickerPressed(model: model));
            }, child: const Text(AppStrings.uploadFile),
          ),
        ), model: model),
      ],
    );
  }

  const FilePickerWidget({
    required this.model,
  });
}
