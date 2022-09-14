import 'dart:io';

import 'package:dio/dio.dart';

Future<void> main() async {
  var file =
      File('');
  print(file.existsSync());
  final dio = Dio();
  var formData = FormData.fromMap({
    'name': 'wendux',
    'age': 25,
    'file': await MultipartFile.fromFile(
        '1.jpg')
  });
  var response =
      await dio.post('https://ahmdataleb.mocklab.io/sync-form', data: formData);

  print(response.toString());
}
