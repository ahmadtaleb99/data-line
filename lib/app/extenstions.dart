import 'dart:io';
import 'package:path/path.dart';


extension NotNullString on String?{
  String orEmpty () => this == null ? '' : this!;
}

extension NotEmptyInt on int?{
  int orZero () => this == null ? 0 : this!;
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
}
