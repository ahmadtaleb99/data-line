// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MatrixRadioGroup.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixRadioGroupAdapter extends TypeAdapter<MatrixRadioGroup> {
  @override
  final int typeId = 71;

  @override
  MatrixRadioGroup read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixRadioGroup(
      name: fields[1] as String,
      label: fields[2] as String,
      values: (fields[3] as List).cast<RadioItem>(),
    )..value = fields[4] as dynamic;
  }

  @override
  void write(BinaryWriter writer, MatrixRadioGroup obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(3)
      ..write(obj.values)
      ..writeByte(4)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixRadioGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
