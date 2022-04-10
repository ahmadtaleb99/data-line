import 'package:flutter/material.dart';
import 'package:form_builder_test/Widgets/DrawForm.dart';

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
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Field')),
            DataColumn(label: Text('Value'))
          ],
          rows: _buildRows(formWidget),
        ),
      ),
    );
  }
}


List<DataRow> _buildRows(FormWidget formWidget){
  List<DataRow> rows = [ ] ;
  for(var field in  formWidget.fields){
    if(field.value != null){
     rows.add(DataRow(cells: [
       DataCell(Text(field.label)),
       DataCell(Text(field.value.toString()))
     ]));
    }
  }
  
  return rows;
}