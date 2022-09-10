import 'dart:developer';

Future<void> main() async {
   final numbers = <int>[1, 2, 3, 5, 6, 7];
   final   result = numbers.where((x) => x > 8).toList(); // (6, 7)
}



