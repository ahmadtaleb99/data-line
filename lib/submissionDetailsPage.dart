import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:form_builder_test/Widgets/DrawFilePicker.dart';
import 'package:form_builder_test/Widgets/DrawForm.dart';
import 'package:form_builder_test/Widgets/DrawRadioGroup.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
                rows: _buildRows(formWidget),
              ),
            ),
          ),
        ],
      ),
    );
  }


}

List<DataRow> _buildRows(FormWidget formWidget) {

  List<DataRow> rows = [];
  for (var field in formWidget.fields) {
    if (field.value != null) {
      rows.add(DataRow(cells: [
        DataCell(Text(field.label, style: TextStyle(fontSize: 15))),
        DataCell((field is DrawFilePicker)
            ? ElevatedButton(
                onPressed: () async {
                  log('asd');
                  final dir = await getExternalStorageDirectory();
                  if (await Permission.storage.request().isGranted) {
                    final taskId = await FlutterDownloader.enqueue(
                      url:
                          'https://upload.wikimedia.org/wikipedia/commons/b/b2/Sand_Dunes_in_Death_Valley_National_Park.jpg',
                      savedDir: dir!.path,
                      fileName: 'download',
                      showNotification: true, // show download progress in status bar (for Android)
                      openFileFromNotification:
                          true, // click on notification to open downloaded file (for Android)
                    );
                  } else {
                    log('not granted');
                  }
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
