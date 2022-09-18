import 'dart:io';

import 'package:dio/dio.dart';

Future<void> main() async {
  final numbers = <int>[1, 2, 3, 4, 5];
  numbers.removeRange(0, 4);
  print(numbers); // [1, 5]
}
