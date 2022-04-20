import 'dart:io';

import 'dart:typed_data';

Future<void> main() async {
  var file = File('assets/ahmad.txt');
  var bytes = await _readFileByte(file.path);
  file.openRead().listen((event) {
    // bytes.addAll(event);
    print(event);
  });
  var newFile = File('assets/sdsss.jpg');
 newFile.writeAsBytes(bytes.toList());


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
  RandomAccessFile fileOpen = await file.open(mode: FileMode.read);

  int count = 0;
  List<int> bytes = [];
  int byte = 0;

  while (byte != -1 && count < len) {
    byte = fileOpen.readByteSync();
    bytes.add(byte);
    count++;
  }

  await fileOpen.close();
  return Uint8List.fromList(bytes);
}

Future<Uint8List> _readFileByte(String filePath) async {
  File audioFile = new File(filePath);
  late Uint8List bytes;
  await audioFile.readAsBytes().then((value) {
    for (var kza in value) print(kza);
    bytes = Uint8List.fromList(value);
    print('reading of bytes is completed');
  }).catchError((onError) {
    print(
        'Exception Error while reading audio from path:' + onError.toString());
  });
  return bytes;
}
