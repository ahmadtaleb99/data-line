import 'dart:io';
import 'package:path/path.dart';


extension NotNullString on String?{
  String orEmpty () => this == null ? '' : this!;

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }
}

extension xInt on int?{
  int orZero () => this == null ? 0 : this!;

  double toMb() => this.orZero() / 1000000;
}
extension xFile on File{
  String getName(){
    return basename(this.path);
  }
}

extension ListExtensions<T> on List<T> {
  bool containsAt(T value, int index) {
    assert(this != null);
    return index >= 0 && this.length > index && this[index] == value;
  }

  List<List<T>> asChunks(int chunkSize){
    List<List<T>> chunksList = [];
    for (var i = 0; i < this.length; i += chunkSize) {
      chunksList.add(this.sublist(i, i+chunkSize > this.length ? this.length : i + chunkSize));
    }
    return chunksList;

  }
}
