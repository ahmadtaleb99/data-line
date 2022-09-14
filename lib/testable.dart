import 'dart:developer';

import 'package:datalines/app/extenstions.dart';

Future<void> main() async {
   final numbers = <int>[1, 2, 3, 4, 5, 6,7];
      var chunks = numbers.asChunks(2);
      print(chunks.toString());
}



