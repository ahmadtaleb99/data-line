import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_checkbox_model/matrix_checkbox_model.dart';
import 'package:form_builder_test/domain/model/matrix_model/matrix_date_picker_model/matrix_date_picker_model.dart';
import 'package:form_builder_test/presentation/form_widgets/matrix_widget/widgets/matrix_field_widget/matrix_field_widget.dart';
import 'package:form_builder_test/presentation/forms/bloc/forms_bloc.dart';

class MatrixDatePickerWidget extends StatelessWidget {


  MatrixDatePickerModel model;

  @override
  Widget build(BuildContext context) {
    return MatrixFieldWidget(
      validator: (value) {
        // return context.read<FormsBloc>().validateNumber(numberFieldModel,state.valuesMap[numberFieldModel.name]);
      }, widget: BlocBuilder<FormsBloc, FormsState>(
      builder: (context, state) {
        final String initialDate = context.read<FormsBloc>().getMatrixFieldValue(model.fieldName) ?? '' ;
        return TextFormField(
                    readOnly: true,
          onTap: () async{
            final date = await getDate(context,DateTime.tryParse(initialDate));
            if(date != null)    context.read<FormsBloc>().add(MatrixFieldValueChanged(
                fieldName: model.fieldName, value: date.toString()));
          },
          key: UniqueKey(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: initialDate.isNotEmpty ? DateFormat('d - MMMM - y').format(DateTime.parse(initialDate)) : '',

          // initialValue: state.tempRecord!.valuesMap[model.fieldName].toString(),
        );
      },
    ), model: model,);
  }


  Future<DateTime?> getDate (BuildContext context,DateTime? initialDate) async {
   return await  showDatePicker(firstDate: DateTime(1940)
        , initialDate: initialDate ?? DateTime(1999,2,15),
        lastDate: DateTime.now(), context: context);


  }

  MatrixDatePickerWidget({
    required this.model,
  });
}
