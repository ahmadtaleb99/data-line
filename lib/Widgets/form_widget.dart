import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/form_element_widget.dart';
import 'package:form_builder_test/model/FormModel.dart';
import 'package:form_builder_test/validation/bloc/validation__bloc.dart';

class FormWidget extends FormElementWidget {
  bool validate() {
    // _key.currentState!.reset();
    return _key.currentState!.validate();
  }

  void save() {
    // _key.currentState!.reset();
    _key.currentState!.save();
  }

  final int? submissionID;
  final String label;
  final String name;
  final List<FormElementWidget> fields;

  FormWidget({
    required this.label,
    required this.name,
    required this.fields,
    this.submissionID,
  }) : super(label: label, name: name);

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return Form(
            key: _key,
            child: ListView.builder(
              itemCount: fields.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: this.fields[index],
                )));
      },
    );
  }

//
// FormModel  toFormModel(){
//     return FormModel(name: name, directionality:'', fields: this.fields)
// }

  @override
  String valueToString() {
    return this.value.toString();
  }
}
