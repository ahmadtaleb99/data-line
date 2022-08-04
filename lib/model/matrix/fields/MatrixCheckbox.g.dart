// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MatrixCheckbox.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatrixCheckboxAdapter extends TypeAdapter<MatrixCheckbox> {
  @override
  final int typeId = 66;

  @override
  MatrixCheckbox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatrixCheckbox(
      name: fields[1] as String,
      label: fields[2] as String,
      value: fields[4] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, MatrixCheckbox obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatrixCheckboxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
