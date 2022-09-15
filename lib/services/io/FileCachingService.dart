import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:datalines/data/network/error_handler.dart';
import 'package:datalines/data/network/failure.dart';
import 'package:datalines/presentation/resources/strings_manager.dart';
import 'package:path/path.dart';

import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
 const String _copyFinish = 'copyFinish';

void copyIsolateFunc(Map data) async{
  SendPort sendPort = data['port'];
  File file = File(data['filePath']);

  var file2 = File(data['newPath']);
try {
  var _readStream = file.openRead();
  int fileLength = await file.length();
  int currentBytesWritten = 0;

  var _writeSink = file2.openWrite();
  await for (var bytes in _readStream) {
    currentBytesWritten += bytes.length;
    _writeSink.add(bytes);
    var percentage = 100 * (currentBytesWritten) / (fileLength);
      // print(percentage);

    sendPort.send(percentage);

  }


  await _writeSink.close();
  sendPort.send(_copyFinish);
}
catch  (e){

  sendPort.send(_copyFinish);
  print(e.toString());

}


}
class FileCachingService {


 late ReceivePort receivePort;
  late Directory _appDir;
  late String _base ;
  static const _cacheBase = 'filePickerCache';
   StreamController<double>    _streamController = StreamController.broadcast();
  late IOSink _writeSink;
  late Isolate  isolate ;

void _listenToPort(){

  receivePort.listen((message) {
    if(message is String && message == _copyFinish) {
      dispose();

    } else  _streamController.sink.add(message);

  });
}
  Future<void> init() async {





    _appDir = await getApplicationDocumentsDirectory();
    _base = _appDir.path + '/$_cacheBase';

  }


  void cancelCopying () {
    _streamController.close();
    _writeSink.close();

  }
 Future<String> cacheFile(File file,String fileToCachePath) async {
    /*caching picked file to appDirectory/filePickerCache/submissionId-formId
    example: app dir -> /data/'app name'/app-flutter/filePickerCache/5-Third Form/
     */

    try{
      String fileName = basename(file.path);


      String newFilePath = '$_base/$fileToCachePath';

      var newDir = await Directory(newFilePath).create(recursive: true);
      var newPath = '$newFilePath/${fileName}';

      await file.copy(newPath);
      return newPath;
    }
    catch (e){
     throw CacheException('cant cache file ');
    }

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
      return newFilePath;
    }
  }

  Future<void> deleteSubmissionCache(String path) async {

    log((_base + path));
    var dir = Directory(_base + path);
    if (await dir.exists()) await dir.delete(recursive: true);
  }

  void stopCopying(){
    _writeSink.close();
    _streamController.close();

  }
  void downloadFile (){

  }
  void copyFileWithProgress(File file ,String newPath) async {
    receivePort  = ReceivePort();
    _listenToPort();

    _streamController = StreamController.broadcast();

    final data = {'port': receivePort.sendPort, 'filePath':file.path,'newPath':newPath};
    Isolate.spawn(copyIsolateFunc, data,);

  }


  Stream<double> get  copyProgress => _streamController.stream;
  void dispose(){
    _streamController.close();
  }

}