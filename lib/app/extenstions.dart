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

