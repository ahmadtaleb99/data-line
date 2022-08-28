// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FieldTypeAdapter extends TypeAdapter<FieldType> {
  @override
  final int typeId = 16;

  @override
  FieldType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return FieldType.TEXT;
      case 2:
        return FieldType.TEXT_AREA;
      case 3:
        return FieldType.NUMBER;
      case 4:
        return FieldType.EMAIL;
      case 5:
        return FieldType.DROPDOWN;
      case 6:
        return FieldType.STAR_RATING;
      case 7:
        return FieldType.CHECKBOX_GROUP;
      case 8:
        return FieldType.CHECKBOX;
      case 9:
        return FieldType.RADIO_GROUP;
      case 10:
        return FieldType.FILE;
      default:
        return FieldType.TEXT;
    }
  }

  @override
  void write(BinaryWriter writer, FieldType obj) {
    switch (obj) {
      case FieldType.TEXT:
        writer.writeByte(1);
        break;
      case FieldType.TEXT_AREA:
        writer.writeByte(2);
        break;
      case FieldType.NUMBER:
        writer.writeByte(3);
        break;
      case FieldType.EMAIL:
        writer.writeByte(4);
        break;
      case FieldType.DROPDOWN:
        writer.writeByte(5);
        break;
      case FieldType.STAR_RATING:
        writer.writeByte(6);
        break;
      case FieldType.CHECKBOX_GROUP:
        writer.writeByte(7);
        break;
      case FieldType.CHECKBOX:
        writer.writeByte(8);
        break;
      case FieldType.RADIO_GROUP:
        writer.writeByte(9);
        break;
      case FieldType.FILE:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OperatorAdapter extends TypeAdapter<Operator> {
  @override
  final int typeId = 19;

  @override
  Operator read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return Operator.MORE;
      case 2:
        return Operator.LESS;
      case 3:
        return Operator.EQUAL;
      case 4:
        return Operator.BETWEEN;
      default:
        return Operator.MORE;
    }
  }

  @override
  void write(BinaryWriter writer, Operator obj) {
    switch (obj) {
      case Operator.MORE:
        writer.writeByte(1);
        break;
      case Operator.LESS:
        writer.writeByte(2);
        break;
      case Operator.EQUAL:
        writer.writeByte(3);
        break;
      case Operator.BETWEEN:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OperatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FileTypeAdapter extends TypeAdapter<FileType> {
  @override
  final int typeId = 20;

  @override
  FileType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return FileType.IMAGE;
      case 2:
        return FileType.AUDIO;
      case 3:
        return FileType.VIDEO;
      default:
        return FileType.IMAGE;
    }
  }

  @override
  void write(BinaryWriter writer, FileType obj) {
    switch (obj) {
      case FileType.IMAGE:
        writer.writeByte(1);
        break;
      case FileType.AUDIO:
        writer.writeByte(2);
        break;
      case FileType.VIDEO:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FileTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
