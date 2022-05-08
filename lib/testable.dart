import 'dart:io';
import 'package:path/path.dart';

import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';


Future<void> main() async {
  var file = File('assets/xd.rar');
  var file2 = File('assets/22.rar');
  Stream<List<int>> stream = file.openRead();
  int fileLength =  file.lengthSync();
  int currentBytesWritten = 0;

  print(fileLength);
  IOSink  writeSink = file2.openWrite();
  await for (var bytes in stream){
    currentBytesWritten += bytes.length;
    writeSink.add(bytes);
    print('${100*(currentBytesWritten)/(fileLength)}');
  }
  // stream.listen((event) {
  //
  //   sink.add(event);
  //
  // });
  // sink.addStream(stream);
  // stream.listen((event) async {
  //   // print(event);
  //      file2.writeAsBytes(event,mode: FileMode.append);
  //
  // });
  // await for(var bytes in stream) {
  //
  //   stdout.write(bytes);
  //   await file2.writeAsBytes(bytes,mode: FileMode.append);
  // }

  // var bytess = await _readFileByte(file.path);
  // var bytsess = await readFileBytes(file.path,file.lengthSync());
  // file.openRead().listen((event) {
  //   // bytes.addAll(event);
  //   print(event);
  // });
  //
  // var bytes = bytess.toList();
  // var newFile = File('assets/32aasd3.jpg');
  //
  // var chunck2 = [];
  // for(int i = 0 ; i< bytes.length;i++){
  //    // chunck2= bytes.sublist(chunck2.);
  //
  // }
  //
  // newFile.writeAsBytes(bytes,mode: FileMode.append);
  //

//   print(await file.length());
//  var rawPath =  await readFileBytes(file.path,await file.length());
// // print(rawPath.toString());
//   await file.copy('assets/newwwwwwwww.jpg');
//   // var newFile = File('assets/22.jpg');
//   //
//   // await newFile.writeAsBytes(rawPath);
//   // await newFile.copy('assets/sda.txt');
//   print('dor : : :A :SAD :ASD: ');
}

Future<Uint8List> readFileBytes(String path, int len) async {
  final File file = File(path);
  // final File file1 = File('assets/2.jpg');
  RandomAccessFile fileOpen = await file.open(mode: FileMode.read);
  // RandomAccessFile fileWrite = await file1.open(mode: FileMode.write);

  int count = 0;
  List<int> bytes = [];
  int byte = 0;

  while (byte != -1 && count < len) {
    // byte = await   fileOpen.readIntoSync(buffer);
     // fileWrite.writeByteSync(byte);
    bytes.add(byte);
    count++;
  }

  await fileOpen.close();
  // await fileWrite.close();

  return Uint8List.fromList(bytes);
}



Future<Uint8List> _readFileByte(String filePath) async {
  File audioFile = new File(filePath);
  late Uint8List bytes;
  await audioFile.readAsBytes().then((value) {
    // for (var kza in value) print(kza);
    bytes = Uint8List.fromList(value);
    var length = bytes.length;
    var chunk = length / 5 ;
    // for(int i = 0 ; i<length ; i+= chunk )
    print('reading of bytes is completed');
  }).catchError((onError) {
    print(
        'Exception Error while reading audio from path:' + onError.toString());
  });
  return bytes;
}
