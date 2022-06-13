import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_test/Widgets/FormFieldWidget.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import 'package:form_builder_test/logic/validation__bloc.dart';
import '../IDrawable.dart';

class MatrixWidget extends FormElementWidget {
  MatrixWidget(
      {Key? key,
      required this.label,
      required this.visible,
      required this.required,
      required this.name,
      this.value,
    // required   this.records,
      required this.showIfValueSelected,
      required this.showIfFieldValue,
      required this.showIfIsRequired,
      required this.maxRecordCount,
      required this.fields})
      : super(
            label: label,
            key: key,
            name: name,
            visible: visible,
            required: required,
            showIfValueSelected: showIfValueSelected,
            showIfFieldValue: showIfFieldValue,
            showIfIsRequired: showIfIsRequired);

  final String label;
  final String name;
  final bool required;
  dynamic value;
  bool? visible;

  final bool showIfValueSelected;
  final String? showIfFieldValue;
  final bool? showIfIsRequired;
  final int maxRecordCount;
  final List<FormElementWidget> fields;

  List<MatrixRecord> records = [];

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return FormFieldWidget(
            visible: visible,
            required: required,
            widget: Column(
              children: [
                ...buildItems()
              ],
            )
        );
      },
    );
  }



  List<MatrixRecord> buildItems(){
    if(records.isEmpty){
      records.add(MatrixRecord(isLast: true, children: this.fields));
    }
    return records;
  }

  @override
  String valueToString() {
    return this.value.toString();
  }


}

Widget setupAlertDialoadContainer(List children) {
  return Container(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding:  EdgeInsets.all(10),
          child: children[index],
        );
      },
    ),
  );
}

class MatrixRecord extends StatelessWidget {
  MatrixRecord({Key? key, required this.isLast,required this.children}) : super(key: key);
  bool isLast = true;
   List<FormElementWidget> children;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ValidationBloc, ValidationState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 0, top: 4),
                child: Container(
                  height: 50,
                  width: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    elevation: 10,
                    child: ListTile(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Add'),
                                content: setupAlertDialoadContainer(children),
                                actions: [
                            Row(

                             mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                                ElevatedButton(onPressed: (){
                                Form.of(context)!.validate();
                                }, child: Text('submit')),
                                ElevatedButton(onPressed: () => Navigator.pop(context), child: Text('cancel'))
                              ],
                            )
                                ],
                              );
                            });
                      },

                      trailing: Text('asd'),
                      leading: Text('children.first.name'),
                    ),
                  ),
                ),
              ),
            ),
            if (isLast)
              IconButton(
                  onPressed: () {
                    context
                        .read<ValidationBloc>()
                        .add(RecordAdded(matrixName: 'matrix_1655016823189'));
                  },
                  icon: Icon(Icons.add_circle))
            else
              IconButton(
                  onPressed: () {
                    context
                        .read<ValidationBloc>()
                        .add(RecordRemoved(matrixName: 'matrix_1655016823189',matrixRecord: this));
                  },
                  icon: Icon(Icons.remove))
          ],
        );
      },
    );
  }
}
