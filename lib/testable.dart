
import 'dart:io';
import 'dart:isolate';

import 'package:equatable/equatable.dart';

Future<void> main() async {
  // ReceivePort receivePort = ReceivePort();
  // late Isolate  isolate ;
  //
  // final data = {'port': receivePort.sendPort, };
  // isolate = await Isolate.spawn(writeToFile, data);
  //     receivePort.listen((message) {
  //       print(message.toString());
  //     });
var file = File('2.txt');
var array = await file.readAsString();

print(array.length);
}

var array = [

];

class Person extends Equatable{

   String name = 'asd';

  Person(this.name);

  @override
  // TODO: implement props
  List<Object?> get props => [name];

}

void writeToFile(Map data) async{
  SendPort sendPort = data['port'];

  final file = await File('2.txt').create();
  var sink = file.openWrite();
  for(int i = 0; i< 10000000;i++){
    sink.write(i);
  }

  sink.close();


  sendPort.send('done');
}