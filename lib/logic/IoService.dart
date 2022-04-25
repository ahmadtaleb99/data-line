import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/services.dart';
import 'package:form_builder_test/dynamic%20form/FormModel.dart';
import 'package:path/path.dart';

import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void copyIsolateFunc(Map data) async{
  SendPort sendPort = data['port'];
  File file = File(data['filePath']);

  var file2 = File(data['newPath']);

  var _readStream = file.openRead();
  int fileLength = file.lengthSync();
  int currentBytesWritten = 0;

  print(fileLength.toString()+' file lengtg');
  var _writeSink = file2.openWrite();
  await for (var bytes in _readStream) {
    currentBytesWritten += bytes.length;
    _writeSink.add(bytes);
    var percentage = 100 * (currentBytesWritten) / (fileLength);
    // yield percentage;
   sendPort.send(percentage);
  }
  sendPort.send('done');
  _writeSink.close();


}
class IoService {


  ReceivePort receivePort = ReceivePort();
  late Directory _appDir;
  late String _base = ' ';
  static const _cacheBase = 'filePickerCache';
   StreamController<double>    _streamController = StreamController.broadcast();
  late IOSink _writeSink;
  late Stream<List<int>> _readStream;
  late Isolate  isolate ;
  late StreamSubscription  streamSubscription ;
  Future<void> init() async {

      streamSubscription = receivePort.listen((message) {
        if(message is String && message == 'done')
          receivePort.close();


      else  _streamController.add(message);

      },onDone: (){
        _streamController.close();
      });


    _appDir = await getApplicationDocumentsDirectory();
    _base = _appDir.path + '/$_cacheBase';

  }


  void cancelCopying () {
    _streamController.close();
    _writeSink.close();

  }
  Future<String> cacheFile(int submissionKey, String formName,
      File file) async {
    String fileName = basename(file.path);
    Directory appDirectory = await getApplicationDocumentsDirectory();


    String newFilePath = '$_base/${submissionKey}-${formName}';

    var newDir = await Directory(newFilePath).create(recursive: true);
    var newPath = '$newFilePath/${fileName}';

    await file.copy(newPath);
    return newPath;
  }

  Future<String?> copyToDownloads(File file) async {



    var downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;

    if (downloadsDirectory == null)
      throw PlatformException(code: '123');

    var fileName = basename(file.path);
    String  newFilePath;

    if (await Permission.storage
        .request()
        .isGranted) {
      newFilePath = downloadsDirectory.path + '/$fileName';

      copyFileWithProgress(file, newFilePath);
      // await file.copy(newFilePath);
      return newFilePath;
    }
  }

  Future<void> deleteSubmissionCache(int id, FormModel formModel) async {
    var dir = Directory(_base + '/${id}-${formModel.name}');
    if (await dir.exists()) await dir.delete(recursive: true);
  }

  void stopCopying(){
    _streamController.close();
    _writeSink.close();

  }
  void downloadFile (){

  }
  void copyFileWithProgress(File file ,String newPath) async {

    final data = {'port': receivePort.sendPort, 'filePath':file.path,'newPath':newPath};
    isolate = await Isolate.spawn(copyIsolateFunc, data);
    print('b4 rp');

    //
    //  streamSubscription = receivePort.listen((progress) {
    //   _streamController.add(progress);
    //
    // });
    //  streamSubscription.cancel();
    // await for (var progress in receivePort){
    //
    //     print('after rp');
    //     _streamController.add(progress);
    //   }
    // isolate.kill();
    // receivePort.close();
    // _streamController.close();

  }


  Stream<double> get  copyProgress => _streamController.stream;
  StreamController<double> get  copyProgressSub => _streamController;
  void closeStream(){
    _streamController.close();
  }

}