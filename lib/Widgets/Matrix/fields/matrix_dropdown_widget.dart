import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/model/DropDownItem.dart';
import 'package:form_builder_test/model/matrix/fields/MatrixDropDown.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';
import '../../form_element_widget.dart';
import '../cubit/matrix_record_cubit.dart';

class MatrixDropDownWidget extends FormElementWidget {
  final String label;
  final String name;
  dynamic value;
  final List<DropDownItem> values;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 10, top: 10),
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(40)),
            border: Border.all(
              color: Colors.blue,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<MatrixRecordCubit, MatrixRecordState>(
              builder: (context, state) {
                var selectedValue;
                // if(state.currentRecord != null )
                //  selectedValue=  state.currentRecord!.fields.firstWhere((element) => element.name == this.name).value;
                //
                // else selectedValue = this.value;

                return DropdownButton<String>(
                  isDense: true,

                  items: values
                      .map((e) =>
                      DropdownMenuItem<String>(


                        child: Text(e.value),
                        value: e.value,
                      ))
                      .toList(),
                  onChanged: (value) {
                    context.read<MatrixRecordCubit>().fieldValueChanged(value, name);
                    this.value = value;
                  },
                  value: value,
                  underline: Container(),
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 99),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                  hint: Text('select a $label'),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  MatrixDropDownWidget({required this.label,
    required this.name,
    required this.value,
    required this.values})
      : super(label: label, name: name);

  MatrixDropDown toModel() {
    return MatrixDropDown(label: label, values: values, name: name,value:value);
  }

  @override
  String? valueToString() {
    // TODO: implement valueToString
    return this.value;
  }
}
