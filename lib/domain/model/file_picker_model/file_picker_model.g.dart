// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_picker_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilePickerModelAdapter extends TypeAdapter<FilePickerModel> {
  @override
  final int typeId = 6;

  @override
  FilePickerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilePickerModel(
      maxFileSize: fields[13] as int,
      fileType: fields[14] as FileType,
      name: fields[1] as String,
      label: fields[2] as String,
      showIfFieldName: fields[11] as String,
      showIfFieldValue: fields[12] as String,
      type: fields[3] as FieldType,
      deactivate: fields[4] as bool,
      required: fields[5] as bool,
      isHidden: fields[6] as bool,
      isReadOnly: fields[7] as bool,
      showIfLogicCheckbox: fields[8] as bool,
      showIfIsRequired: fields[9] as bool,
      requiredIfLogicCheckbox: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FilePickerModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(13)
      ..write(obj.maxFileSize)
      ..writeByte(14)
      ..write(obj.fileType)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.deactivate)
      ..writeByte(5)
      ..write(obj.required)
      ..writeByte(6)
      ..write(obj.isHidden)
      ..writeByte(7)
      ..write(obj.isReadOnly)
      ..writeByte(8)
      ..write(obj.showIfLogicCheckbox)
      ..writeByte(9)
      ..write(obj.showIfIsRequired)
      ..writeByte(10)
      ..write(obj.requiredIfLogicCheckbox)
      ..writeByte(11)
      ..write(obj.showIfFieldName)
      ..writeByte(12)
      ..write(obj.showIfFieldValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilePickerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
