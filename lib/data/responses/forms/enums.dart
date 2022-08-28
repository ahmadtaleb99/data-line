import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:file_picker/file_picker.dart' as fp;

part 'enums.g.dart';

@HiveType(typeId: 16)
enum FieldType {

  @HiveField(1)
  @JsonValue('text')
  TEXT,


  @HiveField(2)
  @JsonValue('textarea')
  TEXT_AREA,


  @HiveField(3)
  @JsonValue('number')
  NUMBER,



  @HiveField(4)
  @JsonValue('email')
  EMAIL,


  @HiveField(5)
  @JsonValue('select')
  DROPDOWN,


  @HiveField(6)
  @JsonValue('starrating')
  STAR_RATING,


  @HiveField(7)
  @JsonValue('checkbox-group')
  CHECKBOX_GROUP,


  @HiveField(8)
  @JsonValue('checkbox')
  CHECKBOX,


  @HiveField(9)
  @JsonValue('radio-group')
  RADIO_GROUP,


  @HiveField(10)
  @JsonValue('file')
  FILE,
  UNKNOWN
}


@HiveType(typeId: 19)
enum Operator {
  @HiveField(1)
  @JsonValue('more')
  MORE,

  @JsonValue('less')
  @HiveField(2)
  LESS,

  @JsonValue('equal')
  @HiveField(3)
  EQUAL,

  @JsonValue('between')
  @HiveField(4)
  BETWEEN


}

@HiveType(typeId: 20)
enum FileType {
  @HiveField(1)
  @JsonValue('Image')
  IMAGE,

  @JsonValue('Audio')
  @HiveField(2)
  AUDIO,

  @JsonValue('Video')
  @HiveField(3)
  VIDEO,
  CUSTOM



}

extension xFileType on FileType{
  fp.FileType getFilePickerPackageEnum() {
    switch(this){

      case FileType.IMAGE:
       return fp.FileType.image;
        break;
      case FileType.AUDIO:
        return fp.FileType.audio;

        break;
      case FileType.VIDEO:
        return fp.FileType.video;

        break;
      case FileType.CUSTOM:
        return fp.FileType.custom;

        break;
    }
  }

}
