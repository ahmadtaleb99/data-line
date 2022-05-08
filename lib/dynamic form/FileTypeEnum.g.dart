// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FileTypeEnum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FileTypeEnumAdapter extends TypeAdapter<FileTypeEnum> {
  @override
  final int typeId = 57;

  @override
  FileTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return FileTypeEnum.IMAGE;
      case 2:
        return FileTypeEnum.TEXT;
      case 3:
        return FileTypeEnum.VIDEO;
      case 4:
        return FileTypeEnum.AUDIO;
      default:
        return FileTypeEnum.IMAGE;
    }
  }

  @override
  void write(BinaryWriter writer, FileTypeEnum obj) {
    switch (obj) {
      case FileTypeEnum.IMAGE:
        writer.writeByte(1);
        break;
      case FileTypeEnum.TEXT:
        writer.writeByte(2);
        break;
      case FileTypeEnum.VIDEO:
        writer.writeByte(3);
        break;
      case FileTypeEnum.AUDIO:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
