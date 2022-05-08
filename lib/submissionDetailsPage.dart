import 'dart:ui';
import 'logic/validation__bloc.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawFilePicker.dart';
import 'package:form_builder_test/Widgets/DrawForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmittionsDetailsPage extends StatelessWidget {


  FormWidget formWidget;
  SubmittionsDetailsPage({Key? key, required this.formWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Details'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                dataRowHeight: 70,
                columnSpacing: 100,
                columns: [
                  DataColumn(label: Text('Field')),
                  DataColumn(label: Text('Value')),
                ],
                rows: _buildRows(formWidget,context),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

List<DataRow> _buildRows(FormWidget formWidget,BuildContext context) {

  List<DataRow> rows = [];
  for (var field in formWidget.fields) {
    if (field.value != null) {
      rows.add(DataRow(cells: [
        DataCell(Text(field.label, style: TextStyle(fontSize: 15))),
        DataCell((field is DrawFilePicker)
            ? ElevatedButton(
                onPressed: () async {
                  context.read<ValidationBloc>().add(FilePreviewRequested(path: field.value));

                },
                child: Text('download file'))
            : ConstrainedBox(
                constraints: BoxConstraints(minWidth: 10, maxWidth: 250),
                child: Text(field.valueToString(),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold)),
              ))
      ]));
    }
  }

  return rows;
}
